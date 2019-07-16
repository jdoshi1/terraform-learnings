terraform {
    backend "s3" {
        bucket = "jdoshi"
        key = "lab1/terraform.tfstate"
        region = "eu-west-3"
    }
}

provider "aws" {
    region = "eu-west-3"
}

provider "aws" {
    alias = "in-east"
    region = "sa-east-1"
}


data "aws_availability_zones" "eu-west-zones" {}

data "aws_availability_zones" "sa-east-zones" { provider = "aws.in-east" }

data "aws_region" "west" {}

data "aws_region" "east" { provider = "aws.in-east" }

locals {
    def_frontend_name = "${join("-",list(var.project_name, "frontend"))}"
    def_backend_name = "${join("-",list(var.project_name, "backend"))}"
}

# west - backend
resource "aws_instance" "backend" {
    count = 2
    tags = {
        Name = "${local.def_backend_name}-${count.index}}"
    }
    ami = "ami-0adcddd3324248c4c"
    instance_type = "t2.micro"
    availability_zone = "${data.aws_availability_zones.eu-west-zones.names[count.index]}"
    security_groups = ["default"]
    lifecycle {
        create_before_destroy = true
    }
    key_name = "jdoshi1-tf"
    provisioner "remote-exec" {
        inline = ["sudo yum install sqlite-devel -y"]
        connection {
            host = "${self.public_ip}"
            type = "ssh"
            user = "ec2-user"
            private_key = "${file("/Users/j.doshi/.ssh/jdoshi1-tf")}"
        }
    }
}

# east - frontend
resource "aws_instance" "frontend" {
    count = 2
    provider = "aws.in-east"
    tags = {
        Name = "${local.def_frontend_name}-${count.index}}"
    }
    ami = "ami-058943e7d9b9cabfb"
    instance_type = "t2.micro"
    availability_zone = "${data.aws_availability_zones.sa-east-zones.names[count.index]}"
    security_groups = ["default"]
    depends_on = ["aws_instance.backend"]
    lifecycle {
        create_before_destroy = true
    }
    key_name = "jdoshi1-tf"
    provisioner "remote-exec" {
        inline = ["sudo yum install nginx -y; sudo amazon-linux-extras install nginx1.12 -y"]
        connection {
            host = "${self.public_ip}"
            type = "ssh"
            user = "ec2-user"
            private_key = "${file("/Users/j.doshi/.ssh/jdoshi1-tf")}"
        }
    }
}