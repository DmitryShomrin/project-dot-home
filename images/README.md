# images

Packer templates for building VM images on Proxmox. These templates produce reusable Proxmox VM templates that are later cloned by Terraform when provisioning new VMs.

## How it fits into the stack

```
images/ (Packer)  →  infrastructure/ (Terraform)  →  ansible/ (Ansible)
Build VM template     Clone & provision VM        Configure & deploy services
```

Packer installs the OS, sets up cloud-init, and saves the result as a Proxmox template. Terraform then clones that template to create actual VMs — it never installs an OS itself.

## Available images

| Image | Proxmox template ID | Description |
|-------|---------------------|-------------|
| `ubuntu-server-24.04` | `999` | Ubuntu Server 24.04 LTS (Noble), cloud-init ready |

### What the template includes

- Ubuntu Server 24.04.1 LTS
- `qemu-guest-agent` — required for Proxmox VM management
- `cloud-init` configured for Proxmox (`99-pve.cfg`)
- SSH key authentication only (password auth disabled)
- `admin` user with passwordless sudo
- No swap

## Prerequisites

- Packer installed locally
- Ubuntu 24.04.1 ISO uploaded to Proxmox at `local:iso/ubuntu-24.04.1-live-server-amd64.iso`
- SSH key at `~/.ssh/id_rsa` (used during the build to connect to the VM)
- Proxmox credentials exported as environment variables:

```bash
source ubuntu-server-24.04/proxmox-connection.sh
export PROXMOX_PASSWORD="your-password"
```

## Building an image

```bash
cd ubuntu-server-24.04

# Install required Packer plugins
packer init ubuntu-server.pkr.hcl

# Validate the template
packer validate ubuntu-server.pkr.hcl

# Build and publish to Proxmox
packer build ubuntu-server.pkr.hcl
```

The build takes roughly 10–15 minutes. On completion, the template appears in Proxmox under VM ID `999` and is ready to be cloned by Terraform.

## Adding a new image

Create a new subdirectory following the same structure:

```
images/
└── <os-name-version>/
    ├── files/          # files copied into the VM during build
    ├── http/           # cloud-init autoinstall config served over HTTP
    │   ├── meta-data
    │   └── user-data
    ├── proxmox-connection.sh
    └── <name>.pkr.hcl
```
