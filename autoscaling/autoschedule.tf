resource "aws_autoscaling_schedule" "ass_dec_for_http_server" {
  scheduled_action_name = "ass_dec_for_http_server"
  min_size = 1
  max_size = 1
  desired_capacity = 1
  #start_time = "2020-01-04T16:15:00Z"
  #end_time = "2020-01-04T15:55:00Z"
  recurrence = "00,10,20,30,40,50 10-23 4-20 1-3 0-6" #every 0 mins. from 10hr to 23hr, from 4 to 20 day of Jan - Mar, from Sun to Mon 
  #autoscaling_group_name = "${aws_autoscaling_group.asg_for_http_server.name}" #deprecated syntax
  autoscaling_group_name = aws_autoscaling_group.asg_for_http_server.name #new sytnax


 }

resource "aws_autoscaling_schedule" "ass_inc_for_http_server" {
  scheduled_action_name = "ass_inc_for_http_server"
  min_size = 1
  max_size = 3
  desired_capacity = 2
  #start_time = "2020-01-04T15:55:00Z"
  #end_time = "2020-01-04T16:25:00Z"
  recurrence = "05,25,45 10-23 4-20 1-3 0-6"
  autoscaling_group_name = aws_autoscaling_group.asg_for_http_server.name #new sytnax
 }
