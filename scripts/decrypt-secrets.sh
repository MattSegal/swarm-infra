#!/bin/bash
set -e
. ./env/bin/activate
pushd ansible
cp secrets.yml secrets.secret.yml 
ansible-vault decrypt secrets.secret.yml  --vault-password-file ~/.vault-pass.txt
popd
deactivate
