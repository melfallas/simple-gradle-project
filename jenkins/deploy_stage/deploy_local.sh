#!/bin/bash

echo ""
echo "-------------------------------------------------------------------------------------------------------------------"
echo "                                              Procesing Deploy Stage ...                                            "
echo "-------------------------------------------------------------------------------------------------------------------"

echo ""
echo "#########################"
echo "*  Preparing to deploy  *"
echo "#########################"
echo ""

CONTAINER_NAME=$1
ENVIRONMENT=$2
IMAGE_NAME=$3
HOST_PORT=$4
DOCKER_PORT=$5
LINUX_USER=$6
JOB_NAME=$7

# Generate variable file
echo $IMAGE_NAME > /tmp/.auth
echo $BUILD_NUMBER >> /tmp/.auth
echo $CONTAINER_NAME >> /tmp/.auth
echo $ENVIRONMENT >> /tmp/.auth
echo $HOST_PORT >> /tmp/.auth
echo $DOCKER_PORT >> /tmp/.auth
echo $LINUX_USER >> /tmp/.auth
echo $JOB_NAME >> /tmp/.auth