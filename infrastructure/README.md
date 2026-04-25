# infrastructure

Terraform code for provisioning VMs on Proxmox. Each VM is an independent Terraform root module with its own state.

## How it fits into the stack

```
images/ (Packer)  →  infrastructure/ (Terraform)  →  configuration/ (Ansible)
Build VM template     Clone & provision VM            Configure & deploy services
```

VMs are cloned from the template built in `images/`. Terraform handles compute resources only — OS configuration and service deployment are handled by Ansible afterwards.

## Structure

```
infrastructure/
├── _shared/              # canonical provider config — copy when adding a new VM
│   └── provider.tf
├── backup-server/        # VM 101 — NAS/backup server
├── cicd-server/          # VM 103 — CI/CD server (GitLab)
└── tailscale-node/       # VM 102 — Tailscale exit node
```

Each VM directory contains:
- `provider.tf` — Proxmox provider config (based on `_shared/provider.tf`)
- `vm.tf` — VM resource definition

## VMs

| Directory | VM ID | IP | CPU | RAM | Disk | Autostart |
|-----------|-------|----|-----|-----|------|-----------|
| `backup-server` | 101 | 192.168.1.249 | 4 cores | 8 GB | 60 GB | yes |
| `tailscale-node` | 102 | 192.168.1.252 | 1 core | 2 GB | 20 GB | yes |
| `cicd-server` | 103 | 192.168.1.248 | 4 cores | 8 GB | 200 GB | no |

## Prerequisites

- Terraform installed locally
- Proxmox credentials exported as environment variables:

```bash
export PM_USER="terraform-prov@pam"
export PM_PASS="your-password"
```

## Adding a new VM

1. Create a new directory under `infrastructure/`
2. Copy `_shared/provider.tf` into it
3. Create `vm.tf` with the VM resource definition — use an existing VM as a reference
4. Run `terraform init && terraform plan` to validate

```
infrastructure/
└── new-vm/
    ├── provider.tf   # copied from _shared/
    └── vm.tf
```
