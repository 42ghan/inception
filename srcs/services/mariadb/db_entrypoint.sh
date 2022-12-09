#! /usr/bin/env sh

# Exit shell script when any command fails
set -e

# Check if system table is already installed
if [[ ! -d /var/lib/mysql/mysql ]]; then
	# Install or upgrade system table according to a configuration provided by /etc/my.cnf
	mariadb-install-db --user=mysql

	# Execute mariadb server
	"$@" &

	# Wait until mariadb server is ready
	mariadb-admin ping --wait=.5 --connect-timeout=10

	# Initialize user and restart db
	mariadb -u root -e "DROP DATABASE IF EXISTS test; \
	CREATE DATABASE wordpress; \
	CREATE USER IF NOT EXISTS 'root'@'$HOST_ADDRESS'; \
	GRANT ALL ON *.* TO 'root'@'$HOST_ADDRESS' IDENTIFIED BY '$HOST_DB_PASSWD' WITH GRANT OPTION; \
	CREATE USER IF NOT EXISTS '$DB_USER'@'$WP_REMOTE_ADDRESS'; \
	GRANT ALL ON wordpress.* TO '$DB_USER'@'$WP_REMOTE_ADDRESS' IDENTIFIED BY '$DB_PASSWD'; \
	CREATE USER IF NOT EXISTS '$DB_USER'@'$ADMINER_REMOTE_ADDRESS'; \
	GRANT ALL ON wordpress.* TO '$DB_USER'@'$ADMINER_REMOTE_ADDRESS' IDENTIFIED BY '$DB_PASSWD';"

	# Stop current mariadb server
	mariadb-admin shutdown
fi

# Replace PID 1 with tini and execute mariadb
echo -e '\n\n"Downward Is The Only Way Forward."\nMARIADB IS UP!\n\n'
exec tini -- "$@"
