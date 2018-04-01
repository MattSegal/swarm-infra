#!/bin/bash
# Configure host server with Ansible
set -e
. ~/venv/bin/activate
ansible-playbook \
	--vault-password-file ~/.vault-pass.txt \
	--inventory ./ansible/hosts \
	./ansible/site.yml
deactivate
