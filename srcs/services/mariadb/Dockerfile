FROM alpine:3.15

RUN apk update \
	&& apk add --no-cache mysql=10.6.10-r0 \
	mysql-client=10.6.10-r0 \
	tini=0.19.0-r0


COPY my.cnf /etc/my.cnf

ARG DB_ADDRESS
RUN	DB_BIND_ADDRESS=$DB_ADDRESS \
	; sed -i "s/bind-address=/bind-address=$DB_BIND_ADDRESS/" /etc/my.cnf

EXPOSE 3306

WORKDIR /var/lib/mysql

COPY db_entrypoint.sh .

RUN ./db_entrypoint.sh

ENTRYPOINT ["tini", "--", "mariadbd", "--user=mysql"]
