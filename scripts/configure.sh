#!/bin/bash
# Configure host server with Ansible
set -e
. ./env/bin/activate
ansible-playbook \
	--vault-password-file ~/.vault-pass.txt \
	--inventory ./ansible/hosts \
	./ansible/site.yml
deactivate
