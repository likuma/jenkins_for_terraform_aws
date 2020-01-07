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
                yum install bind-utils -y
                systemctl start mysqld
                #systemctl enable  mysqld
                chkconfig mysqld on
                mysql -e "CREATE USER 'ruser'@'%' IDENTIFIED BY 'newpass'"
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
                yum install bind-utils -y
                sed -i "s/SELINUX=enforcing/SELINUX=permissive/" /etc/sysconfig/selinux
                setenforce 0
                /usr/bin/postgresql-setup --initdb
                systemctl start  postgresql
                #systemctl enable  postgresql
                chkconfig postgresql on
                cp /var/lib/pgsql/data/pg_hba.conf /var/lib/pgsql/data/pg_hba.conf_org
                cp /var/lib/pgsql/data/postgresql.conf /var/lib/pgsql/data/postgresql.conf_org
                echo  "listen_addresses = '*'" >> /var/lib/pgsql/data/postgresql.conf
                #sudo -i -u postgres psql -c "drop  table hba;"
                sudo -i -u postgres psql -c "create table hba ( lines text );"
                sudo -i -u postgres psql -c "copy hba from '/var/lib/pgsql/data/pg_hba.conf';"
                sudo -i -u postgres psql -c "update hba set lines = '#local   all             all                                     peer'  where lines ='local   all             all                                     peer';"
                sudo -i -u postgres psql -c "update hba set lines = '#host    all             all             ::1/128                 ident'  where lines ='host    all             all             ::1/128                 ident';"
                sudo -i -u postgres psql -c "insert into hba (lines) values ('local   all             postgres                                peer');"
                sudo -i -u postgres psql -c "insert into hba (lines) values ('local   all             ruser                                     md5');"
                sudo -i -u postgres psql -c "insert into hba (lines) values ('local   all             all                                     peer');"
                sudo -i -u postgres psql -c "insert into hba (lines) values ('host    all             all              0.0.0.0/0              md5');"
                sudo -i -u postgres psql -c "copy hba to  '/var/lib/pgsql/data/pg_hba.conf';"
                sudo -i -u postgres psql -c "select pg_reload_conf();"
                sudo -i -u postgres psql -c "CREATE USER ruser  WITH PASSWORD 'newpass';"
                systemctl stop  postgresql
                systemctl start  postgresql
  EOF
}
