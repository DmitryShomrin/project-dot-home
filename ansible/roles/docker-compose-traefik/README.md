Docker compose traefik
=========

Template docker compose file for traefik.

Requirements
------------

 - Docker
 - Docker compose

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: docker-compose-traefik }
