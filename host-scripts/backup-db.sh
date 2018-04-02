#!/bin/bash
set -e
if [[ $# -ne 1 ]]; then
    echo "ERROR: Expecting 1 command line argument."
    exit 1
fi
DB_NAME="$1"

TIME=$(date "+%s")
BACKUP_DIR="/var/backups/${DB_NAME}"
BACKUP_FILE="${BACKUP_DIR}/postgres_${DB_NAME}_${TIME}.sql.gz"
BACKUP_BUCKET="s3://swarm-db-backup/${DB_NAME}/"

mkdir -p $BACKUP_DIR
sudo -u postgres -i pg_dump -Fc $DB_NAME | gzip > $BACKUP_FILE
aws s3 cp $BACKUP_FILE $BACKUP_BUCKET
