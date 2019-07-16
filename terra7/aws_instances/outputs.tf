output "ips" {
  value = "${aws_instance.hello.*.public_ip}"
}