#!/bin/bash

# Get script parameters
SUBDOMAIN=$1
DOMAIN=$2
LOCATION=$3

# Create server name string
SERVER_NAME=$SUBDOMAIN.$DOMAIN

#define the template.
cat  << EOF
server {
    listen 443 default_server;
    listen [::]:443 default_server ipv6only=on;
	
    server_name $SERVER_NAME;
	
    ssl_certificate /etc/letsencrypt/live/$DOMAIN/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$DOMAIN/privkey.pem;
	
    location / {
        proxy_pass $LOCATION;
    }
}
EOF