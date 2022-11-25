FROM alpine:3.15

RUN apk update \
	&& apk add --no-cache php7 \
	php7-fpm \
	php7-opcache \
	php7-gd \
	php7-mysqli \
	php7-zlib \
	php7-curl \
	php7-phar \
	php7-json \
	php7-iconv \
	mysql-client=10.6.10-r0 \
	curl=7.80.0-r4 \
	tini=0.19.0-r0 \
	tzdata \
	&& cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
	&& apk del tzdata

COPY wp_entrypoint.sh .

ENTRYPOINT [ "./wp_entrypoint.sh", "php-fpm7", "-F" ]