ansible-playbook site.yml --limit datacenter2

ansible all -m <module> -a "<module options>" --limit 'group1'

ansible-galaxy install -r requirements.yaml

ansible-inventory -i inventory --list

ansible all -i inventory -m ping

ansible-playbook main.yaml --limit rpi4-0 --tags "base-config"

ansible-vault encrypt_string 'secret_string' --name 'docker_compose_templates_pi_hole_web_password'

ansible localhost -m ansible.builtin.debug -a var="docker_compose_templates_pi_hole_web_password" -e "@group_vars/rpi4-0/main.yaml"

- hosts: rpi4-0
  vars:
    test: main
  tasks:
    - name: Print debug msg
      debug:
        msg: "Test variable: {{ test }}"
