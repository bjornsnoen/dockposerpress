set -e

### Install vim, mysqli, xdebug, mhsendmail ###
apk add $PHPIZE_DEPS vim sudo

wget https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64
chmod +x mhsendmail_linux_amd64
mv mhsendmail_linux_amd64 /usr/local/bin/mhsendmail

pecl install xdebug-2.8.1
