FROM alpine:3.16

# Install necessary pacakges & set timezone
RUN apk update \
	&& apk add --no-cache mysql=10.6.10-r0 \
	mysql-client=10.6.10-r0 \
	tini=0.19.0-r0 \
	tzdata=2022f-r1 \
	&& cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
	&& apk del tzdata

# Copy the entrypoint script
WORKDIR /root
COPY db_entrypoint.sh .

# Set healthcheck command
HEALTHCHECK --start-period=2s --interval=5s --retries=5 CMD pgrep tini && mariadb-admin ping

ENTRYPOINT [ "./db_entrypoint.sh", "mariadbd", "--user=mysql" ]

