FROM        ubuntu:15.10
MAINTAINER  Markus Krallinger "mkrallinger@gmail.com"



RUN         apt-get install -y software-properties-common && \
            LANG=C.UTF-8 add-apt-repository -y ppa:ondrej/php-7.0

RUN         apt-get update && \
            apt-get install -y git php7.0-cli php7.0-gd php7.0-pgsql php7.0-curl php7.0-intl php7.0-fpm nginx

ADD         owncloud-8.2.1.tar.bz2 /var/www/
ADD         config.php /var/www/owncloud/config/config.php
ADD         bootstrap.sh /usr/bin/

RUN         groupmod -g 1001 www-data && \
            usermod -u 1003 www-data && \
            chown -R www-data:www-data /var/www/owncloud && \
            chmod +x /usr/bin/bootstrap.sh

ADD         nginx_ssl.conf /root/
ADD         nginx.conf /root/
ADD         php.ini /etc/php/7.0/fpm/
ADD         www.conf /etc/php/7.0/fpm/pool.d/


EXPOSE      80
EXPOSE      443

#ENTRYPOINT  ["bootstrap.sh"]
