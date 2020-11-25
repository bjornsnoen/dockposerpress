#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

# until php /usr/local/bin/dbcheck; do
# 	>&2 echo ${DB_NAME} is unavailable - sleeping
# 	sleep 2
# done

echo "Enabling plugins"
# cd /var/www/${DB_NAME} && sudo -E -u www-data sh vendor/bin/wp plugin activate --all

exec "$@"