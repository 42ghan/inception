FROM alpine:3.15

ARG TARGETARCH
RUN apk update \
	&& apk add tini=0.19.0-r0 \
	&& wget https://github.com/google/cadvisor/releases/download/v0.46.0/cadvisor-v0.46.0-linux-$TARGETARCH \
	&& chmod +x cadvisor-v0.46.0-linux-$TARGETARCH \
	&& mv cadvisor-v0.46.0-linux-$TARGETARCH /usr/local/bin/cadvisor

WORKDIR /root
COPY ./cadvisor_entrypoint.sh .

ENTRYPOINT [ "./cadvisor_entrypoint.sh" ]