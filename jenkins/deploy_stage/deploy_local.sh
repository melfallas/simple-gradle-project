#!/bin/bash

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

# Generamos archivo con variables
echo $IMAGE_NAME > /tmp/.auth
echo $BUILD_NUMBER >> /tmp/.auth
echo $CONTAINER_NAME >> /tmp/.auth
echo $ENVIRONMENT >> /tmp/.auth
echo $HOST_PORT >> /tmp/.auth
echo $DOCKER_PORT >> /tmp/.auth
echo $LINUX_USER >> /tmp/.auth
echo $JOB_NAME >> /tmp/.auth

#echo $IMAGE_NAME > ~/jenkins/jenkins_home/jenkins_deploy/.appvar
#echo $BUILD_TAG >> ~/jenkins/jenkins_home/jenkins_deploy/.appvar

# Ejecuta el archivo para publish
#. publish_local.sh