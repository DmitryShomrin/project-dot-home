resource "proxmox_vm_qemu" "vm" {
    count = 1
    
    # VM General Settings
    target_node = "proxmox-0"
    vmid        = 103
    name        = "cicd-server"
    description = "CI/CD server"

    # VM Advanced General Settings
    onboot = false

    # VM OS Settings
    clone_id   = "999"
    full_clone = false

    # VM System Settings
    agent = 1
    
    # VM CPU Settings
    cpu {
        cores   = 4
        sockets = 1
        type    = "host"
    }
    
    # VM Memory Settings
    memory = 8192

    scsihw = "virtio-scsi-pci"
    # VM Network Settings
    network {
        id     = 0
        bridge = "vmbr0"
        model  = "virtio"
    }

    disk {
        slot    = "ide0"
        size    = "4M"
        type    = "cloudinit"
        storage = "local-lvm"
    }

    disk {
        slot    = "virtio0"
        size    = "200G"
        storage = "local-lvm"
    }

    # VM Cloud-Init Settings
    os_type = "cloud-init"

    # IP Address and Gateway
    ipconfig0 = "ip=192.168.1.248/24,gw=192.168.1.1"

    tags = "cicd,terraform"

    lifecycle {
        ignore_changes = [
            ipconfig0,
            disk,
        ]
    }
}
