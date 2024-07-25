## variables
variable "vpc_id" {
  description = "The ID of the VPC in which to create the instance."
}
variable "availability_zones" {
  description = "availability zone where the ec2 instance is deployed."
}

variable "cluster_name" {
  description = "name of the cluster that going to be created"
}

variable "subnet_ids" {
  description = "The ID of the subnet in which to create the instance into."
}