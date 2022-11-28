#! /usr/bin/env sh

# Exit shell script when any command fails
set -e

if [[ ! -f /var/www/ghan.42.fr/index.php ]]; then
	cd /var/www \
	&& wp core download --path=ghan.42.fr --version=latest \
	&& cd ghan.42.fr \
	&& wp config create --dbhost=$WP_DB_HOST --dbname=$WP_DB_NAME --dbuser=$WP_DB_USER --dbpass=$WP_DB_PASSWD 
	
	# Wait until maraidb server is ready
	mariadb-admin ping --user=$WP_DB_USER -p$WP_DB_PASSWD --host=$WP_DB_HOST --wait=.5 --connect-timeout=10
	
	wp db create \
	&& wp core install --url=https://ghan.42.fr/ --title="ghan's inception" --admin_user=$ADMIN_USER \
		--admin_password=$ADMIN_PASSWD --admin_email=$ADMIN_EMAIL --skip-email
fi

# Execute php-fpm
echo -e '\n\n"You Mustn’t Be Afraid To Dream A Little Bigger, Darling."\nWORDPRESS IS READY!\n\n'
exec tini -- "$@"
