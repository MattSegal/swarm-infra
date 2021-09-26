#!/bin/bash
set -e
. ./env/bin/activate
pushd ansible
cp secrets.secret.yml secrets.yml
ansible-vault encrypt secrets.yml --vault-password-file ~/.vault-pass.txt
popd
deactivate
