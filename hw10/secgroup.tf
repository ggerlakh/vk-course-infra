resource "vkcs_networking_secgroup" "secgroup_http" {
  name        = "www"
  description = "security group for 8080-8081 port http traffic"
}

resource "vkcs_networking_secgroup_rule" "secgroup_http" {
  direction         = "ingress"
  port_range_max    = 8081
  port_range_min    = 8080
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = vkcs_networking_secgroup.secgroup_http.id
}