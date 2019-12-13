#Security group for http servers
resource "aws_security_group" "sec_group_for_http_and_ssh_icmp" {
  vpc_id      = data.aws_vpc.default_vpc_attrs.id #data selected in vars.tf
  name        = "sec_group_for_http_and_ssh_icmp"
  description = "sec_group_for_http_and_ssh_icmp"

  ingress {
    to_port     = 80 #http port
    from_port   = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    to_port     = 22 #ssh port
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp" # for ping 
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    to_port     = 8080 #http port for jenkins
    from_port   = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sec_group_for_http_and_ssh_icmp"
  }
}


#sec group for mySQL and PostgreSQL 

resource "aws_security_group" "sec_group_for_database" {
  vpc_id      = data.aws_vpc.default_vpc_attrs.id #data selected in vars.tf
  name        = "sec_group_for_http_and_ssh_icmp"
  description = "sec_group_for_http_and_ssh_icmp"

  ingress {
    to_port     = 22 #ssh port
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp" # for ping 
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    to_port     = 3306  # port for mysql db server
    from_port   = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    to_port     = 5432  # port for postgresql db server
    from_port   = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sec_group_for_database"
  }
}

