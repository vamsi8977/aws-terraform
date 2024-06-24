resource "aws_instance" "linux_ec2" {
  count                  = var.ec2_instance_count
  ami                    = var.ami
  key_name               = var.key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = ["${var.env}_sg"]
  tags = {
    Name = "${var.env}_${var.ec2_instance_name}"
  }
  user_data = templatefile("${path.module}/templates/userdata.tpl", {
    environment = var.env
  })
}