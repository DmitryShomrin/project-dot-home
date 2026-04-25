Docker compose Prometheus stack
=========

Template docker compose file and configs for Prometheus stack.
Prometheus stack:
 
 - Prometheus server
 - Grafana
 - Alertmanager

Requirements
------------

 - Docker
 - Docker compose

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: docker-compose-prometheus-stack }
