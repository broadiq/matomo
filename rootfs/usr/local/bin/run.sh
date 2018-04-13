#!/bin/sh
sed -i -e "s/<UPLOAD_MAX_SIZE>/$UPLOAD_MAX_SIZE/g" /nginx/conf/nginx.conf /php/etc/php-fpm.conf \
       -e "s/<MEMORY_LIMIT>/$MEMORY_LIMIT/g" /php/etc/php-fpm.conf \
       -e "s/<OPCACHE_MEM_SIZE>/$OPCACHE_MEM_SIZE/g" /php/conf.d/opcache.ini

#if [ ! -f /config/config.ini.php ] && [ -f /matomo/config/config.ini.php ]; then
#  cp /matomo/config/config.ini.php /config/config.ini.php
#fi

/bin/sed -i \
  -e "s/MYSQL_DB_HOST_PORT/${BRIQ_DB_HOST_PORT}/g" \
  -e "s/MYSQL_DB_USER/${BRIQ_DB_USER}/g" \
  -e "s/MYSQL_DB_PASS/${BRIQ_DB_PASS}/g" \
  -e "s/MYSQL_DB_NAME/${BRIQ_DB_NAME}/g" \
  -e "s/MATOMO_HOST/${BRIQ_HOST}/g" \
  /matomo/config/config.ini.php


#ln -s /config/config.ini.php /matomo/config/config.ini.php
mv matomo fix && mv fix matomo # fix strange bug
chown -R $UID:$GID /matomo /config /var/log /php /nginx /tmp /usr/share/GeoIP /etc/s6.d
exec su-exec $UID:$GID /bin/s6-svscan /etc/s6.d
