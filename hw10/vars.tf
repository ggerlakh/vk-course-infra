variable "provider_username" {
    description = "Your VKCS provider account username"
    type        = string
    sensitive   = true
}

variable "provider_password" {
    description = "Your VKCS provider account password"
    type        = string
    sensitive   = true
}

variable "provider_project" {
    description = "Your VKCS provider project ID"
    type        = string
}

variable "provider_auth_url" {
    description = "Your VKCS provider auth URL"
    type = string
}

variable "provider_region" {
    description = "Your VKCS provider region name or ID"
    type = string
    default = "RegionOne"
}

variable "availability_zone" {
    description = "Main availability zone for lb and copmutes"
    type        = string
    default     = "GZ1"
}

variable "availability_zone_2" {
    description = "Fallback availability zone for lb and copmutes"
    type        = string
    default     = "MS1"
}

variable "stand_name" {
    description = "Stand name (test, prod)"
    type        = string
    default     = "test"
}

variable "private_subnet" {
    description = "Private subnet cidr for computes"
    type        = string
    default     = "192.168.1.0/24"
}

variable "compute_count" {
    description = "Load balancer creating compute count"
    type        = number
    default     = 2
}

variable "lb_listener_port" {
    description = "Load balancer listener port"
    type        = number
    default     = 80
}

variable "lb_member_port" {
    description = "Load balancer member port"
    type        = number
    default     = 80
}