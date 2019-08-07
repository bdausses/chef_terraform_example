# Set AWS region
provider "aws" {
  region     = "${var.region}"
}

# Find the most recent CentOS 7 AMI
data "aws_ami" "centos" {
  most_recent = true
  owners = ["679593333241"]
  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "product-code"
    values = ["aw0evgkw8e5c1q413zgy5pjce"]
  }
}

# Create Security Group - This example allows all inbound and outbound traffic.  You should probably lock
# this down better for an actual use case.
resource "random_id" "security_group_id" {
  byte_length = 4
}

resource "aws_security_group" "allow-all" {
  name        = "${random_id.security_group_id.dec}-allow-all"
  description = "Allow all inbound/outbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

# Create AWS instance
resource "aws_instance" "chef_provisioner_example" {
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"
  security_groups = ["${random_id.security_group_id.dec}-allow-all"]
  tags = "${merge(
  local.common_tags,
  map(
    "Name", "${lookup(local.common_tags, "X-Contact")}_${lookup(local.common_tags, "X-Project")}_example",
    "X-Role", "Example Server"
    )
  )}"
  provisioner "chef" {
    attributes_json = <<EOF
      {
        "chef-client": {
          "interval": 600

          }
        }
    EOF

    environment     = "_default"
    run_list        = ["chef-client::default"]
    node_name       = "example_server_1"
    server_url      = "${var.chef_server}"
    recreate_client = true
    user_name       = "${var.chef_user}"
    user_key        = "${file(var.chef_user_key)}"
    version         = "14.12.9"
    # If you have a self signed cert on your chef server change this to :verify_none
    ssl_verify_mode = ":verify_none"

    connection {
      host        ="${aws_instance.chef_provisioner_example.public_ip}"
      user           = "centos"
      private_key    = "${file("${var.instance_key}")}"
    }
  }
}
