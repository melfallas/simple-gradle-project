#!/bin/bash

# Parameter Validation
APP_DIR=$PWD
SOURCE_DIR=/build/libs
TARGET_DIR=jenkins/build_stage/
export IMAGE_NAME=$1

echo "********************************"
echo "*** Building jar with gradle ***"
echo "********************************"
if [ -z ${APP_DIR} ]; then 
	echo "|"
	echo "Not specified directory"
	echo "|"
else
	echo "|"
	echo "Executing by user: "
	whoami
	/usr/bin/id
	echo "|"
	echo "|"
	echo "Current directory: ${APP_DIR}"
	echo "|"
	echo "Removing existing *.jar files ..."
	echo "|"
	echo "Dir original permissions ${APP_DIR}:"
	ls -l ${APP_DIR}
	echo "|"
	echo "Getting *.jar files of ${APP_DIR}${SOURCE_DIR} directory ..."
	ls -l ${APP_DIR}${SOURCE_DIR}
	#echo "Borrando adicionales de directorio ${APP_DIR}${SOURCE_DIR}..."
	#rm -f silo-0.0.1-SNAPSHOT.jar.original
	#ls -l ${APP_DIR}${SOURCE_DIR}
	# Copiar el jar	
	echo "|"
	rm -f "$APP_DIR"${SOURCE_DIR}/*plain.jar
	echo "Copy *.jar files to jenkins/build_stage/ directory ..."
	#cp -f "$APP_DIR"${SOURCE_DIR}/silo-0.0.1-SNAPSHOT.jar ${TARGET_DIR}
	cp -f "$APP_DIR"${SOURCE_DIR}/*.jar ${TARGET_DIR}
	echo ""
	echo "##############################"
	echo "*** Building docker image ***"
	echo "##############################"
	echo ""
	echo "Image name: $IMAGE_NAME"
	echo ""
	cd ${TARGET_DIR} && docker-compose -f docker-compose-build.yml build --no-cache
	echo "|"
	echo "Removing pending images ..."
	echo "docker rmi $(docker images -f "dangling=true" -q --no-trunc)"
fi

