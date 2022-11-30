#! /usr/bin/env sh

set -e

curl -LO https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql-en.php \
&& mv adminer-4.8.1-mysql-en.php /var/www/adminer/index.php
# && chown -R www-data:www-data /var/www/adminer \
# && chown -R www-data:www-data /var/log/php7

# Execute php-fpm
echo -e '\n\n"The dreamer can always remember the genesis of the idea."\nADMINER IS READY!\n\n'
exec tini -- "$@"
