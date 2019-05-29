# AWS Region
variable "region" {
  default = "us-east-2" # Ohio
}

# Key Name - The name of your key at AWS.
variable "key_name" {}

# Instance Key - The local copy of your key file.
variable "instance_key" {
  default = "~/.ssh/id_rsa"
}

# Define Common Tags and put them in a map.  These will be used to tag the
# instance at AWS.
variable "tag_application" {}
variable "tag_contact" {}
variable "tag_customer" {}
variable "tag_dept" {}
variable "tag_production" {}
variable "tag_project" {}
variable "tag_sleep" {}
variable "tag_ttl" {}

locals {
  common_tags = "${map(
    "X-Application", "${var.tag_application}",
    "X-Contact", "${var.tag_contact}",
    "X-Customer", "${var.tag_customer}",
    "X-Dept", "${var.tag_dept}",
    "X-Production", "${var.tag_production}",
    "X-Project", "${var.tag_project}",
    "X-Sleep", "${var.tag_sleep}",
    "X-TTL", "${var.tag_ttl}",
  )}"
}

# Define Chef variables
# Chef Server - This is the URL of your Chef server
variable "chef_server" {}
# Chef User - This is the username on your Chef server.  NOTE:  This user will
# be used to bootstrap the instance and must have the permissions required to
# do so.
variable "chef_user" {}
# Chef User Key - This is the key that is used to authenticate the chef_user
# above.  This example is referencing a local key file that is temporarily
# copied to the node for bootstrap purposes and then deleted.
variable "chef_user_key" {}
