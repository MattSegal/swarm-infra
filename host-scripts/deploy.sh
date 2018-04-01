#!/bin/bash
set -e
if [[ $# -ne 1 ]]; then
    echo "ERROR: Expecting 1 command line argument."
    exit 1
fi
REPO="$1"

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
docker stack deploy --compose-file docker-compose.prod.yml $REPO
