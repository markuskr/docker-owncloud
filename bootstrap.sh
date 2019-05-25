#!/bin/sh

echo "\nCopying nginx.conf without SSL support..\n"
cp /root/nginx.conf /etc/nginx/nginx.conf
echo "Starting server..\n"
sysctl vm.overcommit_memory=1
echo never > /sys/kernel/mm/transparent_hugepage/enabled
/etc/init.d/redis-server start
/etc/init.d/php7.1-fpm start
/etc/init.d/nginx start
