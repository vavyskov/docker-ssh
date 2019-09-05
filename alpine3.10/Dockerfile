## Multi-stage builds

ARG PHP_FROM=
ARG COMPOSER_FROM=
#ARG PHP_FROM=vavyskov/php:7.2-fpm-alpine3.10
#ARG COMPOSER_FROM=vavyskov/php:7.2-fpm-alpine3.10

FROM ${PHP_FROM:-alpine:3.10} AS php
RUN test -f /usr/local/bin/php || mkdir -p /usr/local/bin/php \
&&  test -d /usr/lib || mkdir -p /usr/lib

FROM ${COMPOSER_FROM:-alpine:3.10} AS composer
RUN test -f /usr/bin/composer || mkdir -p /usr/bin/composer

FROM alpine:3.10

ENV USER_NAME=www-data
ENV USER_PASSWORD=www-data
ENV USER_GROUP=www-data
ENV USER_HOME=/var/www

RUN apk add --no-cache \
        openssh-server \
        bash \
## Prevents unwanted restarting of the container (when using the docker-compose.yml)
&&  ssh-keygen -A

## Php (get path command: which php, php -i | grep extension_dir)
COPY --from=php /usr/local/bin/php /usr/local/bin/php
COPY --from=php /usr/lib /usr/lib

## Composer (get path command: which composer)
COPY --from=composer /usr/bin/composer /usr/bin/composer

#VOLUME ${USER_HOME}/html

## Initialize container
COPY config/entrypoint.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
