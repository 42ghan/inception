#! /usr/bin/env sh

# Exit shell script when any command fails
set -e

# Check if system table is already installed
if [[ ! -d /var/lib/mysql/mysql ]]; then
	# Install or upgrade system table according to configuration provided by /etc/my.cnf
	mariadb-install-db --user=mysql

	# Execute mariadb server
	"$@" &

	# Wait until maraidb server is ready
	mariadb-admin ping --wait=.5

	# Initialize user and restart db
	mariadb -u root -e "DROP DATABASE IF EXISTS test;" \
	&& mariadb -u root -e "CREATE USER IF NOT EXISTS 'inception'@'172.18.0.3';" \
	&& mariadb -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'inception'@'172.18.0.3' IDENTIFIED BY 'ghandb';"

	# Stop current mariadb server
	mariadb-admin shutdown
	
	clear
fi

# Replace PID 1 with tini and execute mariadb
echo -e '\n\n"Downward Is The Only Way Forward."\nWELCOME TO MARIADB!\n\n'
exec tini -- "$@"
