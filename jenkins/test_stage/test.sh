#!/bin/bash

# Parameter Validation
APP_DIR=$1

echo ""
echo "-------------------------------------------------------------------------------------------------------------------"
echo "                                              Procesing Testing Stage ...                                          "
echo "-------------------------------------------------------------------------------------------------------------------"


if [ -z ${APP_DIR} ]; then 
	echo ""
	echo Application directory no specified
	echo ""
else
	echo ""
	echo "#######################"
	echo "***  Testing Phase  ***"
	echo "#######################"
	echo ""
	docker run --rm -u gradle -v $APP_DIR:/app -w /app gradle:6.9-jdk8 /usr/bin/gradle wrapper test
fi
