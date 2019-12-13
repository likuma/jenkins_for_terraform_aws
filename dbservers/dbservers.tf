#For Atos community - mysql and postgersql servers
resource "aws_instance" "db_mysql_server" {
  ami           = "ami-0badcc5b522737046"
  instance_type = "t2.micro"
  tags = {
    Name = "db_mysql_server"
  }
  subnet_id                   = data.aws_subnet.subnet_for_database_servers_attrs.id
  vpc_security_group_ids      = [data.aws_security_group.sec_group_for_database_attrs.id]
  associate_public_ip_address = true
  key_name                    = "key_com_http"
  user_data                   = <<-EOF
                #!/bin/bash
                yum update -y
                yum install mysql-server -y
                systemctl start mysqld
                systemctl enable  mysqld
  EOF
}
#For Atos community - mysql and postgersql servers
resource "aws_instance" "db_postgresql_server" {
  ami           = "ami-0badcc5b522737046"
  instance_type = "t2.micro"
  tags = {
    Name = "db_postgresql_server"
  }
  subnet_id                   = data.aws_subnet.subnet_for_database_servers_attrs.id
  vpc_security_group_ids      = [data.aws_security_group.sec_group_for_database_attrs.id]
  associate_public_ip_address = true
  key_name                    = "key_com_http"
  user_data                   = <<-EOF
                #!/bin/bash
                yum update -y
                yum install postgresql-server -y
                /usr/bin/postgresql-setup --initdb
                systemctl start  postgresql
                systemctl enable  postgresql

  EOF
}