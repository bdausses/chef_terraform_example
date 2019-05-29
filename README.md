# Chef Terraform Example
This repo contains terraform code that will spin up an example server in AWS and then bootstrap that server to a pre-existing Chef server.

**DISCLAIMER**:  This code is an example only.  There are most certainly optimizations that can and should be made if you are going to use this to spin up a server for actual usage.

*Translation*:  YMMV, and do your due dilligence if you are going to use this for anything other than an example.
## Authentication Note
This plan assumes that you are using environment variables for your authentication to the AWS API.  More info available here:  https://www.terraform.io/docs/providers/aws/index.html

## Usage
- Copy terraform.tfvars.example to terraform.tfvars.
  - `cp terraform.tfvars.example terraform.tfvars`
- Edit terraform.tfvars and use whatever values you need/desire.
  - `vi terraform.tfvars`
- Initialize and apply the plan.
  - `terraform init`
  - `terraform apply`

## License
This is licensed under [the Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0).
