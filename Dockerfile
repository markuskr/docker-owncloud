FROM		    ubuntu:14.10
MAINTAINER	Markus Krallinger "mkrallinger@gmail.com"

ADD         owncloud-8.0.2.tar.bz2 /var/www/
ADD         nginx_ssl.conf /root/
ADD         nginx.conf /root/

RUN         apt-get update && \
            apt-get install -y php5-cli php5-gd php5-pgsql php5-sqlite php5-mysqlnd php5-curl php5-intl php5-mcrypt php5-ldap php5-gmp php5-apcu php5-imagick php5-fpm smbclient nginx 
RUN         groupmod -g 1001 www-data && \
            usermod -u 1003 www-data && \
            chown -R www-data:www-data /var/www/owncloud 
ADD         bootstrap.sh /usr/bin/
RUN         chmod +x /usr/bin/bootstrap.sh

ADD         php.ini /etc/php5/fpm/

EXPOSE      80
EXPOSE      443

ENTRYPOINT  ["bootstrap.sh"]
