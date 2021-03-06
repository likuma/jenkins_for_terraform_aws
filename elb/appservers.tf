resource "aws_instance" "http_server_elb_member" {
  ami           = data.aws_ami.ami_redhat_most_recent.id
  instance_type = "t2.micro"
  count = var.INSTANCE_COUNT
  tags = {
    Name = "http_server_elb_member_${count.index + 1}"
  }
  vpc_security_group_ids      = [data.aws_security_group.sec_group_for_http_and_ssh_icmp_attrs.id]
  subnet_id                   = data.aws_subnet.subnet_for_http_servers_attrs.id
  associate_public_ip_address = true
  key_name                    = "key_com_http"
  user_data                   = <<-EOF
		#!/bin/bash
                yum update -y
		yum install httpd -y
                yum install php php-mysqlnd php-cli -y
                yum install bind-utils -y
                yum install php-pgsql -y
                yum install postgresql -y
                yum install php-mysql -y
		echo "Server is running on `hostname`" >>  /var/www/html/index.html
		systemctl start httpd
                systemctl enable httpd
                chkconfig httpd on
                systemctl restart httpd
                echo -e "<?php \n phpinfo(); \n ?>" > /var/www/html/test.php
                sed -i "s/SELINUX=enforcing/SELINUX=permissive/" /etc/sysconfig/selinux
                sed -i "s/SELINUX=enforcing/SELINUX=permissive/" /etc/selinux/config
                setenforce 0
                cat << EOFF > /var/www/html/db.php
                  <?php
                  \$servername = "172.31.65.43";
                  \$username = "ruser";
                  \$password = "newpass";
                  // Create connection
                  \$conn = new mysqli(\$servername, \$username, \$password);
                  // Check connection
                  if (\$conn->connect_error) {
                     die("Connection failed: " . \$conn->connect_error);
                  }
                   echo "<b>Connected successfully to MYSQL  database on server: $servername with user: $username </b><br><br>";
                  \$sql="SHOW VARIABLES LIKE 'version%'";
                  //$result = mysqli_query(\$conn, \$sql);
                  if (\$result = mysqli_query(\$conn, \$sql)) {
                    while (\$row = mysqli_fetch_row(\$result)) {
                  //    printf ("%s (%s)\n", \$row[0], \$row[1], \$row[2], \$row[3]);
                  echo "Database: \$row[0], \$row[1]\n <br>";
                    }
                  }
                  mysqli_close(\$conn);
                  ?>
                 <?php
                 \$host        = "172.31.65.137";
                 \$port        = "5432";
                 \$dbname      = "postgres";
                 \$credentials = "user=ruser password=newpass";
                 \$username    = "ruser";
                 \$password    = "newpass";
                 \$query       = "select version()";
                 \$connect = pg_connect("host=\$host  port=\$port  dbname=\$dbname user=\$username password=\$password");
                 if(!\$connect){
                 echo "Error : Unable to open database\n";
                 }
                  echo "<br><br><br><b>Connected successfully to database: $dbname on server: $host with user: $username </b><br> <br>";
                 \$result=pg_query(\$query);
                 echo "<table border=1>\n";
                 while (\$line = pg_fetch_array(\$result)) {
                   echo "\t<tr>\n";
                   foreach (\$line as \$col_value) {
                   echo "\t\t<td>\$col_value</td>\n";
                   }
                 echo "\t</tr>\n";
                 }
                 echo "</table>\n";
                 pg_free_result(\$result);
                 pg_close(\$connect);
                ?>
                EOFF
  EOF
}
