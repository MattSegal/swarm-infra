#!/usr/bin/env bash
set -e -u -x
FLY_URL='https://github.com/concourse/concourse/releases/download/v4.2.1/fly_linux_amd64'
if [ -f fly ]; then
    echo "FLy already exists."
    exit 0
fi
echo "Fly does exist yet."
wget $FLY_URL -O fly
chmod +x fly
cp fly /usr/bin
echo "Fly downloaded."
