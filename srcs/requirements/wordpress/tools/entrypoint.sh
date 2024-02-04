#!/bin/bash

# Verifica se o arquivo de configuração do WordPress não existe
if [ ! -f "/var/www/html/wp-config.php" ]; then

    # Remove todos os arquivos no diretório
    rm -rf /var/www/html/*

    # Baixa o WordPress
    wp core download --allow-root
    
    # Renomeia o arquivo de configuração
    mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

    # Substitui as configurações no arquivo wp-config.php
    sed -i "s/database_name_here/$MYSQL_DATABASE/g" /var/www/html/wp-config.php
    sed -i "s/username_here/$WP_ADMIN_USER/g" /var/www/html/wp-config.php
    sed -i "s/password_here/$WP_ADMIN_PWD/g" /var/www/html/wp-config.php
    sed -i "s/localhost/$WP_HOST/g" /var/www/html/wp-config.php

    # Instala o WordPress
    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="Inception" \
        --admin_user=$WP_ADMIN_USER \
        --admin_email=$WP_ADMIN_EMAIL \
        --admin_password=$WP_ADMIN_PWD \
        --skip-email

    # Ativa o tema Astra
    wp theme install astra --allow-root
    wp theme activate astra --allow-root
    wp theme delete twentytwentyfour --allow-root
    wp theme delete twentytwentythree --allow-root
    wp theme delete twentytwentytwo --allow-root

    # Cria um usuário
    wp user create --allow-root \
        --user_login=$WP_USER \
        --user_email=$WP_EMAIL \
        --role=author \
        --user_pass=$WP_PASSWORD

    # Desinstala plugins padrão
    wp plugin uninstall akismet hello --allow-root

    # Atualiza todos os plugins
    wp plugin update --all --allow-root

    # Ajusta as permissões
    chown -R www-data:www-data /var/www/html

fi

# Executa o PHP-FPM
exec php-fpm7.4 -F
