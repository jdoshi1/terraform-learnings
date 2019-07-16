output "myvm_public_ip" {
    value = "${aws_instance.myvm.*.public_ip}"
}