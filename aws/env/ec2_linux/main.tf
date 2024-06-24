provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "develop-infra-core"
    key    = "terraform/linux_ec2/state/terraform.tfstate"
    region = "us-east-1"
    encrypt        = true
  }
}
module "linux_ec2" {
  ec2_instance_name     = "awsec2l"
  ec2_instance_count    = "1"
  instance_type         = "t2.micro"
  availability_zones    = ["us-east-1a"]
  source                = "../../../modules/ec2_linux"
  key_name              = "develop_aws"
  env                   = "develop"
  ami                   = "ami-080e1f13689e07408"
  aws_region            = "us-east-1"
}