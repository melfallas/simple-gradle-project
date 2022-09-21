#!/bin/bash

# Get script parameters
SUBDOMAIN=$1
DOMAIN=$2
PROXY_PORT=$3
CONFIG_PATH=$4

# Create server name string
SERVER_NAME=$SUBDOMAIN.$DOMAIN
PROXY_LOCATION=http://$DOMAIN:$PROXY_PORT
CONF_FILE_NAME=$SERVER_NAME.conf

echo "|"
echo "Generating domain config for $SERVER_NAME"
echo "|"
echo "Domain config path: $CONFIG_PATH"
echo "|"
# Invoke config template
sh ./domain-config-template.sh $SUBDOMAIN $DOMAIN $PROXY_LOCATION > $CONFIG_PATH/$CONF_FILE_NAME
echo "Domain config location stablish on: $LOCATION"
echo "|"
echo "Reloading proxy server"
echo "|"
docker-compose -f docker-compose-nginx-ssl-proxy.yml exec nginx-ssl-proxy-server nginx -s reload
echo "|"
echo "Finish ..."
echo "|"