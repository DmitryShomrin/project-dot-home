terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc05"
    }
  }
}

variable "proxmox_api_url" {
  type    = string
  default = "https://192.168.1.250:8006/api2/json"
}

provider "proxmox" {
  pm_api_url      = var.proxmox_api_url
  pm_tls_insecure = true
}
