#!/bin/bash
# Build a docker image and push it to the local docker repo
set -e
if [[ $# -ne 1 ]]; then
    echo "ERROR: Expecting 1 command line argument."
    exit 1
fi
APP_NAME="$1"

echo "Building $APP_NAME"
docker-compose build

echo "Pushing $APP_NAME to local registry"
docker-compose push
