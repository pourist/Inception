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
    wp core install --url="https://$DOMAIN" \
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

# Install Redis plugin if not already installed
if ! wp plugin is-installed redis-cache --allow-root; then
    wp plugin install redis-cache --activate --allow-root
fi

# Insert Redis config into wp-config.php if not present
if ! grep -q "WP_REDIS_HOST" wp-config.php; then
    sed -i "/require_once ABSPATH . 'wp-settings.php';/i \
define( 'WP_REDIS_HOST', 'redis' );\n\
define( 'WP_REDIS_PORT', 6379 );\n\
define( 'WP_REDIS_TIMEOUT', 1 );\n\
define( 'WP_REDIS_READ_TIMEOUT', 1 );\n\
define( 'WP_REDIS_DATABASE', 0 );\n" wp-config.php
fi

# Enable Redis object cache
wp redis enable --allow-root || true

exec php-fpm -F
