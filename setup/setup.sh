#!/bin/bash
set -e
HOST="13.54.177.105"
# Manually add ssh key with ssh-keygen, add to GitHub
ssh root@$HOST /bin/bash << EOF
set -e
echo "Setting up folders"
mkdir -p /root/repos
mkdir -p /root/backups
mkdir -p /root/creds
chmod +600 ~/.ssh/id_rsa
echo -e "Host github.com\n    StrictHostKeyChecking no\n" > ~/.ssh/config
pushd repos
if [[ ! -d /root/repos/photos ]]; then
    git clone -q git@github.com:MattSegal/family-photos.git photos
fi
if [[ ! -d /root/repos/links ]]; then
    git clone -q git@github.com:MattSegal/link-sharing-site.git links
fi
if [[ ! -d /root/repos/reader ]]; then
    git clone -q git@github.com:MattSegal/reader-bot.git reader
fi
popd
EOF
ssh root@$HOST rm -rf /root/scripts
scp -r setup/templates/scripts root@$HOST:/root/scripts
