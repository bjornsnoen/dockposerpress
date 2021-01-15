FROM php:7.4-fpm-alpine as blog-base
USER root
RUN docker-php-ext-install mysqli
COPY ./dbcheck.php /usr/local/bin/dbcheck
# Overwrite original in order to activate all installed plugins first
COPY ./docker-php-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]


FROM blog-base as blog-base-debug
COPY ./install-dev-deps.sh /
RUN sh /install-dev-deps.sh
COPY ./xdebug.ini /usr/local/etc/php/conf.d/
COPY ./mhsendmail.ini /usr/local/etc/php/conf.d/