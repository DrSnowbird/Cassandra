#!/bin/bash

##################################################
#### ---- Mandatory: Change those ----
##################################################

PACKAGE=cassandra
docker_volume_data=/var/lib/cassandra
docker_port1=8888
local_docker_port1=18888


version=latest

##################################################
#### ---- Mostly, you don't need change below ----
##################################################

echo "Usage: "
echo "  ${0} [<repo-name/repo-tag>] [<repo-version>]"
echo "e.g."
echo "  ${0} openkbs/${PACKAGE} 1.0.0"

# Reference: https://docs.docker.com/engine/userguide/containers/dockerimages/
#imageTag=${1:-openkbs/${PACKAGE}}
imageTag=${PACKAGE}
version=${2:-${version}}

#instanceName=my-${2:-${imageTag%/*}}_$RANDOM
instanceName=some-${2:-${imageTag##*/}}

#### ---- instance local data on the host ----
local_docker_data=~/data-docker/${PACKAGE}/data
mkdir -p ${local_docker_data}

#### ----- RUN -------
echo "To run: for example"
echo "docker run -d --name my-${imageTag##*/} -v ${docker_data}:/${docker_volume_data} ${imageTag}"
echo "---------------------------------------------"
echo "---- Starting a Container for ${imageTag}"
echo "---------------------------------------------"
#docker run --rm -P -d --name $instanceName $imageTag
#docker run --name some-cassandra -v /my/own/datadir:/var/lib/cassandra -d cassandra:tag
docker run \
    --detach \
    --name=${instanceName} \
    --volume=${local_docker_data}:${docker_volume_data} \
    ${imageTag}:${version} 
    
#    --publish ${local_docker_port1}:${docker_port1} \

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

