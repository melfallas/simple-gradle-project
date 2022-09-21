#!/bin/bash

# Validación de parámetros
mvnComand1=$1
mvnComand2=$2
appDir=$3

# if [ -d appDir ]
# then
   # echo "El directorio ${appDir} existe"
# else
   # echo "El directorio ${appDir} no es válido"
# fi
if [ -z ${appDir} ]; then 
	echo ""
	echo Debe especificar el directorio java
	echo ""
else
	echo ""
	echo "################"
	echo "*** Testing  ***"
	echo "################"
	echo ""
	docker run --rm -v /root/.m2:/root/.m2 -v $appDir:/app -w /app maven:3-alpine "$mvnComand1" "$mvnComand2"
fi
