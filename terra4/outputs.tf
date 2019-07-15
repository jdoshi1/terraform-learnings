output "public_ip_address" {
	value = "${aws_instance.frontend.*.public_ip}"
}

output "public_dns" {
	value = "${aws_instance.frontend.*.public_dns}"
}

output "private_ip" {
	value = "${aws_instance.frontend.*.private_ip}"
}