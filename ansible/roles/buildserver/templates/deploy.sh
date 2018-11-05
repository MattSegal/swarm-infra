#!/bin/bash
# OLD DEPLOY SCRIPT
# Deploy a git repositry to the host server
HOST='167.99.78.141'

set -e
if [[ $# -ne 1 ]]; then
    echo "ERROR: Expecting 1 command line argument."
    exit 1
fi
REPO="$1"

ssh root@$HOST /bin/bash << EOF
    set -e
    cd /root/repos/$REPO
    echo "Cleaning $REPO git repository"
    git reset --hard
    git clean -dfx
    git pull

    echo "Building $REPO"
    docker-compose build

    echo "Pushing $REPO to local registry"
    docker-compose push

    echo "Deploying $REPO to docker swarm"
    export DOCKERHOST=$(ifconfig | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -f2 -d: | head -n1)
    docker stack deploy --compose-file docker-compose.prod.yml $REPO
EOF
