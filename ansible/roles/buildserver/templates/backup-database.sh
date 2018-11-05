#!/bin/bash
set -e
if [[ $# -ne 1 ]]; then
    echo "ERROR: Expecting 1 command line argument."
    exit 1
fi
DB_NAME="$1"
TIME=$(date "+%s")
BACKUP_FILE="postgres_${DB_NAME}_${TIME}.sql.gz"
BACKUP_LOCAL="/root/backups/$BACKUP_FILE"
BACKUP_S3="s3://swarm-db-backup/${DB_NAME}/${BACKUP_FILE}"

# This is probably way more complicated than it should be
DB_USER_VAR="$(echo $DB_NAME | tr a-z A-Z)_DB_USER"
DB_PASSWORD_VAR="$(echo $DB_NAME | tr a-z A-Z)_DB_PASSWORD"

export PGHOST=167.99.78.141
export PGDATABASE=$DB_NAME
export PGUSER="${!DB_USER_VAR}"
export PGPASSWORD="${!DB_PASSWORD_VAR}"

echo "Creating local database dump $BACKUP_LOCAL"
pg_dump --format=custom | gzip > $BACKUP_LOCAL

echo "Copying local dump to S3 - $BACKUP_S3"
aws s3 cp $BACKUP_LOCAL $BACKUP_S3

echo "Latest S3 backup:"
aws s3 ls s3://swarm-db-backup/$DB_NAME --recursive | sort | tail -n 1
