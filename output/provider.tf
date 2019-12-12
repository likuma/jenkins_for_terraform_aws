provider "aws" {
  region = var.AWS_REGION
}

data "aws_vpc" "default_vpc_attrs" {
  tags = {
    Name = "default_vpc"
  }
}
output "default_vpc_attrs_out" {
  value = data.aws_vpc.default_vpc_attrs.*
}

output "default_vpc_attrs_out_id" {
  value = data.aws_vpc.default_vpc_attrs.id
}

#select aws_instance attrs
data "aws_instance" "aws_instance_attrs" {
  instance_tags = {
    Name = "http_server_with_ssh_icmp"
  }
}

#print aws_instance_attrs
output "aws_instance_attrs_out" {
  value = data.aws_instance.aws_instance_attrs.*
}


