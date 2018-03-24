#!/bin/bash
ansible-playbook \
	--vault-password-file ~/.vault-pass.txt \
	--inventory ./ansible/hosts \
	./ansible/site.yml
