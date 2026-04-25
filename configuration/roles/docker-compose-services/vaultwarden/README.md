Docker compose Vaultwarden
=========

Template docker compose file for Vaultwarden.

Requirements
------------

 - Docker
 - Docker compose

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: docker-compose-vaultwarden }
