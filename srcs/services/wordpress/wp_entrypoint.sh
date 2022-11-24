#! /usr/bin/env sh

# Exit shell script when any command fails
set -e

adduser -S www-data -G www-data

sed -i 's/;cgi.cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/' /etc/php7/php.ini
sed -i 's/;extension=curl.so/extension=curl.so/' /etc/php7/php.ini
sed -i 's/listen = 127.0.0.1:9000/listen = 172.18.0.3:9000/' /etc/php7/php-fpm.d/www.conf
sed -i 's/nobody/www-data/g' /etc/php7/php-fpm.d/www.conf

cd /var/www

curl -LO https://wordpress.org/latest.tar.gz

tar -xzvf latest.tar.gz
rm latest.tar.gz

exec tini -- "$@"
