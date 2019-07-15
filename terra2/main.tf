provider "aws" {
    region = "eu-west-3"
}

resource "aws_instance" "frontend" {
    ami = "ami-0adcddd3324248c4c"
    instance_type = "t2.micro"
    depends_on = ["aws_instance.backend"]
    lifecycle {
        create_before_destroy = true
    }
    
    tags = {
        Name = "jdoshi-frontend"
    }
}

resource "aws_instance" "backend" {
    count = 2
    ami = "ami-0adcddd3324248c4c"
    instance_type = "t2.micro"
    timeouts {
        create = "60m"
        delete = "2h"
    }
    tags = {
        Name = "jdoshi-backend-${count.index}"
    }
}