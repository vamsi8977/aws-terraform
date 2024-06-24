provider "aws" {
    region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket  = "develop-infra-core"
    key     = "terraform/mysql/state/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
module "mysql" {
  vpc_id                = "vpc-04455ebb614d65c23"
  subnet_ids            = ["subnet-03d56fcd682550ca0","subnet-05da606a37b0be2c4"]
  region                = "us-east-1"
  availability_zone     = ["us-east-1b","us-east-1c"]
  source                = "../../modules/mysql"
  db_name               = "mysqlaws"
  database_engine       = "MySQL"
  database_version      = "8.0.32"
  db_instance_type      = "db.t3.micro"
  rds_username          = "${var.rds_username}"
  rds_password          = "${var.rds_password}"
  multi_az              = "false"
  rds_storage           = "10"
  license_model         = "general-public-license"
}