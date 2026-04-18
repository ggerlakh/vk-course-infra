# Get external network with Internet access
data "vkcs_networking_network" "extnet" {
    sdn        = "sprut"
    external   = true
}

# Create a network
resource "vkcs_networking_network" "this" {
    name       = "${var.stand_name}-network"
    sdn        = "sprut"
}

# Create a subnet
resource "vkcs_networking_subnet" "this" {
    name       = "${var.stand_name}-subnet"
    network_id = vkcs_networking_network.this.id
    cidr       = var.private_subnet
}

# Create a router
resource "vkcs_networking_router" "this" {
    name       = "${var.stand_name}-router"
    sdn        = "sprut"
    external_network_id = data.vkcs_networking_network.extnet.id
}

# Connect the network to the router
resource "vkcs_networking_router_interface" "this" {
    router_id  = vkcs_networking_router.this.id
    subnet_id  = vkcs_networking_subnet.this.id
}

# Create ports for computes
resource "vkcs_networking_port" "port" {
    count = var.compute_count
    name = "${var.stand_name}-port-${count.index}"
    admin_state_up = true
    full_security_groups_control = true
    network_id = vkcs_networking_network.this.id
    fixed_ip {
        subnet_id =  vkcs_networking_subnet.this.id
    }
    security_group_ids = [
        data.vkcs_networking_secgroup.ssh.id,
        vkcs_networking_secgroup.secgroup_http.id
    ]
}

# Allocate a floating IP with a port
resource "vkcs_networking_floatingip" "associated_fip" {
  pool    = "internet"
}

# Associate floating IP with LB
resource "vkcs_networking_floatingip_associate" "fip" {
  floating_ip = vkcs_networking_floatingip.associated_fip.address
  port_id = vkcs_lb_loadbalancer.loadbalancer.vip_port_id
}