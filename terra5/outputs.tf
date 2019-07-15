####################
#####   West   #####
####################

output "west_fe_public_ip" {
    value = "${aws_instance.west-fe.*.public_ip}"
}

output "west_be_public_ip" {
    value = "${aws_instance.west-be.*.public_ip}"
}

output "data_az_west" {
    value = "${data.aws_availability_zones.eu-west-zones.*.names}"
}

####################
#####   East   #####
####################

output "east_fe_public_ip" {
    value = "${aws_instance.east-fe.*.public_ip}"
}

output "east_be_public_ip" {
    value = "${aws_instance.east-be.*.public_ip}"
}

output "data_az_east" {
    value = "${data.aws_availability_zones.sa-east-zones.*.names}"
}