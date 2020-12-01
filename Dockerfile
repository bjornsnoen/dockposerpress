FROM php:7.4-fpm-alpine as with-composer
ARG uid
COPY ./install-deps.sh ./install-composer.sh /
RUN sh /install-deps.sh && sh /install-composer.sh
RUN adduser -D -u ${uid} composer
USER composer
CMD ["composer", "install"]

FROM php:7.3-fpm-alpine as with-composer-7.3
ARG uid
COPY ./install-deps.sh ./install-composer-one.sh /
RUN sh /install-deps.sh && sh /install-composer-one.sh
RUN adduser -D -u ${uid} composer
USER composer
CMD ["composer", "install"]

FROM node:15-alpine as node-encore
RUN apk add python2 g++ make
USER node

FROM with-composer as blog-base
USER root
COPY ./dbcheck.php /usr/local/bin/dbcheck
# Overwrite original in order to activate all installed plugins first
COPY ./docker-php-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]


FROM blog-base as blog-base-debug
COPY ./xdebug.ini /usr/local/etc/php/conf.d/
COPY ./mhsendmail.ini /usr/local/etc/php/conf.d/