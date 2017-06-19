#!/bin/bash

##################################################
#### ---- Mandatory: Change those ----
##################################################

PACKAGE=scikit
docker_volume_data1=/notebook
docker_volume_data2=/data
docker_port1=8888
local_docker_port1=18888


version=1.0.0

##################################################
#### ---- Mostly, you don't need change below ----
##################################################

echo "Usage: "
echo "  ${0} [<repo-name/repo-tag>] [<repo-version>]"
echo "e.g."
echo "  ${0} openkbs/${PACKAGE} 1.0.0"

# Reference: https://docs.docker.com/engine/userguide/containers/dockerimages/
imageTag=${1:-openkbs/${PACKAGE}}
version=${2:-${version}}

#instanceName=my-${2:-${imageTag%/*}}_$RANDOM
instanceName=my-${2:-${imageTag##*/}}

#### ---- instance local data on the host ----
local_docker_data1=~/data-docker/${PACKAGE}/notebook
local_docker_data2=~/data-docker/${PACKAGE}/data
mkdir -p ${local_docker_data1}
mkdir -p ${local_docker_data2}

#### ----- RUN -------
echo "To run: for example"
echo "docker run -d --name my-${imageTag##*/} -v ${docker_data}:/${docker_volume_data} ${imageTag}"
echo "---------------------------------------------"
echo "---- Starting a Container for ${imageTag}"
echo "---------------------------------------------"
#docker run --rm -P -d --name $instanceName $imageTag
docker run \
    --detach \
    --name=${instanceName} \
    --publish ${local_docker_port1}:${docker_port1} \
    --volume=${local_docker_data1}:${docker_volume_data1} \
    --volume=${local_docker_data2}:${docker_volume_data2} \
    ${imageTag}:${version} 
    

if [ ! "$version" == "" ]; then
    #docker run --rm -P -d -t --name ${instanceName} -v ${docker_data}:${docker_volume_data} ${imageTag}:${version}
    echo "docker run --rm -P -d --name ${instanceName} -v ${docker_data}:${docker_volume_data} ${imageTag}:${version}"
else
    #docker run --rm -P -d -t --name ${instanceName} -v ${docker_data}:${docker_volume_data} ${imageTag}
    echo "docker run --rm -P -d --name ${instanceName} -v ${docker_data}:${docker_volume_data} ${imageTag}"
fi

echo ">>> Docker Status"
docker ps -a | grep "${instanceName}"
echo "-----------------------------------------------"
echo ">>> Docker Shell into Container `docker ps -lqa`"
#docker exec -it ${instanceName} /bin/bash

