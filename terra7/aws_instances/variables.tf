variable "tags" {
  type = "map"
}

variable "region" {
  default = "eu-west-3"
}

variable "total_instances" {
  default = 1
}

variable "cmds" {
  type = "list"
  default = ["sudo apt-get -y install python"]
}