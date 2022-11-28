#! /usr/bin/env sh

set -e

# Creating and TLS certificate and dhparam
mkdir -p /srv/www/ssl \
&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /srv/www/ssl/ghan.42.fr.key -out /srv/www/ssl/ghan.42.fr.crt \
-subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Education/CN=ghan.42.fr/emailAddress=$NGINX_USER_EMAIL" > /dev/null 2>&1 \
&& openssl dhparam -out /srv/www/ssl/dhparam.pem 2048 > /dev/null 2>&1

# Test NGINX
nginx -t

# Execute NGINX
echo -e '\n\n"Admit it: you don’t believe in one reality anymore."\nNGINX IS UP!\n\n'
exec tini -- "$@"