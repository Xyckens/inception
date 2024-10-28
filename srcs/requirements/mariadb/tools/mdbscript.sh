#!/bin/bash

# Remove mysql_install_db as it's no longer needed in newer versions
# mysql_install_db; # This line is deprecated

# Start MariaDB
mysqld_safe &  # Use mysqld_safe instead of trying to use `service`

# Wait for the database to start
sleep 5

# Configure database
if [ -d /var/lib/mysql/${DB_NAME} ]; then
    echo "${DB_NAME} already exists"
else
    # Create database
    mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"

    # Create user for external connections
    mariadb -u root -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
    mariadb -u root -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
    mariadb -u root -e "FLUSH PRIVILEGES;"

    # Create user for local connections
    mariadb -u root -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';"
    mariadb -u root -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';"
    mariadb -u root -e "FLUSH PRIVILEGES;"

    # Create a sample table and insert initial data
    mariadb -u root -e "CREATE TABLE ${DB_NAME}.todo_list (item_id INT AUTO_INCREMENT, content VARCHAR(255), PRIMARY KEY(item_id));"
    mariadb -u root -e "INSERT INTO ${DB_NAME}.todo_list (content) VALUES ('My first task, yay');"
    mariadb -u root -e "INSERT INTO ${DB_NAME}.todo_list (content) VALUES ('Second task, gimme more');"
    mariadb -u root -e "INSERT INTO ${DB_NAME}.todo_list (content) VALUES ('Last task I promise');"
    mariadb -u root -e "INSERT INTO ${DB_NAME}.todo_list (content) VALUES ('One more task');"

    echo "${DB_NAME} database created"
fi

sleep 5

# stops the mariadb service; it is a good practice to stop services after initial setup to ensure they can restart cleanly when the container starts again
service mariadb stop

# executes the command passed to the script as argument (specified by CMD). Replaces the current shell process with the specified command, which is efficient and ensures that signals are correctly passed to the main process
exec $@