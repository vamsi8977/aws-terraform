# Create RDS with Subnet and paramter group,
resource "aws_security_group" "sg_rds" {
  name        = "${lower(var.db_name)}-rds-sg"
  description = "Security group that is needed for the RDS"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "api_ingress" {
  type        = "ingress"
  from_port   = 3306
  to_port     = 3306
  protocol    = "TCP"
  cidr_blocks = ["150.221.160.23/32"]
  security_group_id = "${aws_security_group.sg_rds.id}"
  description = "Security group ingress rule for the RDS"
}