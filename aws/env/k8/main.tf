provider "aws" {
    region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket      = "develop-infra-core"
    key         = "terraform/k8/state/terraform.tfstate"
    region      = "us-east-1"
    encrypt     = true
  }
}
module "aws_eks_cluster" {
    cluster_name            = "k8"
    source                  = "../../modules/k8"
    vpc_id                  = "vpc-04455ebb614d65c23"
    availability_zones      = ["us-east-1a" , "us-east-1b"]
    subnet_ids              = ["subnet-0f6575cd518f89e47" , "subnet-03d56fcd682550ca0"]
}