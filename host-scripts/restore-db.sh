#!/bin/bash
set -e
if [[ $# -ne 2 ]]; then
    echo "ERROR: Expecting 1 command line argument."
    exit 1
fi
DB_NAME="$1"
BACKUP_FILE="$2"

sudo -u postgres pg_restore \
	--dbname $DB_NAME \
	--clean \
	--jobs 2 \
	$BACKUP_FILE
