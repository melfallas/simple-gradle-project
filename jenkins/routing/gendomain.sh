#!/bin/bash

export ROUTING_DIR="/var/jenkins_home/workspace/pipeline-maven-test/jenkins/routing"

DNS_API_TOKEN=$1

export IMAGE=$(sed -n '1p' /tmp/.auth)
export TAG=$(sed -n '2p' /tmp/.auth)
export CONTAINER_NAME=$(sed -n '3p' /tmp/.auth)
export ENV=$(sed -n '4p' /tmp/.auth)
export HOST_PORT=$(sed -n '5p' /tmp/.auth)
export DOCKER_PORT=$(sed -n '6p' /tmp/.auth)

export SERVER_IP="157.230.153.157"

# Default constanst
SUBDOMAIN=$CONTAINER_NAME-$ENV
DOMAIN="mbsoftware.ml"
PROXY_PORT=$HOST_PORT
CONFIG_PATH="/var/nginx/conf"

#sh ./generate-domain-config.sh $SUBDOMAIN $DOMAIN $PROXY_PORT $CONFIG_PATH

#SUBDOMAIN_PATTERM="app1-ist"
#SUBDOMAIN_PATTERM="name:app1-ist,"

# Create needed string variables
SERVER_NAME=$SUBDOMAIN.$DOMAIN
PROXY_LOCATION=http://$DOMAIN:$PROXY_PORT
SUBDOMAIN_PATTERM="\"name\":\"$SUBDOMAIN\","
CONF_FILE_NAME=$SERVER_NAME.conf

echo ""
echo "############################"
echo "*** Procesing Web Domain ***"
echo "############################"
echo ""
echo "|"
echo "Registered API Token: $DNS_API_TOKEN"
echo "|"
echo "Consulting existing domains..."
echo "|"
DOMAIN_MATCH_LIST=$(curl -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DNS_API_TOKEN" \
  "https://api.digitalocean.com/v2/domains/$DOMAIN/records?type=A&name=$SERVER_NAME"
  )
#  "https://api.digitalocean.com/v2/domains/mbsoftware.ml/records?type=A&name=app1-ist.mbsoftware.ml"

echo "|"
echo "Domain match list:"
echo "---"
echo "$DOMAIN_MATCH_LIST"
echo "---"
echo "|"
#echo "$DOMAIN_MATCH_LIST" | grep $SUBDOMAIN_PATTERM
#echo "|"
DOMAIN_RECORD=$(echo "$DOMAIN_MATCH_LIST" | grep $SUBDOMAIN_PATTERM)
#echo "Match: $DOMAIN_RECORD"
if [ -z "$DOMAIN_RECORD" ]
then
    echo "Not existing domain: $SERVER_NAME"
    echo "Creating domain by API endpoint..."
	CREATE_DOMAIN_RESULT=$(curl -X POST \
	  -H "Content-Type: application/json" \
	  -H "Authorization: Bearer $DNS_API_TOKEN" \
	  -d "{\"type\":\"A\",\"name\":\"$SUBDOMAIN\",\"data\":\"$SERVER_IP\",\"priority\":null,\"port\":null,\"ttl\":1800,\"weight\":null,\"flags\":null,\"tag\":null}" \
	  "https://api.digitalocean.com/v2/domains/$DOMAIN/records"
	  )
	echo "|"
	echo "Domain creation result:"
	echo "---"
	echo "$CREATE_DOMAIN_RESULT"
	echo "---"
else
      echo "Domain alredy existing: $SERVER_NAME"
	  echo "No additional operations needed..."
fi
#exit 1
echo "|"
echo ""
echo "#############################"
echo "*** Configuring Web Proxy ***"
echo "#############################"
echo ""
echo "|"
echo "Executing by user: "
whoami
/usr/bin/id
echo "|"
cd $CONFIG_PATH
echo "Changing to domain config path: $PWD"
echo "|"
echo "Showing directory permissions:"
ls -l ..
echo "|"
echo "Creating file for domain config: $CONF_FILE_NAME"
touch $CONF_FILE_NAME
echo "|"
echo "Generating domain config for $SERVER_NAME"
echo "|"
#if find / -name art  2>&1 | grep -v "Permission denied"
#then
#	echo "Cannot create file $CONF_FILE_NAME: Permission denied" >&2
#	exit 1
#fi
export DOMAIN_CONFIG_TEXT=$(cat<< EOF
server {
    listen 443;
	
    server_name $SERVER_NAME;
	
    ssl_certificate /etc/letsencrypt/live/$DOMAIN/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$DOMAIN/privkey.pem;
	
    location / {
        proxy_pass $PROXY_LOCATION;
    }
}
EOF
);
echo "Config file text:"
echo "---"
echo "$DOMAIN_CONFIG_TEXT"
echo "---"
echo "|"
echo "$DOMAIN_CONFIG_TEXT" > $CONF_FILE_NAME
echo "Domain config location stablish on: $PROXY_LOCATION"
echo "|"
cd $ROUTING_DIR
echo "Changing path to routing directory: $PWD"
echo "|"
echo "***** Reloading proxy server *****"
echo "|"
#cd $ROUTING_DIR && docker-compose -f docker-compose-nginx-ssl-proxy.yml exec nginx-ssl-proxy-server nginx -s reload
docker-compose -f docker-compose-nginx-ssl-proxy.yml -p WebProxyServer exec -T nginx-ssl-proxy-server nginx -s reload
echo "|"
echo "Finish ..."
echo "|"