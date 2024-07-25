resource "aws_subnet" "public_subnets" {
 count      = length(var.public_subnet_cidrs)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.public_subnet_cidrs, count.index)
 map_public_ip_on_launch = true
 tags = {
   Name = "${var.env}_public_subnet_${count.index + 1}"
 }
}
resource "aws_subnet" "private_subnets" {
 count      = length(var.private_subnet_cidrs)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.private_subnet_cidrs, count.index)
 tags = {
   Name = "${var.env}_private_subnet_${count.index + 1}"
 }
}