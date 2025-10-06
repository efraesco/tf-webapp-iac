output "vpc_name" {
  value = module.network.network_name
}

output "instance_external_ip" {
  value = module.compute.web_server_ip
}
