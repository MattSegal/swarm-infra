#!/bin/bash
# Deploy jenkins on the host
HOST='167.99.78.141'

set -e

ssh root@$HOST /bin/bash << EOF
    set -e
    mkdir -p /root/jenkins
EOF

scp docker-compose.yml root@$HOST:/root/jenkins

ssh root@$HOST /bin/bash << EOF
    set -e
    cd jenkins
    echo "Deploying jenkins to docker swarm"
    docker stack deploy --compose-file docker-compose.yml jenkins
EOF
