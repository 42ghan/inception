#! /usr/bin/env sh

set -e

if [[ ! -f /var/www/static/CONTAINER.html ]]; then
  mkdir -p /var/www/static/services
  cd inception/docs
  find ./ -name "*.md" -type f \
  -exec sh -c 'pandoc "${0}" -f markdown -t html -o "/var/www/static/${0%.md}.html"' {} \;

  mv ./assets /var/www/static/assets \
  && rm -rf /root/inception
fi
