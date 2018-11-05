#!/bin/bash
# Deploy an app to the host server
#!/bin/bash
# Build a docker image and push it to the local docker repo
set -e
if [[ $# -ne 1 ]]; then
    echo "ERROR: Expecting 1 command line argument."
    exit 1
fi
APP_NAME="$1"
HOST='167.99.78.141'

echo "Deploying $APP_NAME to docker swarm"
export DOCKERHOST=$(ifconfig | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -f2 -d: | head -n1)
docker stack deploy --compose-file docker-compose.prod.yml $APP_NAME
