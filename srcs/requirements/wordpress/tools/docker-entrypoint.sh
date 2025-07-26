#!/bin/sh
set -e

DB_PASS=$(cat /run/secrets/db_password.txt)
DB_NAME=${MYSQL_DATABASE}
DB_USER=${MYSQL_USER}
ADMIN_USER=${WP_ADMIN_USER}
ADMIN_PASS=$(cat /run/secrets/credentials.txt)
ADMIN_EMAIL=${WP_ADMIN_EMAIL}
REGULAR_USER=${WP_USER}
REGULAR_PASS=$(cat /run/secrets/user_credentials.txt)
REGULAR_EMAIL=${WP_USER_EMAIL}
DOMAIN=${DOMAIN_NAME}

cd /var/www/wordpress

# Download WordPress if not present
if [ ! -f "wp-load.php" ]; then
    wp core download --allow-root
fi

# Generate wp-config.php
if [ ! -f "wp-config.php" ]; then
    wp config create --dbname="$DB_NAME" \
                     --dbuser="$DB_USER" \
                     --dbpass="$DB_PASS" \
                     --dbhost="mariadb" \
                     --allow-root
fi

# Install WordPress core (if not already installed)
if ! wp core is-installed --allow-root; then
    wp core install --url="$DOMAIN" \
                    --title="Inception" \
                    --admin_user="$ADMIN_USER" \
                    --admin_password="$ADMIN_PASS" \
                    --admin_email="$ADMIN_EMAIL" \
                    --skip-email \
                    --allow-root

    # Create regular user
    wp user create "$REGULAR_USER" "$REGULAR_EMAIL" \
                   --user_pass="$REGULAR_PASS" \
                   --role=author \
                   --allow-root
fi

exec php-fpm -F
