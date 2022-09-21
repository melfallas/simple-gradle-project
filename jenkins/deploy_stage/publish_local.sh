#!/bin/bash

export IMAGE=$(sed -n '1p' /tmp/.auth)
export TAG=$(sed -n '2p' /tmp/.auth)
export APP_NAME=$(sed -n '3p' /tmp/.auth)
export ENV=$(sed -n '4p' /tmp/.auth)
export HOST_PORT=$(sed -n '5p' /tmp/.auth)
export DOCKER_PORT=$(sed -n '6p' /tmp/.auth)
export LINUX_USER=$(sed -n '7p' /tmp/.auth)
export JOB_NAME=$(sed -n '8p' /tmp/.auth)

export CONTAINER_NAME=$APP_NAME-$ENV
export DEPLOY_DIR="/var/jenkins_home/workspace/$JOB_NAME/jenkins/deploy_stage"

# Default constanst
PROJECT_NAME=$APP_NAME-$ENV

#export IMAGE=$(sed -n '1p' /var/jenkins_home/jenkins_deploy/.appvar)
#export TAG=$(sed -n '2p' /var/jenkins_home/jenkins_deploy/.appvar)

echo Setting APP_NAME value: $APP_NAME
echo Setting IMAGE value: $IMAGE
echo Setting TAG value: $TAG
echo Setting SPACE value: $ENV
echo Setting HOST_PORT value: $HOST_PORT
echo Setting DOCKER_PORT value: $DOCKER_PORT
echo Setting LINUX_USER value: $LINUX_USER
echo Setting JOB_NAME value: $JOB_NAME

export AUTOMATIC_PORT=$(($HOST_PORT + $TAG))
echo Setting automatic port: $AUTOMATIC_PORT
echo ""
echo Current Directory: $PWD
echo Deploy Directory: $DEPLOY_DIR
echo ""
#cd ../jenkins_deploy && docker-compose up -d
#cd ~/jenkins/jenkins_deploy && docker-compose up -d
#cd ~/jenkins_deploy && docker-compose up -d
cd $DEPLOY_DIR && docker-compose -f docker-compose-deploy.yml -p $PROJECT_NAME up -d
#cd /home/admin1/jenkins/jenkins_deploy && docker-compose up -d
