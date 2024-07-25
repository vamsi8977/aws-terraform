variable app_schedule {
  description = "RDS Schedule"
  default     = ""
}
variable "region" {
  description = "The AWS region the servers reside in."
}
variable "availability_zone" {
  description = "availability zone where the ec2 instance is deployed."
  type = list
}
variable "rds_storage" {
  description = "How many GBs of space does your database need?"
  default     = ""
}
variable "database_engine" {
  description = "RDS engine: mysql, oracle, postgres. Defaults to mysql"
  default     = ""
}
variable "database_version" {
  description = "Engine version to use, according to the chosen engine. You can check the available engine versions using the AWS CLI (http://docs.aws.amazon.com/cli/latest/reference/rds/describe-db-engine-versions.html). Defaults to 5.6.39 for MySQL."
  default     = ""
}
variable "rds_password" {
  description = "RDS root password"
}
variable "rds_username" {
  description = "RDS root user"
}
variable "multi_az" {
  description = "Whether the database should be deployed to multiple availablity zones."
}
variable "backup_retention_period" {
  description = "How long do you want to keep RDS backups"
  default     = "5"
}
variable "db_name" {
  description = "MSSQL database name"
}
variable "db_instance_type" {
  description = "The instance type of the RDS instance"
}
variable "apply_immediately" {
  description = "Apply changes immediately"
  default     = true
}
variable "skip_final_snapshot" {
  description = "Skip final snapshot when destroying RDS"
  default     = false
}
variable "snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05."
  default     = ""
}
variable "vpc_id" {
  description = "The ID of the VPC in which to create the instance."
}
variable "subnet_ids" {
  description = "subnet_ids to deploy in"
  type        = list
}
variable "aws_rds_id" {
  description = "aws_rds_id"
  default     = ""
}
variable "license_model" {
    default = ""
    description = "(Optional, but required for some DB engines, i.e. Oracle SE1) License model information for this DB instance."
}