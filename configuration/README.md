# configuration

Ansible code for configuring machines and deploying services. Covers everything after a VM is provisioned — OS setup, Docker, monitoring agents, and Docker Compose service deployment.

## How it fits into the stack

```
images/ (Packer)  →  infrastructure/ (Terraform)  →  configuration/ (Ansible)
Build VM template     Clone & provision VM            Configure & deploy services
```

## Structure

```
configuration/
├── inventory.yaml              # all hosts and groups
├── ansible.cfg                 # Ansible config (roles_path, remote user, vault)
├── requirements.yaml           # external roles and collections
├── group_vars/
│   ├── all/                    # variables applied to all hosts
│   ├── rpi-4-0/
│   └── storage-node/
├── playbooks/
│   ├── main.yaml               # full-stack playbook (all hosts)
│   ├── machines/               # per-machine playbooks
│   │   ├── proxmox.yaml
│   │   ├── rpi4-0.yaml
│   │   ├── storage-node.yaml
│   │   ├── vm-backup-server.yaml
│   │   ├── vm-cicd-server.yaml
│   │   └── vm-tailscale-node.yaml
│   └── ops/                    # operational playbooks
│       ├── cron-jobs.yaml
│       ├── debug.yaml
│       ├── ssh-keys-management.yaml
│       └── test.yaml
└── roles/
    ├── cloudflared/
    ├── cron-jobs/
    ├── rpi-base-config/
    └── docker-compose-services/   # Docker Compose service roles
        ├── gitlab/
        ├── homepage/
        ├── pihole/
        ├── prometheus-stack/
        ├── templates/
        ├── traefik/
        └── vaultwarden/
```

## Prerequisites

- Ansible installed (or use the `docker-tools/ansible-ubuntu` container image)
- External roles and collections installed:

```bash
ansible-galaxy install -r requirements.yaml
```

- SSH key access to all hosts
- Ansible Vault password file at `ansible-vault` (gitignored)

## Usage

All commands should be run from the `configuration/` directory.

### Run a playbook

```bash
# Full stack — all hosts
ansible-playbook playbooks/main.yaml

# Single machine
ansible-playbook playbooks/machines/rpi4-0.yaml

# Limit to specific host or group
ansible-playbook playbooks/main.yaml --limit rpi-4-0

# Limit to specific tags
ansible-playbook playbooks/main.yaml --limit rpi-4-0 --tags "base-config"
```

### Inventory

```bash
# List all hosts and groups
ansible-inventory -i inventory.yaml --list

# Ping all hosts
ansible all -m ping

# Run an ad-hoc module
ansible all -m <module> -a "<module options>" --limit 'group1'
```

### Vault

```bash
# Encrypt a secret string for use in a variable file
ansible-vault encrypt_string 'secret_value' --name 'variable_name'

# Inspect an encrypted variable
ansible localhost -m ansible.builtin.debug \
  -a var="variable_name" \
  -e "@group_vars/all/secrets.yaml"
```

### Debug snippet

Useful for quickly testing variables or connectivity against a host:

```yaml
- hosts: rpi-4-0
  vars:
    test: main
  tasks:
    - name: Print debug msg
      debug:
        msg: "Test variable: {{ test }}"
```

Run it with:

```bash
ansible-playbook playbooks/ops/debug.yaml --limit rpi-4-0
```
