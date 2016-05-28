#!/bin/sh

echo "\nCopying nginx.conf without SSL support..\n"
cp /root/nginx.conf /etc/nginx/nginx.conf
#chown -R www-data:www-data /var/www/owncloud/data
echo "Starting server..\n"
/etc/init.d/php7.0-fpm start
/etc/init.d/nginx start
