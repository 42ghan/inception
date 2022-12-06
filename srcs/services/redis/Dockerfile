FROM alpine:3.15

RUN apk update \
	&& apk add --no-cache redis=6.2.7-r0 \
	tini=0.19.0-r0 \
	su-exec=0.2-r1 \
	tzdata=2022f-r1 \
	&& cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
	&& apk del tzdata

WORKDIR /root
COPY ./redis_entrypoint.sh .

HEALTHCHECK --start-period=2s --interval=5s --retries=5 CMD redis-cli -a $REDIS_PASSWD PING

ENTRYPOINT [ "./redis_entrypoint.sh" ]