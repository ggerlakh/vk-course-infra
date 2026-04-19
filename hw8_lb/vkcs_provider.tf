terraform {
    required_providers {
        vkcs = {
            source = "vk-cs/vkcs"
            version = "< 1.0.0"
        }
    }
}

provider "vkcs" {
    username = var.provider_username
    password = var.provider_password
    project_id = var.provider_project
    auth_url = var.provider_auth_url
    region = var.provider_region
}
