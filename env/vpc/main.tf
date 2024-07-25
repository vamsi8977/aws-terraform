provider "aws" {
    region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "develop-infra-core"
    key    = "terraform/vpc/state/terraform.tfstate"
    region = "us-east-1"
    encrypt        = true
  }
}
module "vpc" {
  source                = "../../modules/vpc"
  env                   = "develop"
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}