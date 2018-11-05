#!/bin/bash
# Deploy concourse on the host
HOST='167.99.78.141'

set -e

ssh root@$HOST /bin/bash << EOF
    set -e
    mkdir -p /root/concourse
EOF

scp \
    setup/generate-keys.sh \
    setup/download-fly.sh \
    docker-compose.yml \
    Dockerfile \
    root@$HOST:/root/concourse

ssh root@$HOST /bin/bash << EOF
    set -e
    cd concourse

    ./generate-keys.sh
    ./download-fly.sh

    echo "Building Concourse"
    docker-compose build

    echo "Pushing Concourse to local registry"
    docker-compose push

    echo "Deploying Concourse to docker swarm"
    docker stack deploy --compose-file docker-compose.yml concourse
EOF
