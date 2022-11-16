FROM alpine:3.15

RUN apk update \
	&& apk add --no-cache mysql=10.6.10-r0 \
	mysql-client=10.6.10-r0

COPY my.cnf /etc/my.cnf

RUN mysql_install_db

EXPOSE 3306

RUN set -ex && \ 
	chmod 770 /var/lib/mysql/mysql 

USER mysql
ENTRYPOINT ["mysqld"]
