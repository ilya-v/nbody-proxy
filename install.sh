#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

cd $SCRIPTPATH

cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.$(date | tr ' ' -)
ln -s -f nginx.conf /etc/nginx/nginx.conf

sed -i "s!set \$nbody_proxy_root.*!set \$nbody_proxy_root $SCRIPTPATH!g" nginx.conf

