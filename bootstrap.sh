#!/bin/sh

echo "\nCopying nginx.conf without SSL support..\n"
cp /root/nginx.conf /etc/nginx/nginx.conf
echo "Starting server..\n"
/etc/init.d/php7.0-fpm start
/etc/init.d/nginx start
