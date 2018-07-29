#!/bin/bash
workdir=/Users/ertuil/workspace/igem/app-test1
docker_name=igem-dev

function isexist()
{
    source_str=$1
    test_str=$2
    
    strings=$(echo $source_str | sed 's/:/ /g')
    for str in $strings
    do  
        if [ $test_str=$str ]; then
            return 0
        fi  
    done
    return 1
}

PPWD=`pwd` 
if isexist $PATH $PPWD; then 
    echo "no need to set it ..."
else
    echo $PPWD
    #export PATH=$PPWD:$PATH
fi


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
