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
variable "env" {
  description = "provide the env name"
}
variable "ami" {
  description = "provide the ami id"
}
variable "aws_region" {
  description = "provide the aws_region"
}