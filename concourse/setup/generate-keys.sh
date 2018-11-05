#!/usr/bin/env bash
set -e -u -x
if [ -d keys ]; then
    echo "Concourse keys already exist."
    exit 0
fi
echo "Concourse keys do not exist yet."
mkdir -p keys/web keys/worker
yes | ssh-keygen -t rsa -f ./keys/web/tsa_host_key -N ''
yes | ssh-keygen -t rsa -f ./keys/web/session_signing_key -N ''
yes | ssh-keygen -t rsa -f ./keys/worker/worker_key -N ''
cp ./keys/worker/worker_key.pub ./keys/web/authorized_worker_keys
cp ./keys/web/tsa_host_key.pub ./keys/worker
echo "Concourse keys generated."
