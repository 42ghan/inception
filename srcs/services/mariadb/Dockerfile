FROM alpine:3.15

RUN apk update \
	&& apk add --no-cache mysql=10.6.10-r0 \
	mysql-client=10.6.10-r0 \
	tini=0.19.0-r0

COPY db_entrypoint.sh .

ENTRYPOINT [ "./db_entrypoint.sh", "mariadbd", "--user=mysql" ]
