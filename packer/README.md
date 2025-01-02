# Packer commands

Build OS images with packer for using in Proxmox.

Example:
```bash
packer init ./ubuntu-server.pkr.hcl
packer validate ./ubuntu-server.pkr.hcl
packer build ./ubuntu-server.pkr.hcl
```