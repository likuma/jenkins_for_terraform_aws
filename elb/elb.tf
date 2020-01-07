data "aws_availability_zones" "all" {

}

resource "aws_elb" "elb-for-http-services" {
  name = "elb-for-http-services"
  security_groups = [data.aws_security_group.sec_group_for_http_and_ssh_icmp_attrs.id]
  instances = aws_instance.http_server_elb_member.*.id
  availability_zones = data.aws_availability_zones.all.names
  health_check {
    target              = "HTTP:80/"
    interval            = 20
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}
