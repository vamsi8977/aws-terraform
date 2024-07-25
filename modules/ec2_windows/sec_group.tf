## Security Groups
resource "aws_security_group" "win_sg" {
  name        = "${var.ec2_instance_name}-win-sg"
  vpc_id      = "${var.vpc_id}"
}
resource "aws_security_group_rule" "ansible_ingress" {
  type              = "ingress"
  from_port         = 5986
  to_port           = 5986
  protocol          = "tcp"
  cidr_blocks       = ["150.221.160.23/32"]
  security_group_id = "${aws_security_group.win_sg.id}"
  description       = "Allow connection from local"
}
resource "aws_security_group_rule" "winrm_ingress" {
  type              = "ingress"
  from_port         = 5985
  to_port           = 5985
  protocol          = "tcp"
  cidr_blocks       = ["150.221.160.23/32"]
  security_group_id = "${aws_security_group.win_sg.id}"
  description       = "Allow connection from local"
}
resource "aws_security_group_rule" "rdp_ingress" {
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"
  cidr_blocks       = ["150.221.160.23/32"]
  security_group_id = "${aws_security_group.win_sg.id}"
  description       = "Allow connection from local"
}
