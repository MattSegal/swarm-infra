#!/bin/bash
set -e
HOST="13.54.177.105"
ssh root@$HOST /bin/bash << EOF
set -e
echo "Updating apt sources"
apt-get update -y -qq
echo "Installing apt-get stuff"
apt-get install -y -qq \
    curl \
    unzip \
    fail2ban \
    nginx \
    postgresql \
    postgresql-contrib \
    python-psycopg2 \
    libpq-dev \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common \
    awscli

echo "Adding Docker GPG key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88

echo "Adding Docker repo"
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
apt-get install -y nodejs
npm install -g yarn

echo "Updating apt sources again"
apt-get update -qq

echo "Installing Docker"
apt-get install docker-ce docker-ce-cli containerd.io

echo "Finished installing."
EOF
