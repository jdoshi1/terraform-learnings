provider "aws" {
    region = "eu-west-3"
}

resource "aws_instance" "frontend" {
    count = 2
    availability_zone = "${var.zones[count.index]}"
    ami = "ami-0adcddd3324248c4c"
    instance_type = "t2.micro"
    tags = {
        Name = "jdoshi-frontend-${count.index}"
    }
}