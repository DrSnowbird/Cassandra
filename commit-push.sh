#!/bin/bash 

# Reference: https://docs.docker.com/engine/userguide/containers/dockerimages/

echo "Usage: "
echo "  ${0} <comment> <repo-name/repo-tag>"
echo
echo "-- Make sure you do login first: "
echo "   docker login"
echo

comment=${1:-Update JVM}
imageTag=${2:-openkbs/scikit}
imageVersion=1.0.1

docker ps -a

containerID=`docker ps |grep "${imageTag} "|awk '{print $1}'`
echo "containerID=$containerID"

docker commit -m "$comment" ${containerID} ${imageTag}:latest
docker push ${imageTag}:latest

docker commit -m "$comment" ${containerID} ${imageTag}:${imageVersion}
docker push ${imageTag}:${imageVersion}
