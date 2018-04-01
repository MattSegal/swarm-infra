#!/bin/bash
# Deploy a git repositry to the host server
HOST='167.99.78.141'

set -e
if [[ $# -ne 1 ]]; then
    echo "ERROR: Expecting 1 command line argument."
    exit 1
fi
REPO="$1"

scp ./host-scripts/deploy.sh root@$HOST:/root/scripts/
ssh root@$HOST /root/scripts/deploy.sh $REPO
