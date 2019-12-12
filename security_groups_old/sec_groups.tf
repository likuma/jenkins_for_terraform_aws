#Security group for http servers
resource "aws_security_group" "sec_group_for_http_and_ssh_icmp" {
  vpc_id      = data.aws_vpc.aws_vpc_default_attrs.id
  name        = "sec_group_for_http_and_ssh_icmp"
  description = "sec_group_for_http_and_ssh_icmp"

  ingress {
    to_port     = 80 #http port
    from_port   = 80
    protocol    = "tcp"
    cidr_blocks = var.INGRESS_CIDR_BLOCKS
  }

  ingress {
    to_port     = 22 #ssh port
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = var.INGRESS_CIDR_BLOCKS
  }

  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    cidr_blocks     = ["0.0.0.0/0"]
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

