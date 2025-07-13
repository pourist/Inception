#!/bin/sh

set -e #script exit immediately if any command fails 

# user and name from .env
MYSQL_DATABASE=$(grep '^MYSQL_DATABASE=' /srcs/.env | cut -d '=' -f2-)
MYSQL_USER=$(grep '^MYSQL_USER=' /srcs/.env | cut -d '=' -f2-)

# passes from secrets
MYSQL_PASSWORD=$(cat /secrets/db_password.txt)    
DB_ROOT_PASSWORD=$(cat /secrets/db_root_password.txt)

export MYSQL_DATABASE MYSQL_USER MYSQL_PASSWORD

#replaces the placeholders in init.sql
envsubst < /srcs/requirements/mariadb/tools/init.sql > /tmp/init_resolved.sql

# Start MariaDB in background
mysqld --user=mysql --bootstrap --skip-networking=0 < /tmp/init_resolved.sql

rm -f /tmp/init_resolved.sql

exec mysqld

