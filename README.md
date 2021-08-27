# Dockerized bedrock wordpress base
Boilerplate images for running bedrock wordpress sites in docker containers.
The runner image has the mysql driver for php preconfigured and an entrypoint that waits
for the database to be up before enabling plugins and starting php-fpm.

## Usage
The `bjornsnoen/dockposerpress:installer` image is used to install plugins/themes and to apply any patches etc.
The `bjornsnoen/dockposerpress:runner` image is used as a base for the runtime container. An example
for how to use these images to build a blog container would be something like this:

```Dockerfile
FROM bjornsnoen/dockposerpress:installer as install-step
COPY my/repo/some-plugin.patch /app/patches/
# Refer to https://github.com/cweagans/composer-patches#using-an-external-patch-file for format
COPY my/repo/composer.patches.json /app/composer.patches.json
RUN composer require wpackagist-plugin/some-plugin:^version etc.


FROM bjornsnoen/dockposerpress:runner as runner
COPY --from=install-step /app /var/www/blog
```

The resulting runner container requires the following environment variables to be set

| Variable    | Format                     | Notes
|-------------|----------------------------|------------
| DB_HOST     | host:port                  | Copy all the DB_ settings from your database container
| DB_USER     | username                   |
| DB_PASSWORD | password                   |
| DB_NAME     | dbname                     |
| WP_HOME     | https://youradress.com     |
| WP_SITEURL  | https://youradress.com/wp/ | Should always be /wp/ unless you change the bedrock structure

There is also `bjornsnoen/dockposerpress:runner-debug` for if you need xdebug and mhsendmail.