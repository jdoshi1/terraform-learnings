provider "aws" {
    region = "sa-east-1"
}

provider "aws" {
    alias = "eu-bubba-1"
    region = "eu-west-1"
}

resource "aws_instance" "eastvm" {
    ami = "ami-058943e7d9b9cabfb"
    instance_type = "t2.micro"
    tags {
        Name = "jdoshi"
    }
}

resource "aws_instance" "westvm" {
    provider = "aws.eu-bubba-1"
    ami = "ami-0bbc25e23a7640b9b"
    instance_type = "t2.micro"
    tags {
        Name = "jdoshi"
    }
}