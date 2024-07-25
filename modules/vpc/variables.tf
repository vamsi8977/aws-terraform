variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
}
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
}
variable "vpc_cidr" {
  description = "CIDR value for VPC"
}
variable "env" {
  description = "provide the env name"
}