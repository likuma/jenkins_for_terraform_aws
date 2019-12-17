resource "aws_instance" "http_server" {
  ami           = "ami-0badcc5b522737046"
  instance_type = "t2.micro"
  tags = {
    Name = "Http server"
  }
  subnet_id                   = "subnet-0c324d5a584a288ef"
  vpc_security_group_ids      = ["sg-0cc9a28e6d3fca5d5"]
  associate_public_ip_address = true
  key_name                    = "key_com_http"
  user_data                   = <<-EOF
		#! /bin/bash
                yum update -y
		yum install httpd -y
		echo "Server is running" >>  /var/www/html/index.html
		systemctl start httpd
                systemctl enable httpd
                chkconfig httpd on
                yum install php php-mysqlnd php-cli -y
                systemctl restart http
                
  EOF
}
