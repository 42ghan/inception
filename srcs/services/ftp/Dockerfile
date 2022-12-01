FROM alpine:3.15

RUN apk update \
	&& apk add --no-cache vsftpd=3.0.5-r1 \
	tini=0.19.0-r0

WORKDIR /root
COPY ./ftp_entrypoint.sh .

ENTRYPOINT [ "./ftp_entrypoint.sh" ]
