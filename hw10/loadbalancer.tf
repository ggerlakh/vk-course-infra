resource "vkcs_lb_loadbalancer" "lb1" {
  name = "loadbalancer1"
  vip_subnet_id = vkcs_networking_subnet.this.id
  availability_zone = var.availability_zone

  depends_on = [
    vkcs_compute_instance.compute
  ]
}

resource "vkcs_lb_listener" "listener_lb1_8080" {
  name = "listener1-8080"
  protocol = "HTTP"
  protocol_port = 8080
  loadbalancer_id = vkcs_lb_loadbalancer.lb1.id
}

resource "vkcs_lb_listener" "listener_lb1_8081" {
  name = "listener1-8081"
  protocol = "HTTP"
  protocol_port = 8081
  loadbalancer_id = vkcs_lb_loadbalancer.lb1.id
}

resource "vkcs_lb_pool" "pool_lb1_8080" {
  name = "pool"
  protocol = "HTTP"
  lb_method = "ROUND_ROBIN"
  listener_id = vkcs_lb_listener.listener_lb1_8080.id
}

resource "vkcs_lb_pool" "pool_lb1_8081" {
  name = "pool"
  protocol = "HTTP"
  lb_method = "ROUND_ROBIN"
  listener_id = vkcs_lb_listener.listener_lb1_8081.id
}

resource "vkcs_lb_member" "member_lb1_8080" {
  count = length(vkcs_compute_instance.compute)
  address = vkcs_compute_instance.compute[count.index].access_ip_v4
  protocol_port = 8080
  pool_id = vkcs_lb_pool.pool_lb1_8080.id
  weight = count.index == 0 ? 45 : 5
}

resource "vkcs_lb_member" "member_lb1_8081" {
  count = length(vkcs_compute_instance.compute)
  address = vkcs_compute_instance.compute[count.index].access_ip_v4
  protocol_port = 8081
  pool_id = vkcs_lb_pool.pool_lb1_8081.id
  weight = count.index == 0 ? 45 : 5
}

# resource "vkcs_lb_monitor" "lb_http_life_checker" {
#   name        = "lb-http-life-checker"
#   pool_id     = vkcs_lb_pool.pool.id
#   type        = "HTTP"
#   delay       = 20
#   timeout     = 10
#   max_retries = 5
# }

resource "vkcs_lb_loadbalancer" "lb2" {
  name = "loadbalancer2"
  vip_subnet_id = vkcs_networking_subnet.this.id
  availability_zone = var.availability_zone_2

  depends_on = [
    vkcs_compute_instance.compute
  ]
}

resource "vkcs_lb_listener" "listener_lb2_8080" {
  name = "listener1-8080"
  protocol = "HTTP"
  protocol_port = 8080
  loadbalancer_id = vkcs_lb_loadbalancer.lb2.id
}

resource "vkcs_lb_listener" "listener_lb2_8081" {
  name = "listener1-8081"
  protocol = "HTTP"
  protocol_port = 8081
  loadbalancer_id = vkcs_lb_loadbalancer.lb2.id
}

resource "vkcs_lb_pool" "pool_lb2_8080" {
  name = "pool"
  protocol = "HTTP"
  lb_method = "ROUND_ROBIN"
  listener_id = vkcs_lb_listener.listener_lb2_8080.id
}

resource "vkcs_lb_pool" "pool_lb2_8081" {
  name = "pool"
  protocol = "HTTP"
  lb_method = "ROUND_ROBIN"
  listener_id = vkcs_lb_listener.listener_lb2_8081.id
}

resource "vkcs_lb_member" "member_lb2_8080" {
  count = length(vkcs_compute_instance.compute)
  address = vkcs_compute_instance.compute[count.index].access_ip_v4
  protocol_port = 8080
  pool_id = vkcs_lb_pool.pool_lb2_8080.id
  weight = count.index == 0 ? 5 : 45
}

resource "vkcs_lb_member" "member_lb2_8081" {
  count = length(vkcs_compute_instance.compute)
  address = vkcs_compute_instance.compute[count.index].access_ip_v4
  protocol_port = 8081
  pool_id = vkcs_lb_pool.pool_lb2_8081.id
  weight = count.index == 0 ? 5 : 45
}