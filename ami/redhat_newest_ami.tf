resource "aws_instance" "redhat_server_with_the_newest_ami" {
  ami = data.aws_ami.ami_redhat_most_recent.id
  instance_type = "t2.micro"
  vpc_security_group_ids      = [data.aws_security_group.sec_group_for_http_and_ssh_icmp_attrs.id]
  subnet_id                   = data.aws_subnet.subnet_for_http_servers_attrs.id
  associate_public_ip_address = true
  key_name                    = "key_com_http"
  tags = {
    Name = "redhat_server_with_the_newest_ami"
  }
}

