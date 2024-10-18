#!/bin/bash

mkdir -p $"/etc/ssl/private"

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $"/etc/ssl/private"/$DOMAIN.key -out $"/etc/ssl/private"/$DOMAIN.crt \
    -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/OU=$UNIT/CN=$DOMAIN"

sed -i "s/\$DOMAIN/$DOMAIN/g" /etc/nginx/sites-available/default
