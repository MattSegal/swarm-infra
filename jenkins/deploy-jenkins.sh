#!/bin/bash
# Deploy jenkins on the host
HOST='167.99.78.141'

set -e

ssh root@$HOST /bin/bash << EOF
    set -e
    mkdir -p /root/jenkins
EOF

scp docker-compose.yml root@$HOST:/root/jenkins
scp Dockerfile root@$HOST:/root/jenkins

ssh root@$HOST /bin/bash << EOF
    set -e
    cd jenkins

    echo "Building Jenkins"
    docker-compose build

    echo "Pushing Jenkins to local registry"
    docker-compose push

    echo "Deploying Jenkins to docker swarm"
    docker stack deploy --compose-file docker-compose.yml jenkins
EOF
