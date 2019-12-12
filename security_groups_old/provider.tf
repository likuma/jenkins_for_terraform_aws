provider "aws" {
  region = var.AWS_REGION
}

data "aws_vpc" "default_vpc_attrs" {
  tags = {
    Name = "default"
  }
}
output "default_vpc_attrs_out" {
  value = data.aws_vpc.default_vpc_attrs.*
}

