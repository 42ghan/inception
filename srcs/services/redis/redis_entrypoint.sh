#! /usr/bin/env sh

# Execute redis
echo -e '\n\n"An idea is like a virus."\nREDIS IS UP!\n\n'
exec tini -- su-exec redis:redis redis-server /etc/redis.conf --requirepass $REDIS_PASSWD
