#!/bin/bash
# Restore a database from backups
# TODO - MAKE THIS WORK
exit 1
HOST='167.99.78.141'

set -e
if [[ $# -ne 1 ]]; then
    echo "ERROR: Expecting 1 command line argument."
    exit 1
fi
DB_NAME="$1"

ssh root@$HOST /bin/bash << EOF
    set -e
    echo "Fetching latest database backup for $DB_NAME"
    LATEST_BACKUP=\$(aws s3 ls swarm-db-backup/${DB_NAME}/ | tail -1 | awk -F ' ' '{print \$4}')
    echo "Restoring $DB_NAME from \$LATEST_BACKUP"
    pushd /
    aws s3 cp s3://swarm-db-backup/${DB_NAME}/\$LATEST_BACKUP - |
        gunzip |
        sudo -u postgres pg_restore --dbname $DB_NAME --no-owner
    popd
EOF
