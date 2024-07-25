## variables
variable "vpc_id" {
  description = "The ID of the VPC in which to create the instance."
}
variable "subnet_ids" {
  description = "The ID of the subnet in which to create the instance into."
}
variable "availability_zones" {
  description = "availability zone where the ec2 instance is deployed."
}
variable "ec2_instance_count" {
  description = "ec2_instance_count"
  default     = "1"
}
variable "ec2_instance_name" {
  description = "Each EC2 server that is used in AWS accounts should be named with the following pattern"
}
variable "instance_type" {
  description = "The type of instance determines your instance's CPU capacity, memory, and storage"
}
variable "key_name" {
  description = "key_name"
}