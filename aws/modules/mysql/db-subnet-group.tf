resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.db_name}-subnet-rds"
  description = "our main group of subnets"
  subnet_ids  = "${var.subnet_ids}"
  tags = {
    Name = "${var.db_name}-rds-db-subnet-group"
  }
}