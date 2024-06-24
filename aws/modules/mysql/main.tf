resource "aws_db_instance" "rds" {
  identifier                   = "${var.db_name}"
  allocated_storage            = "${var.rds_storage}"
  engine                       = "${var.database_engine}"
  engine_version               = "${var.database_version}"
  instance_class               = "${var.db_instance_type}"
  storage_type                 = "gp2"
  username                     = "${var.rds_username}"
  password                     = "${var.rds_password}"
  license_model                = "${var.license_model}"
  vpc_security_group_ids       = ["${aws_security_group.sg_rds.id}"]
  db_subnet_group_name         = "${aws_db_subnet_group.rds_subnet_group.name}"
  parameter_group_name         = "mysql8-timezone"
  multi_az                     = "${var.multi_az}"
  apply_immediately            = "${var.apply_immediately}"
  skip_final_snapshot          = "${var.skip_final_snapshot}"
  final_snapshot_identifier    = "${var.db_name}-rds-final-${md5(timestamp())}"
  snapshot_identifier          = "${var.snapshot_identifier}"
  kms_key_id                   = "${data.aws_kms_key.rds_key.arn}"
  storage_encrypted            = "true"
  maintenance_window           = "Sun:07:00-Sun:08:00"
  backup_window                = "00:00-02:00"
  backup_retention_period      = "30"
timeouts {
    create = "120m"
    delete = "2h"
   }
tags = {
  Name                       = "${var.db_name}"
  Schedule                   = "${var.app_schedule}"
}
lifecycle {
    ignore_changes = ["final_snapshot_identifier"]
  }
}
data "aws_kms_key" "rds_key" {
  key_id = "alias/aws/rds"
}
