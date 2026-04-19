resource "vkcs_compute_instance" "compute" {
  count                   = var.compute_count
  name                    = "host${count.index + 1}"
  flavor_id               = data.vkcs_compute_flavor.minimal.id
  key_pair                = vkcs_compute_keypair.default_key_pair.name
  config_drive            = "true"
  security_group_ids      = [
        data.vkcs_networking_secgroup.ssh.id,
        vkcs_networking_secgroup.secgroup_http.id
    ]
  availability_zone       = count.index == 0 ? var.availability_zone : var.availability_zone_2
  block_device {
    uuid                  = data.vkcs_images_image.ubuntu.id
    source_type           = "image"
    destination_type      = "volume"
    volume_type           = "ceph-ssd"
    volume_size           = 10
    boot_index            = 0
    delete_on_termination = true
  }
  network {
    port = vkcs_networking_port.port[count.index].id
  }

  user_data = templatefile("user-data.yaml.tftpl", {
    hostname = "host${count.index + 1}"
    # app_port = count.index == 0 ? 8080 : 8081
  })

  depends_on = [
    vkcs_networking_router_interface.this
  ]
}