resource "aws_instance" "win_ec2" {
  count                  = "${var.ec2_instance_count}"
  ami                    = "ami-03cd80cfebcbb4481"
  key_name               = "${var.key_name}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.win_sg.id}"]
  subnet_id              = "${element(var.subnet_ids, count.index)}"
  tags = {
    Name = "${var.ec2_instance_name}"
  }
  user_data = templatefile("${path.module}/templates/userdata.tpl", {
    environment = "develop"
  })
}