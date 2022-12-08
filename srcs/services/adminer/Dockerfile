FROM alpine:3.16

RUN apk update \
	&& apk add --no-cache php8=8.0.26-r0 \
	php8-fpm=8.0.26-r0 \
	php8-session=8.0.26-r0 \
	php8-mysqli=8.0.26-r0 \
	curl=7.83.1-r4 \
	tini=0.19.0-r0 \
	&& id www-data > /dev/null 2>&1 || adduser -S www-data -G www-data

WORKDIR /root
COPY adminer_entrypoint.sh .

ENTRYPOINT [ "./adminer_entrypoint.sh", "php-fpm8", "-F" ]
