FROM        ubuntu:16.04
MAINTAINER  Markus Krallinger "mkrallinger@gmail.com"


#ADD         ondrej-ubuntu-php-7_0-wily.list /etc/apt/sources.list.d/ondrej-ubuntu-php-7_0-wily.list
#RUN         apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
RUN          echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu `. /etc/lsb-release && echo $DISTRIB_CODENAME` main" > \
             /etc/apt/sources.list.d/ondrej-ubuntu-php-wily.list \
             && echo "deb-src http://ppa.launchpad.net/ondrej/php/ubuntu `. /etc/lsb-release && echo $DISTRIB_CODENAME` main" >> \
             /etc/apt/sources.list.d/ondrej-ubuntu-php-wily.list \
             && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C

RUN         apt-get update && \
            DEBIAN_FRONTEND=noninteractive apt-get install -y php7.0-cli php7.0-mb php7.0-gd php7.0-pgsql php7.0-curl php7.0-intl php7.0-fpm nginx php7.0-zip php7.0-xml php7.0-json

ADD         nextcloud-10.0.0.tar.bz2 /var/www/
ADD         config.php /var/www/nextcloud/config/config.php
ADD         bootstrap.sh /usr/bin/

RUN         groupmod -g 1001 www-data && \
            usermod -u 1003 www-data && \
            chown -R www-data:www-data /var/www/nextcloud && \
            chmod +x /usr/bin/bootstrap.sh

ADD         nginx.conf /root/
ADD         php.ini /etc/php/7.0/fpm/
ADD         www.conf /etc/php/7.0/fpm/pool.d/


EXPOSE      80
EXPOSE      443

ENTRYPOINT  ["bootstrap.sh"]
