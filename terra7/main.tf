module "frontend" {
  source = "./aws_instances"
  tags = {Name = "jdoshi-coolfrontend", environ="test", role="frontend"}
}

module "backend" {
  source = "./aws_instances"
  total_instances = 2
  tags = {Name = "jdoshi-coolbackend", environ="test", role="backend"}
  region = "sa-east-1"
  cmds = ["sudo apt-get -y install sqlite3"]
}

output "frontend_ips" {
  value = "${module.frontend.ips}"
}

output "backend_ips" {
  value = "${module.backend.ips}"
}