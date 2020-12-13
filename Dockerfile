FROM php:7.4-fpm-alpine as blog-base
USER root
RUN docker-php-ext-install mysqli
COPY ./dbcheck.php /usr/local/bin/dbcheck
# Overwrite original in order to activate all installed plugins first
COPY ./docker-php-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]

FROM php:7.4-fpm-alpine as with-composer
ARG uid
COPY ./install-composer.sh /
RUN sh /install-composer.sh && \
    apk add patch && \
    adduser -D -u ${uid} composer
USER composer
CMD ["composer", "install"]

FROM node:15-alpine as node-encore
RUN apk add python2 g++ make
USER node

FROM blog-base as blog-base-debug
COPY ./install-dev-deps.sh /
RUN sh /install-dev-deps.sh
COPY ./xdebug.ini /usr/local/etc/php/conf.d/
COPY ./mhsendmail.ini /usr/local/etc/php/conf.d/