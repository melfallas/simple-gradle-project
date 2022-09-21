#!/bin/bash

# Validación de parámetros
mvnComand1=$1
mvnComand2=$2
mvnComand3=$3
mvnComand4=$4
mvnComand5=$5
appDir=$6

echo "-----------------------------------------------------------------------------------------------------------------"
echo "                                            Procesing Build Stage ...                                            "
echo "-----------------------------------------------------------------------------------------------------------------"

if [ -z ${appDir} ]; then 
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
	echo "|"
	echo "Docker Volume Directory: $appDir"
	echo ""
	docker run --rm -u gradle -v $appDir:/app -w /app gradle:6.9-jdk8 /usr/bin/gradle wrapper build -x test
fi