#!/bin/bash
HOST="13.54.177.105"
ssh root@$HOST rm -rf /root/templates
scp -r setup/templates root@$HOST:/root
ssh root@$HOST /bin/bash << EOF
set -e

echo "Applying setup"
mv templates/postgres/postgresql.conf  /etc/postgresql/10/main/postgresql.conf
mv templates/postgres/pg_hba.conf /etc/postgresql/10/main/pg_hba.conf
mv templates/fail2ban/jail.local /etc/fail2ban/jail.local
mv templates/nginx/nginx.conf /etc/nginx/nginx.conf
mv templates/nginx/website  /etc/nginx/sites-available/website
cp /etc/nginx/sites-available/website  /etc/nginx/sites-enabled/website
rm -f /etc/nginx/sites-enabled/default

echo "Restarting nginx"
systemctl restart nginx 
echo "Restarting fail2ban"
systemctl restart fail2ban 
echo "Restarting postgres"
systemctl restart postgresql 
EOF
