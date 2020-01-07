#For Atos community Jenkins server
resource "aws_instance" "http_jenkins_server_aws_configure" {
  ami           = "ami-0badcc5b522737046"
  instance_type = "t2.micro"
  tags = {
    Name = "http_jenkins_server_with_aws_configure"
  }
  subnet_id                   = data.aws_subnet.subnet_for_mgmnt_servers_attrs.id
  vpc_security_group_ids      = [data.aws_security_group.sec_group_for_http_and_ssh_icmp_attrs.id]
  associate_public_ip_address = true
  key_name                    = "key_com_http"
  iam_instance_profile        = data.aws_iam_instance_profile.aws_configure_for_jenkins_instance_profile_attrs.name
  user_data                   = <<-EOF
                #!/bin/bash
                yum install wget -y
                wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
                rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
                yum install jenkins -y
                yum install java -y
                yum install unzip -y
                yum install git -y
                yum install python3-pip -y
                pip3 install awscli
                yum install jq -y
                curl https://releases.hashicorp.com/terraform/0.12.17/terraform_0.12.17_linux_amd64.zip >/tmp/terraform.zip
                cd /usr/local/bin 
                unzip /tmp/terraform.zip -d .
                service jenkins start
                #password in /var/lib/jenkins/secrets/initialAdminPassword
  EOF
}
