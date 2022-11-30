FROM alpine:3.15

RUN apk update \
	&& apk add --no-cache php7=7.4.33-r0 \
	php7-fpm=7.4.33-r0 \
	php7-session=7.4.33-r0 \
	php7-mysqli=7.4.33-r0 \
	curl=7.80.0-r4 \
	tini=0.19.0-r0 \
	&& id www-data > /dev/null 2>&1 || adduser -S www-data -G www-data

WORKDIR /root
COPY adminer_entrypoint.sh .

ENTRYPOINT [ "./adminer_entrypoint.sh", "php-fpm7", "-F" ]
