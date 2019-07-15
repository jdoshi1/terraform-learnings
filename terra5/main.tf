provider "aws" {
    region = "sa-east-1"
}

data "aws_region" "east" {
    
}

data "aws_region" "west" {
    provider = "aws.bubba-west"
}

provider "aws" {
    alias = "bubba-west"
    region = "eu-west-3"
}

data "aws_availability_zones" "sa-east-zones" {}

data "aws_availability_zones" "eu-west-zones" {
    provider = "aws.bubba-west"
}

locals {
    def_front_name = "${join("-",list(var.env-name, "frontend"))}"
    def_backend_name = "${join("-",list(var.env-name, "backend"))}"
}

resource "aws_instance" "west-fe" {
    provider = "aws.bubba-west"
    tags {
        Name = "${local.def_front_name}-${count.index}"
    }
    ami = "${var.amis[data.aws_region.west.name]}"
    instance_type = "t2.micro"
    depends_on = ["aws_instance.west-be"]
    availability_zone = "${data.aws_availability_zones.eu-west-zones.names[count.index]}"
}

resource "aws_instance" "west-be" {
    count = "${var.be-instance-count-west}"
    provider = "aws.bubba-west"
    tags {
        Name = "${local.def_backend_name}-${count.index}"
    }
    ami = "${var.amis[data.aws_region.west.name]}"
    instance_type = "t2.micro"
    availability_zone = "${data.aws_availability_zones.eu-west-zones.names[count.index]}"
}

resource "aws_instance" "east-fe" {
    tags {
        Name = "${local.def_front_name}-${count.index}"
    }
    count = "${var.multi-region-deployment ? 1:0}"
    ami = "${var.amis[data.aws_region.east.name]}"
    instance_type = "t2.micro"
    depends_on = ["aws_instance.east-be"]
    availability_zone = "${data.aws_availability_zones.sa-east-zones.names[count.index]}"
}

resource "aws_instance" "east-be" {
    tags {
        Name = "${local.def_backend_name}-${count.index}"
    }
    count = "${!var.multi-region-deployment ? 0 : var.be-instance-count-east}"
    ami = "${var.amis[data.aws_region.east.name]}"
    instance_type = "t2.micro"
    availability_zone = "${data.aws_availability_zones.sa-east-zones.names[count.index]}"
}