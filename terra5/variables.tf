variable "multi-region-deployment" {
    default = true
}

variable "be-instance-count-east" {
    default = 3
}
variable "be-instance-count-west" {
    default = 2
}

variable "env-name" {
    default = "jdoshi-tf-demo"
}

variable "amis" {
    type = "map"
    default = {
        sa-east-1 = "ami-058943e7d9b9cabfb"
        eu-west-3 = "ami-0adcddd3324248c4c"
    }
}