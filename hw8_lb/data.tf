# Используем data-ресурс для поиска образа
data "vkcs_images_image" "ubuntu" {
  visibility = "public"
  default    = true
  properties = {
    mcs_os_distro  = "ubuntu"
    mcs_os_version = "24.04"
  }
}
# Используем data-ресурс для поиска шаблона ресурсов по имени
data "vkcs_compute_flavor" "minimal" {
  name = "STD2-1-1"
}

# Используем data-ресурс для поиска secgorup по имени
data "vkcs_networking_secgroup" "ssh" {
  name = "ssh"
}