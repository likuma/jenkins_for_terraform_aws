#create role and profile to auto aws configure
resource "aws_iam_role" "aws_configure_for_jenkins_role" {
  name = "aws_configure_for_jenkins_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    Name = "aws_configure_for_jenkins_role"
  }
}

resource "aws_iam_role_policy_attachment" "aws_configure_for_jenkins_role_policy" {
  role       = aws_iam_role.aws_configure_for_jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "aws_configure_for_jenkins_instance_profile" {
  name = "aws_configure_for_jenkins_instance_profile"
  role = aws_iam_role.aws_configure_for_jenkins_role.name
}
#iam_instance_profile   = aws_iam_instance_profile.jenkins_instance_profile.name
