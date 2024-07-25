resource "aws_security_group" "vpc_sg" {
  name        = "${var.env}_sg"
  vpc_id      = "${aws_vpc.main.id}"
  tags = {
    Name = "${var.env}_sg"
  }
}
resource "aws_security_group_rule" "local_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.vpc_sg.id}"
  description       = "Allow connection from local"
}
resource "aws_security_group_rule" "nginx_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.vpc_sg.id}"
  description       = "Allow nginx connection from local"
}
resource "aws_security_group_rule" "internet_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.vpc_sg.id}"
  description       = "Allow internet connection"
}
resource "aws_security_group_rule" "unsecure_ingress" {
  type              = "ingress"
  from_port         = 5985
  to_port           = 5985
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.vpc_sg.id}"
  description       = "Allow nginx connection from local"
}
resource "aws_security_group_rule" "secure_ingress" {
  type              = "ingress"
  from_port         = 5986
  to_port           = 5986
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.vpc_sg.id}"
  description       = "Allow nginx connection from local"
}
resource "aws_security_group_rule" "rdp_ingress" {
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.vpc_sg.id}"
  description       = "Allow nginx connection from local"
}