variable "AWS_REGION" {
  default = "eu-central-1"
}
variable "DEFAULT_VPC_ID" {
  default = "vpc-0b0e0d07c070958e4"
}
variable "CIDR_BLOCK_HTTPD" {
  default = "172.31.64.0/24"
}
variable "CIDR_BLOCK_DB" {
  default = "172.31.65.0/24"
}
variable "CIDR_BLOCK_NON_PROD" {
  default = "172.31.66.0/24"
}

variable "CIDR_BLOCK_MGMNT_PROD" {
  default = "172.31.67.0/24"
}


#select aws_vpc_id, tags for vpc must be default_vpc
data "aws_vpc" "default_vpc_attrs" {
  tags = {
    Name = "default_vpc"
  }
}
# prints all default vpc attrs
#output "default_vpc_attrs_out" {
#  value = data.aws_vpc.default_vpc_attrs.*
#}

