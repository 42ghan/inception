#! /usr/bin/env sh

set -e

if [[ ! -f /var/www/adminer/index.php ]]; then
	# Download Adminer script
	curl -LO https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql-en.php \
	&& mv adminer-4.8.1-mysql-en.php /var/www/adminer/index.php
fi

# Write error logs to STDERR
sed -i 's/;error_log = .*/error_log = \/dev\/stderr/' /etc/php8/php-fpm.conf

# Execute php-fpm
echo -e '\n\n"The dreamer can always remember the genesis of the idea."\nADMINER IS READY!\n\n'
exec tini -- "$@"
