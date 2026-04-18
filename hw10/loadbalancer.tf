resource "vkcs_lb_loadbalancer" "loadbalancer" {
  name = "loadbalancer"
  vip_subnet_id = vkcs_networking_subnet.this.id
  availability_zone = var.availability_zone

  depends_on = [
    vkcs_compute_instance.compute
  ]
}

resource "vkcs_lb_listener" "listener" {
  name = "listener"
  protocol = "HTTP"
  protocol_port = var.lb_listener_port
  loadbalancer_id = vkcs_lb_loadbalancer.loadbalancer.id
}

resource "vkcs_lb_pool" "pool" {
  name = "pool"
  protocol = "HTTP"
  lb_method = "ROUND_ROBIN"
  listener_id = vkcs_lb_listener.listener.id
}

resource "vkcs_lb_member" "member" {
  count = length(vkcs_compute_instance.compute)
  address = vkcs_compute_instance.compute[count.index].access_ip_v4
  protocol_port = var.lb_member_port
  pool_id = vkcs_lb_pool.pool.id
}

resource "vkcs_lb_monitor" "lb_http_life_checker" {
  name        = "lb-http-life-checker"
  pool_id     = vkcs_lb_pool.pool.id
  type        = "HTTP"
  delay       = 20
  timeout     = 10
  max_retries = 5
}