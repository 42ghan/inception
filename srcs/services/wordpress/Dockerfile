FROM alpine:3.15

RUN apk update \
	&& apk add --no-cache php7 \
	php7-fpm \
	php7-opcache \
	php7-gd \
	php7-mysqli \
	php7-zlib \
	php7-curl \
	curl \
	tini=0.19.0-r0 \
	tzdata \
	&& cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
	&& apk del tzdata

COPY wp_entrypoint.sh .

ENTRYPOINT [ "./wp_entrypoint.sh", "php-fpm7", "-F" ]