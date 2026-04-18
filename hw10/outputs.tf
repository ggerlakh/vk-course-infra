output "instance_ip" {
  value = [for i in vkcs_compute_instance.compute : i.access_ip_v4]
}

output "floating_ip" {
  value = vkcs_networking_floatingip.associated_fip.address
}

# To list value use: terraform output -raw private_key
output "private_key" {
  value = vkcs_compute_keypair.default_key_pair.private_key
  sensitive = true
}

output "vip_address" {
  value = vkcs_lb_loadbalancer.loadbalancer.vip_address
}