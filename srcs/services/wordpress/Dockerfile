FROM alpine:3.16

# Install necessary pacakges & set timezone
RUN apk update \
	&& apk add --no-cache php8=8.0.26-r0 \
	php8-fpm=8.0.26-r0 \
	php8-common=8.0.26-r0 \
	php8-opcache=8.0.26-r0 \
	php8-gd=8.0.26-r0 \
	php8-mysqli=8.0.26-r0 \
	php8-curl=8.0.26-r0 \
	php8-phar=8.0.26-r0 \
	php8-iconv=8.0.26-r0 \
	php8-tokenizer=8.0.26-r0 \
	mysql-client=10.6.10-r0 \
	curl=7.83.1-r4 \
	tini=0.19.0-r0 \
	tzdata=2022f-r1 \
	su-exec=0.2-r1 \
	&& cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
	&& apk del tzdata

# Install wp-cli & set up user and privileges in order to run Wordpress Server
RUN cd /usr/local/bin \
	&& curl -LO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > /dev/null 2>&1 \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar wp \
	&& id www-data > /dev/null 2>&1 || adduser -S www-data -G www-data \
	&& mkdir -p /var/www/ghan.42.fr \
	&& chown -R www-data:www-data /var/www/ghan.42.fr \
	&& chown -R www-data:www-data /var/log/php8

# Copy the entrypoint script
WORKDIR /root
COPY wp_entrypoint.sh .

ENTRYPOINT [ "./wp_entrypoint.sh", "php-fpm8", "-F" ]