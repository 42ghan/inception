#! /usr/bin/env sh

# Exit shell script when any command fails
set -e

alias su-wp="su-exec www-data wp"

if [[ ! -f /var/www/ghan.42.fr/index.php ]]; then
	cd /var/www \
	&& su-wp core download --path=ghan.42.fr --version=latest \
	&& cd ghan.42.fr \
	&& su-wp config create --dbhost=$WP_DB_HOST --dbname=$WP_DB_NAME --dbuser=$WP_DB_USER --dbpass=$WP_DB_PASSWD
	
	# Wait until maraidb server is ready
	mariadb-admin ping --user=$WP_DB_USER -p$WP_DB_PASSWD --host=$WP_DB_HOST --wait=.5 --connect-timeout=10
	
	su-wp db create \
	&& su-wp core install --url=https://ghan.42.fr/ --title=Inception --admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWD --admin_email=$WP_ADMIN_EMAIL --skip-email \
	&& su-wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWD --role=author \
	&& su-wp plugin install --activate redis-cache \
	&& su-wp config set WP_REDIS_HOST $REDIS_HOST \
	&& su-wp config set WP_REDIS_PASSWORD $REDIS_PASSWD \
	&& su-wp redis enable
fi

# Execute php-fpm
echo -e '\n\n"You Mustn’t Be Afraid To Dream A Little Bigger, Darling."\nWORDPRESS IS READY!\n\n'
exec tini -- "$@"
