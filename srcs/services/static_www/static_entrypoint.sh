#! /usr/bin/env sh

set -e

git clone https://github.com/42ghan/inception

if [[ ! -f /var/www/static/CONTAINER.html ]]; then
  mkdir -p /var/www/static/services
  cd inception/docs
  find ./ -name "*.md" -type f -exec sh -c 'pandoc "${0}" -f markdown -t html -o "/var/www/static/${0%.md}.html"' {} \; \
  && mv ./assets /var/www/static/assets
fi

echo -e '\n\n"True Inspiration Is Impossible To Fake."\n\nSTATIC WEBSITE IS READY!\n\n'
