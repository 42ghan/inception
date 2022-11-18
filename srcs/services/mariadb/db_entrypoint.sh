#! /usr/bin/env sh

# Exit shell script when any command fails
set -e

# Install system table according to configuration provided by /etc/my.cnf
# && Grant permission to access mysql data to the group, mysql
mariadb-install-db --user=mysql
# && chmod 750 /var/lib/mysql/mysql

# Execute mariadb server
# Create
mariadbd --user=mysql &

mariadb-admin ping --wait=.5;

mariadb -u root -e "DROP DATABASE IF EXISTS test;" \
&& mariadb -u root -e "CREATE USER inception@172.18.0.3;" \
&& mariadb -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'inception'@'172.18.0.3' IDENTIFIED BY 'ghandb';"
