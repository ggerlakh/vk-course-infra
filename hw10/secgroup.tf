resource "vkcs_networking_secgroup" "secgroup_http" {
  name        = "www"
  description = "security group for http ${var.lb_member_port}"
}

resource "vkcs_networking_secgroup_rule" "secgroup_http" {
  direction         = "ingress"
  port_range_max    = var.lb_member_port
  port_range_min    = var.lb_member_port
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = vkcs_networking_secgroup.secgroup_http.id
}