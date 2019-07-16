####################
##### Backend ######
####################

output "be_public_ips" {
  value = "${aws_instance.backend.*.public_ip}"
}

####################
##### Frontend #####
####################


output "fe_public_ips" {
  value = "${aws_instance.frontend.*.public_ip}"
}
