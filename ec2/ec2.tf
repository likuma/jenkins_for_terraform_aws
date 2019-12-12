#For testing creation 
resource "aws_instance" "http_server_for_test" {
  ami           = "ami-0badcc5b522737046"
  instance_type = "t2.micro"
  tags = {
    Name = "http_server_for_test"
  }
  subnet_id                   = data.aws_subnet.subnet_for_http_servers_attrs.id
  vpc_security_group_ids      = [data.aws_security_group.sec_group_for_http_and_ssh_icmp_attrs.id]
  associate_public_ip_address = true
  key_name                    = "key_com_http"
  user_data                   = <<-EOF
		#! /bin/bash
                yum update -y
 		yum install httpd -y
 		echo "Server is running" >>  /var/www/html/index.html
		service httpd start
                chkconfig httpd on
  EOF
}
