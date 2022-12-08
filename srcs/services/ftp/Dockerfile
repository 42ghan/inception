FROM alpine:3.16

RUN apk update \
	&& apk add --no-cache vsftpd=3.0.5-r1 \
	tini=0.19.0-r0 \
	tzdata=2022f-r1 \
	&& cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
	&& apk del tzdata

WORKDIR /root
COPY ./ftp_entrypoint.sh .

ENTRYPOINT [ "./ftp_entrypoint.sh" ]
