#!/bin/bash
# Take database backups for all apps
HOST='167.99.78.141'
ssh root@$HOST /bin/bash << EOF
    set -e
    for db_name in links war whatson photos
    do
        echo "===== backing up \$db_name ====="
       /root/scripts/backup-database.sh \$db_name
        echo "======== end \$db_name ========="
    done
EOF
