FROM        ubuntu:16.04
MAINTAINER  Markus Krallinger "mkrallinger@gmail.com"

RUN         apt-get update && apt-get install -y --no-install-recommends apt-utils \ 
    software-properties-common \
    python-software-properties \
    language-pack-en-base 
RUN         LC_ALL=C.UTF-8 add-apt-repository -y -u ppa:ondrej/php && apt-get update 

#RUN          echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu `. /etc/lsb-release && echo $DISTRIB_CODENAME` main" > \
#             /etc/apt/sources.list.d/ondrej-ubuntu-php-wily.list \
#             && echo "deb-src http://ppa.launchpad.net/ondrej/php/ubuntu `. /etc/lsb-release && echo $DISTRIB_CODENAME` main" >> \
#             /etc/apt/sources.list.d/ondrej-ubuntu-php-wily.list \
#             && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C

RUN         apt-get update && \
            DEBIAN_FRONTEND=noninteractive apt-get install -y redis-server php7.1-redis php7.1-apcu php7.1-cli php7.1-mb php7.1-gd php7.1-pgsql php7.1-curl php7.1-intl php7.1-fpm nginx php7.1-zip php7.1-xml php7.1-json 
ADD         nextcloud-16.0.0.tar.bz2 /var/www/
ADD         config.php /var/www/nextcloud/config/config.php
ADD         bootstrap.sh /usr/bin/

RUN         groupmod -g 1001 www-data && \
            usermod -u 1003 www-data && \
            chown -R www-data:www-data /var/www/nextcloud && \
            chmod +x /usr/bin/bootstrap.sh && \
            usermod -a -G redis www-data

ADD         nginx.conf /root/
ADD         php.ini /etc/php/7.1/fpm/
ADD         www.conf /etc/php/7.1/fpm/pool.d/
ADD         redis.conf /etc/redis/redis.conf

EXPOSE      80
EXPOSE      443

ENTRYPOINT  ["bootstrap.sh"]
