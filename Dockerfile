FROM php:7.4-fpm-alpine as blog-base-installer
RUN apk add patch
LABEL org.opencontainers.image.source = "https://github.com/bjornsnoen/dockposerpress"
COPY ./wordpress /app
COPY --from=composer/composer /usr/bin/composer /usr/bin/composer
WORKDIR /app
RUN composer install


FROM php:7.4-fpm-alpine as blog-base-runner
LABEL org.opencontainers.image.source = "https://github.com/bjornsnoen/dockposerpress"
USER root
RUN docker-php-ext-install mysqli
COPY ./dbcheck.php /usr/local/bin/dbcheck
# Overwrite original in order to activate all installed plugins first
COPY ./docker-php-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]


FROM blog-base-runner as blog-base-runner-debug
LABEL org.opencontainers.image.source = "https://github.com/bjornsnoen/dockposerpress"
COPY ./install-dev-deps.sh /
RUN sh /install-dev-deps.sh
COPY ./xdebug.ini /usr/local/etc/php/conf.d/
COPY ./mhsendmail.ini /usr/local/etc/php/conf.d/