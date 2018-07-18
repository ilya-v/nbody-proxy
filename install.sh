#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

cd $SCRIPTPATH

cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.$(date | tr ' ' -)
ln -s -f $SCRIPTPATH/nginx.conf /etc/nginx/nginx.conf

mkdir -p /var/www/nbody-bin
cp ./bin/* /var/www/nbody-bin
chmod a+r-w /var/www/nbody-bin/*
chmod a+x /var/www/nbody-bin/*
chown -R www-data:www-data /var/www/nbody-bin
chmod 750 /var/www/nbody-bin

echo "echo $(cat ~/.paperspace/config.json  | jq '.apiKey')" > /var/www/nbody-bin/apikey


mkdir -p /var/www/nbody
cp -R ./www/* /var/www/nbody
chmod  -R u=rwx,g=rx,o=r /var/www/nbody
chown -R www-data:www-data /var/www/nbody

mkdir -p /var/www/.ssh
cp /root/.ssh/id_rsa* /var/www/.ssh/
chown -R www-data:www-data /var/www/.ssh
chmod -R 600 /var/www/.ssh
chmod oa+x /var/www/.ssh

systemctl reload nginx
