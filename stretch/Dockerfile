## Multi-stage builds

ARG PHP_FROM=
ARG COMPOSER_FROM=
#ARG PHP_FROM=vavyskov/php:7.2-apache-stretch
#ARG COMPOSER_FROM=vavyskov/php:7.2-apache-stretch

FROM ${PHP_FROM:-debian:stretch-slim} AS php
RUN test -f /usr/local/bin/php || mkdir -p /usr/local/bin/php \
&&  test -d /usr/lib || mkdir -p /usr/lib \
&&  test -d /lib || mkdir -p /lib

FROM ${COMPOSER_FROM:-debian:stretch-slim} AS composer
RUN test -f /usr/bin/composer || mkdir -p /usr/bin/composer

FROM debian:stretch-slim

ENV USER_NAME=www-data
ENV USER_PASSWORD=www-data
ENV USER_GROUP=www-data
ENV USER_HOME=/var/www

RUN	apt-get update \
&&	apt-get install -y --no-install-recommends \
        openssh-server \
#        bash \
## Prevents unwanted restarting of the container (when using the docker-compose.yml)
#&&  ssh-keygen -A \
&&  mkdir /var/run/sshd \
&&  rm -rf /var/lib/apt/lists/*

## Php (get path command: which php, php -i | grep extension_dir)
COPY --from=php /usr/local/bin/php /usr/local/bin/php
COPY --from=php /usr/lib /usr/lib
COPY --from=php /lib /lib

## Composer (get path command: which composer)
COPY --from=composer /usr/bin/composer /usr/bin/composer

## Configuration
RUN sed -i 's/#PasswordAuthentication/PasswordAuthentication/' /etc/ssh/sshd_config



#groupadd user
#useradd -g user user
##usermod -a -G user user
RUN echo "www-data:www-data" | chpasswd
RUN usermod -s /bin/bash www-data
#RUN usermod -s /bin/bash ${USER_NAME}

#VOLUME ${USER_HOME}/html

## Initialize container
#COPY config/entrypoint.sh /usr/local/bin/
#RUN chmod u+x /usr/local/bin/entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
