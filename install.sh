#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

cd $SCRIPTPATH

cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.$(date | tr ' ' -)
ln -s -f $SCRIPTPATH/nginx.conf /etc/nginx/nginx.conf

sed -i "s!set \$nbody_proxy_root.*!set \$nbody_proxy_root $SCRIPTPATH!g" nginx.conf

mkdir -p /var/www/nbody
cp -R ./www/* /var/www/nbody
chmod -R a+r-w /var/www/nbody
chmod a+x /var/www/nbody

chown -R www-data /var/www/nbody
