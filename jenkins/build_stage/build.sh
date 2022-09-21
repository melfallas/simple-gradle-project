#!/bin/bash

# Validación de parámetros
#appDir=$1
appDir=$PWD
#targetDir=/target
targetDir=/build/libs
#appDir=java-app
echo "********************************"
echo "*** Building jar with gradle ***"
echo "********************************"
if [ -z ${appDir} ]; then 
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
	echo "Current directory: ${appDir}"
	echo "|"
	echo "Removing existing *.jar files ..."
	echo "|"
	echo "Dir original permissions ${appDir}:"
	ls -l ${appDir}
	echo "|"
	echo "Getting *.jar files of ${appDir}${targetDir} directory ..."
	ls -l ${appDir}${targetDir}
	#echo "Borrando adicionales de directorio ${appDir}${targetDir}..."
	#rm -f silo-0.0.1-SNAPSHOT.jar.original
	#ls -l ${appDir}${targetDir}
	# Copiar el jar	
	echo "|"
	echo "Copy *.jar files to jenkins/build directory ..."
	#cp -f "$appDir"${targetDir}/silo-0.0.1-SNAPSHOT.jar jenkins/build/
	cp -f "$appDir"${targetDir}/*.jar jenkins/build/
	echo ""
	echo "######################"
	echo "*** Building image ***"
	echo "######################"
	echo ""
	cd jenkins/build/ && docker-compose -f docker-compose-build.yml build --no-cache
	echo "|"
	echo "Removing pending images ..."
	echo "docker rmi $(docker images -f "dangling=true" -q --no-trunc)"
fi

