FROM		    ubuntu:14.10
MAINTAINER	Markus Krallinger "mkrallinger@gmail.com"

ADD         owncloud-8.0.5.tar.bz2 /var/www/
ADD         nginx_ssl.conf /root/
ADD         nginx.conf /root/
ADD         config.php /var/www/owncloud/config/config.php
ADD         bootstrap.sh /usr/bin/
ADD         php.ini /etc/php5/fpm/

RUN         apt-get update && \
            apt-get install -y git php5-cli php5-gd php5-pgsql php5-sqlite php5-mysqlnd php5-curl php5-intl php5-mcrypt php5-ldap php5-gmp php5-apcu php5-imagick php5-fpm smbclient nginx 
RUN         groupmod -g 1001 www-data && \
            usermod -u 1003 www-data && \
            cd /var/www/owncloud/apps && \
            git clone -b stable8 https://github.com/owncloud/galleryplus.git && \ 
            cd galleryplus && \ 
            git pull --rebase origin stable8 && \
            chown -R www-data:www-data /var/www/owncloud && \
            chmod +x /usr/bin/bootstrap.sh

EXPOSE      80
EXPOSE      443

ENTRYPOINT  ["bootstrap.sh"]
