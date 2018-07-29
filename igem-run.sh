#!/bin/bash
workdir=/Users/ertuil/workspace/igem/app-test1

docker_name=igem-dev


if [ $# -ge 1 ]; then
    if [ "$1" == 'init' ]; then
        rm -rf $workdir
        docker stop $docker_name  && docker rm $docker_name 
        docker run --name $docker_name \
            -p 4200:4200 \
            -w /usr/src/app \
            -v $workdir:/usr/src/app/igem \
            -it ertuil/igem:v4 /bin/sh install.sh
    elif [ "$1" == 'login' ]; then
        docker stop $docker_name  && docker rm $docker_name 
        docker run --name $docker_name  \
            -p 4200:4200 \
            -w /usr/src/app/igem \
            -v $workdir:/usr/src/app/igem \
            -it ertuil/igem:v4 /bin/sh
    else
        docker exec -it $docker_name ng $@
    fi
else
    docker stop $docker_name && docker rm $docker_name 
    docker run --name $docker_name \
        -p 4200:4200 \
        -w /usr/src/app/igem \
        -v $workdir:/usr/src/app/igem \
        -it ertuil/igem:v4 
fi
