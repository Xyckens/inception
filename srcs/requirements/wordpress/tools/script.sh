#!bin/bash

cp -f /tmp/wp-config.php /var/www/html
chmod 644 /var/www/html/wp-config.php;

# https://developer.wordpress.org/cli/commands/core/install/
wp core install --url="fvieira.42.fr --admin_name"evaluator" --admin_password="1234" --allow_root

wp user create "franc" --user_pass="1234" --allow-root

service php7.3-fpm start;
service php7.3-fpm stop;

php-fpm7.3 -F -R