#!/bin/bash
set -e
if [[ $# -ne 1 ]]; then
    echo "ERROR: Expecting 1 command line argument."
    exit 1
fi
DB_NAME="$1"

TIME=$(date "+%s")
BACKUP_TARGET="s3://swarm-db-backup/${DB_NAME}/postgres_${DB_NAME}_${TIME}.sql.gz"

pushd /
sudo -u postgres -i pg_dump -Fc $DB_NAME | gzip | aws s3 cp - $BACKUP_TARGET
popd
