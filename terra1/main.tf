provider "aws" {
    region="eu-west-3"
}

resource "aws_instance" "myvm" {
    ami = "ami-0adcddd3324248c4c"
    instance_type = "t2.micro"
    tags = {
    Name = "jdoshi-vm-1"
    }
}