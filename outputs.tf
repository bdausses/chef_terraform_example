# List Outputs
output "Example-node-IP-address" {
   value = "${aws_instance.chef_provisioner_example.public_ip}"
}
