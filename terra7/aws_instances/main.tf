resource "aws_instance" "hello" {
  count = "${var.total_instances}"
  // tags = "${var.tags}"
  // Only works in terraform 0.11.x
  tags = "${merge(
                var.tags,
                map("Name", "${lookup(var.tags, "Name")}-${count.index}")
            )}"
  ami = "${data.aws_ami.latest_ubuntu.id}"
  key_name = "jdoshi1-tf"
  instance_type = "t2.micro"
  security_groups = ["default"]
  availability_zone = "${data.aws_availability_zones.zones.names[count.index]}"
  provisioner "remote-exec" {
    inline = "${var.cmds}"
    connection {
      host = "${self.public_ip}"
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("/Users/j.doshi/.ssh/jdoshi1-tf")}"
    }
  }
}