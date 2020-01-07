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

variable "INGRESS_CIDR_BLOCKS" {
  default = ["0.0.0.0/0"]
}

#select aws_subnet for subnet_for_http_servers
data "aws_subnet" "subnet_for_http_servers_attrs" {
  tags = {
    Name = "subnet_for_http_servers"
  }
}

#prints all subnets attrs
output "subnet_for_http_servers_attrs_out" {
  value = data.aws_subnet.subnet_for_http_servers_attrs.id
}

#select aws_subnet for subnet_for_mgmnt_servers
data "aws_subnet" "subnet_for_mgmnt_servers_attrs" {
  tags = {
    Name = "subnet_for_mgmnt_servers"
  }
}

#prints subnet_for_mgmnt_servers id
output "subnet_for_mgmnt_servers_attrs_out" {
  value = data.aws_subnet.subnet_for_mgmnt_servers_attrs.id
}

#select aws_subnet for subnet_for_database_servers
data "aws_subnet" "subnet_for_database_servers_attrs" {
  tags = {
    Name = "subnet_for_database_servers"
  }
}

#prints subnet_for_database_servers id
output "subnet_for_database_servers_attrs_out" {
  value = data.aws_subnet.subnet_for_database_servers_attrs.id
}

#select aws_security_group for sec_group_for_http_and_ssh_icmp
data "aws_security_group" "sec_group_for_http_and_ssh_icmp_attrs" {
  tags = {
    Name = "sec_group_for_http_and_ssh_icmp"
  }
}

#prints all secuirty group attrs
output "sec_group_for_http_and_ssh_icmp_attrs_out" {
  value = data.aws_security_group.sec_group_for_http_and_ssh_icmp_attrs.id
}

#select aws_security_group for sec_group_for_database
data "aws_security_group" "sec_group_for_database_attrs" {
  tags = {
    Name = "sec_group_for_database"
  }
}

#prints all secuirty group attrs
output "sec_group_for_database_attrs_out" {
  value = data.aws_security_group.sec_group_for_database_attrs.id
}


#select aws_configure_for_jenkins_instance_profile
data "aws_iam_instance_profile" "aws_configure_for_jenkins_instance_profile_attrs" {
    name = "aws_configure_for_jenkins_instance_profile"
}

#select most recent ami for redhat
data "aws_ami" "ami_redhat_most_recent" {
  most_recent = true
  owners = ["309956199498"]
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

output "ami_redhat_most_recent_out" {
  value = data.aws_ami.ami_redhat_most_recent.*
}
#instances coount for elb
variable "INSTANCE_COUNT" {
  default = 2
}
  
#counter
variable "COUNTER" {
  default = 0
}
#max and min size for autoscalling
variable "MIN_SIZE" {
  default = 1
}
variable "MAX_SIZE" {
  default = 3
} 
variable "DESIERD_CAPACITY" {
  default = 2
}
