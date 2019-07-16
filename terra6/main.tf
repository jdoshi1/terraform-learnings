terraform {
    backend "s3" {
        bucket = "jdoshi"
        key = "bubba/terraform.tfstate"
        region = "eu-west-3"
    }
}

provider "aws" {
    region = "eu-west-3"
}

locals {
    vm_name = "${join("-", list("jdoshi", terraform.workspace, "vm"))}"
}

resource "aws_instance" "myvm" {
    tags = {
        Name = "${local.vm_name}"
    }
    ami = "ami-0adcddd3324248c4c"
    instance_type = "t2.micro"
    key_name = "jdoshi-bubba"
    security_groups = ["default"]
    provisioner "remote-exec" {
        inline = ["touch hello.sh"]
        connection {
            host = "${aws_instance.myvm.public_ip}"
            type = "ssh"
            user = "ec2-user"
            private_key = "${file("/home/ec2-user/environment/terraform-learnings/jdoshi-bubba.pem")}"
        }
    }
}