
mysqld_safe --skip-syslog &

while ! mysqladmin ping -hlocalhost --silent; do
    sleep 1
done

if ! mysql -e "USE $MYSQL_DATABASE;"; then
    mysql -e "CREATE DATABASE $MYSQL_DATABASE;"
    mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';"
    mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';"
    mysql -e "ALTER USER '$MYSQL_ROOT'@'localhost' IDENTIFIED BY '123';"
    mysql -e "FLUSH PRIVILEGES;"

    echo "Database created."
else
    echo "Database '$MYSQL_DATABASE' has already been created."
fi

chmod 755 /var/www/html
chown -R www-data:www-data /var/www/html

mysqladmin shutdown

while mysqladmin ping -hlocalhost --silent; do
    sleep 1
done

# Executando o servidor MariaDB novamente
exec mariadbd