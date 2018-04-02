#!/bin/bash
set -e
if [[ $# -ne 2 ]]; then
    echo "ERROR: Expecting 2 command line arguments."
    exit 1
fi
DB_NAME="$1"
BACKUP_FILE="$2"

# You gotta gunzip!
# cat $BACKUP_FILE | gunzip >

sudo -u postgres pg_restore \
    --dbname $DB_NAME \
    --clean \
    --jobs 2 \
    $BACKUP_FILE
