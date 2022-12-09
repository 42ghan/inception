#! /usr/bin/env sh

set -e

mkdir -p /srv/www/ssl \
&& cd /srv/www/ssl

echo -e "\nPrepare Digital Certificate for TLS layer\n\n"

# Create CA's Certificate
openssl req -x509 -newkey rsa:4096 -days 365 -keyout ca-key.pem -out ca-cert.pem \
-nodes -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Education/CN=ghan.42.fr/emailAddress=$NGINX_USER_EMAIL" > /dev/null 2>&1

# Create Server Key and CSR
openssl req -newkey rsa:4096 -keyout ghan.42.fr-key.pem -out server-req.pem --nodes -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Education/CN=ghan.42.fr/emailAddress=$NGINX_USER_EMAIL" > /dev/null 2>&1

# Create and Sign Digital Certificate
openssl x509 -req -in server-req.pem -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out ghan.42.fr-cert.pem > /dev/null 2>&1

# Generate DHPARAM
openssl dhparam -out /srv/www/ssl/dhparam.pem 2048 > /dev/null 2>&1

# Test NGINX
nginx -t

# Execute NGINX
echo -e '\n\n"Admit it: you don’t believe in one reality anymore."\nNGINX IS UP!\n\n'
exec tini -- "$@"