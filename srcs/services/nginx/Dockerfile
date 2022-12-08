FROM alpine:3.16

# Install necessary pacakges & set timezone
RUN apk update \
	&& apk add --no-cache ca-certificates=20220614-r0 \
	curl=7.83.1-r4 \
	openssl=1.1.1s-r0 \
	tini=0.19.0-r0 \
	tzdata=2022f-r1 \
	&& cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
	&& apk del tzdata

# Install the latest stable NGINX from nginx repository
RUN printf "%s%s%s%s\n" \
	"@nginx " \
	"http://nginx.org/packages/alpine/v" \
	`egrep -o '^[0-9]+\.[0-9]+' /etc/alpine-release` \
	"/main" \
	| tee -a /etc/apk/repositories \
	&& curl -o /tmp/nginx_signing.rsa.pub https://nginx.org/keys/nginx_signing.rsa.pub \
	&& mv /tmp/nginx_signing.rsa.pub /etc/apk/keys/ \
	&& apk add --no-cache nginx@nginx

# Copy the entrypoint script
WORKDIR /root
COPY nginx_entrypoint.sh .

ENTRYPOINT [ "./nginx_entrypoint.sh", "nginx", "-g", "daemon off;" ]