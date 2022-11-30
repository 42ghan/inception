FROM alpine:3.15

# Install necessary pacakges & set timezone
RUN apk update \
	&& apk add --no-cache php7=7.4.33-r0 \
	php7-fpm=7.4.33-r0 \
	php7-opcache=7.4.33-r0 \
	php7-gd=7.4.33-r0 \
	php7-mysqli=7.4.33-r0 \
	php7-curl=7.4.33-r0 \
	php7-phar=7.4.33-r0 \
	php7-json=7.4.33-r0 \
	php7-iconv=7.4.33-r0 \
	mysql-client=10.6.10-r0 \
	curl=7.80.0-r4 \
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
	&& chown -R www-data:www-data /var/log/php7

# Copy the entrypoint script
WORKDIR /root
COPY wp_entrypoint.sh .

ENTRYPOINT [ "./wp_entrypoint.sh", "php-fpm7", "-F" ]