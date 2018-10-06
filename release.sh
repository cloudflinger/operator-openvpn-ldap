#!/bin/bash

set -e

PROJECT=cloudflinger
LOCAL_IMAGE_NAME="openvpn-operator"
REMOTE_IMAGE_NAME="${PROJECT}/${LOCAL_IMAGE_NAME}"

if [ ! -f ./VERSION ]; then
	echo "Please run this from the directory with the Dockerfile."
fi

VERSION=$(cat VERSION)
cp ../infrastructure/chart-releases/openvpn-$VERSION.tgz ./

echo "Building version ${VERSION}."

docker build -t $LOCAL_IMAGE_NAME \
       --build-arg HELM_CHART=openvpn-$VERSION.tgz \
       --build-arg API_VERSION=brain.cloudflinger.com/v1alpha1 \
       --build-arg KIND=Openvpn \
       .

docker tag $LOCAL_IMAGE_NAME $REMOTE_IMAGE_NAME
docker tag $LOCAL_IMAGE_NAME $REMOTE_IMAGE_NAME:latest
docker tag $LOCAL_IMAGE_NAME $REMOTE_IMAGE_NAME:${VERSION}

docker push $REMOTE_IMAGE_NAME
docker push $REMOTE_IMAGE_NAME:latest
docker push $REMOTE_IMAGE_NAME:$VERSION
