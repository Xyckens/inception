#!/bin/bash

chown -R www-data:www-data /var/www/html/

# Checks if wp-config.php is present
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "WordPress configuration file not found!"
    exit 1
fi

# Ensures other services (like databases) are fully initialized before attempting to install or configure WordPress.
sleep 10

# Using the WP-CLI (WordPress Command Line Interface) to download and install wordpress,
# setting some important variables, as the URL, the title, the admin user information and a not-admin user with the role of editor

# Download WordPress core files if not already downloaded
# The '|| true' ensures that if the download fails (e.g., files are already present), the script does not stop.
wp --allow-root --path="/var/www/html/" core download || true

# Installs wordpress if it is not already installed
# Sets the admin user and password if they are not already set
if ! wp --allow-root --path="/var/www/html/" core is-installed ; then
    wp  --allow-root --path="/var/www/html/" core install \
        --url=$WP_URL \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL
fi;

# If user does not exist, create user
if ! wp --allow-root --path="/var/www/html/" user get $WP_USER ; then
    wp  --allow-root --path="/var/www/html/" user create \
        $WP_USER \
        $WP_EMAIL \
        --user_pass=$WP_PASSWORD \
        --role=$WP_ROLE
fi;

# Execute the command passed to the script
exec $@