#Subnet definition for httpd servers
resource "aws_subnet" "subnet_for_http_servers" {
  vpc_id     = data.aws_vpc.default_vpc_attrs.id
  cidr_block = var.CIDR_BLOCK_HTTPD
  tags = {
    Name = "subnet_for_http_servers"
  }
}

#Subnet definition for database servers
resource "aws_subnet" "subnet_for_database_servers" {
  vpc_id     = data.aws_vpc.default_vpc_attrs.id
  cidr_block = var.CIDR_BLOCK_DB
  tags = {
    Name = "subnet_for_database_servers"
  }
}

#Subnet definition for non-prod servers
resource "aws_subnet" "subnet_for_non_prod_servers" {
  vpc_id     = data.aws_vpc.default_vpc_attrs.id
  cidr_block = var.CIDR_BLOCK_NON_PROD
  tags = {
    Name = "subnet_for_non_prod_servers"
  }
}
#Subnet definition for management servers
resource "aws_subnet" "subnet_for_mgmnt_servers" {
  vpc_id     = data.aws_vpc.default_vpc_attrs.id
  cidr_block = var.CIDR_BLOCK_MGMNT_PROD
  tags = {
    Name = "subnet_for_mgmnt_servers"
  }
}
