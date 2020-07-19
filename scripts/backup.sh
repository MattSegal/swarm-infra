#!/bin/bash
# Take database backups for all apps
HOST='3.24.18.19'
ssh root@$HOST /bin/bash << EOF
    set -e
    for db_name in links photos reader
    do
        echo "===== backing up \$db_name ====="
       /root/scripts/backup-database.sh \$db_name
        echo "======== end \$db_name ========="
    done
EOF
