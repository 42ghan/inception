FROM alpine:3.16

WORKDIR /root

ARG TARGETARCH
RUN apk update \
	&& apk add --no-cache curl=7.83.1-r4 \
	git=2.36.3-r0 \
	&& curl -LO https://github.com/jgm/pandoc/releases/download/2.19.2/pandoc-2.19.2-linux-$TARGETARCH.tar.gz \
	&& tar xvzf pandoc-2.19.2-linux-$TARGETARCH.tar.gz --strip-components 1 -C /usr/local \
	&& rm pandoc-2.19.2-linux-$TARGETARCH.tar.gz

COPY static_entrypoint.sh .

ENTRYPOINT [ "./static_entrypoint.sh" ]
