FROM php:7.4-fpm-alpine as blog-base

COPY ./install-deps.sh ./install-composer.sh /

RUN sh /install-deps.sh && sh /install-composer.sh

COPY ./xdebug.ini /usr/local/etc/php/conf.d/
COPY ./mhsendmail.ini /usr/local/etc/php/conf.d/
COPY ./dbcheck.php /usr/local/bin/dbcheck
# Overwrite original in order to activate all installed plugins first
COPY ./docker-php-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
