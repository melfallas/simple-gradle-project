#!/bin/bash

# Parameter validation
APP_DIR=$1

echo ""
echo "-------------------------------------------------------------------------------------------------------------------"
echo "                                              Procesing Build Stage ...                                            "
echo "-------------------------------------------------------------------------------------------------------------------"

if [ -z ${APP_DIR} ]; then 
	echo ""
	echo Debe especificar el directorio java
	echo ""
else
	echo ""
	echo "********************************"
	echo "*** Building jar with gradle ***"
	echo "********************************"
	echo ""
	echo "Current Directory: $PWD"
	echo "Docker Volume Directory: $APP_DIR"

	docker run --rm -u gradle -v $APP_DIR:/app -w /app gradle:6.9-jdk8 /usr/bin/gradle wrapper build -x test
fi