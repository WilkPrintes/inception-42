#!/bin/bash

if [ ! -f "/var/www/html/wp-config.php" ]; then

    rm -rf /var/www/html/*

    wp core download --allow-root
    
    mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

    sed -i "s/database_name_here/$MYSQL_DATABASE/g" /var/www/html/wp-config.php
    sed -i "s/username_here/$WP_ADMIN_USER/g" /var/www/html/wp-config.php
    sed -i "s/password_here/$WP_ADMIN_PWD/g" /var/www/html/wp-config.php
    sed -i "s/localhost/$WP_HOST/g" /var/www/html/wp-config.php

    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="Inception" \
        --admin_user=$WP_ADMIN_USER \
        --admin_email=$WP_ADMIN_EMAIL \
        --admin_password=$WP_ADMIN_PWD \
        --skip-email

    wp theme install astra --allow-root
    wp theme activate astra --allow-root
    wp theme delete twentytwentyfour --allow-root
    wp theme delete twentytwentythree --allow-root
    wp theme delete twentytwentytwo --allow-root

    wp user create $WP_USER $WP_EMAIL \
        --role=author \
        --user_pass=$WP_PASSWORD \
        --allow-root

    wp plugin uninstall akismet hello --allow-root

    wp plugin update --all --allow-root

    chown -R www-data:www-data /var/www/html

fi

exec php-fpm7.4 -F
