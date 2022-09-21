#!/bin/bash

originalImageName=$1
pushedRegistryImageName=$2
registryURL=$3

if [ -z ${originalImageName} ]; then 
	echo ""
	echo Debe especificar el nombre de la imagen a registrar
	echo ""
elif [ -z ${pushedRegistryImageName} ]; then
	echo ""
	echo Debe especificar el nuevo nombre de la imagen
	echo ""
elif [ -z ${registryURL} ]; then
	echo ""
	echo Debe especificar la url del registry
	echo ""
else
	echo ""
	echo "########################"
	echo "*** Preparing to push ***"
	echo "########################"
	echo ""
	echo "*** Tagging image ***"
	docker tag $originalImageName:$BUILD_TAG $registryURL/$pushedRegistryImageName:$BUILD_TAG
	echo "*** Pushing image ***"
	docker push $registryURL/$pushedRegistryImageName:$BUILD_TAG
	echo "*** Setting NEW_IMAGE_NAME ***"
	export NEW_IMAGE_NAME=$pushedRegistryImageName
	echo "NEW_IMAGE_NAME=${NEW_IMAGE_NAME}"
fi
