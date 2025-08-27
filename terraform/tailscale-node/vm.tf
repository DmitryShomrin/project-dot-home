resource "proxmox_vm_qemu" "vm" {
    count = 1
    
    # VM General Settings
    target_node = "proxmox-0"
    vmid        = 102
    name        = "tailscale-node"
    description = "Tailscale exit node"

    # VM Advanced General Settings
    onboot = true

    # VM OS Settings
    clone_id   = "999"
    full_clone = false

    # VM System Settings
    agent = 1
    
    # VM CPU Settings
    cpu {
        cores   = 1
        sockets = 1
        type    = "host"
    }
    
    # VM Memory Settings
    memory = 2048

    scsihw = "virtio-scsi-pci"
    # VM Network Settings
    network {
        id     = 0
        bridge = "vmbr0"
        model  = "virtio"
    }

    disk {
        slot    = "virtio0"
        size    = "20G"
        storage = "local-lvm"
    }
    disk {
        slot    = "ide0"
        size    = "4M"
        type    = "cloudinit"
        storage = "local-lvm"
    }

    # VM Cloud-Init Settings
    os_type = "cloud-init"

    # IP Address and Gateway
    ipconfig0 = "gw=192.168.1.1,ip=192.168.1.252/24"

    tags = "tailscale,terraform"

    lifecycle {
        ignore_changes = [
            ipconfig0,
            disk,
        ]
    }
}