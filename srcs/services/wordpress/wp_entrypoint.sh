#! /usr/bin/env sh

# Exit shell script when any command fails
set -e

id www-data > /dev/null 2>&1 || adduser -S www-data -G www-data

cd /usr/local/bin \
&& curl -LO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > /dev/null 2>&1 \
&& chmod +x wp-cli.phar \
&& mv wp-cli.phar wp

if [[ ! -f /var/www/ghan.42.fr/index.php ]]; then
	cd /var/www \
	&& wp core download --path=ghan.42.fr --version=latest \
	&& chown -R www-data:www-data /var/www/ghan.42.fr \
	&& cd ghan.42.fr \
	&& wp config create --dbhost=$DB_HOST --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWD \
	&& wp db create \
	&& wp core install --url=https://ghan.42.fr/ --title="ghan's inception" --admin_user=$ADMIN_USER \
		--admin_password=$ADMIN_PASSWD --admin_email=$ADMIN_EMAIL --skip-email
fi

# Execute php-fpm
echo -e '\n\n"You Mustn’t Be Afraid To Dream A Little Bigger, Darling."\nWORDPRESS IS READY!\n\n'
exec tini -- "$@"
