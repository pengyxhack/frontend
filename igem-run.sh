#!/bin/bash
workdir=/Users/ertuil/workspace/igem/app-test1

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
    echo "set PWD to PATH"
    export PATH=$PPWD:$PATH
fi


if [ $# -ge 1 ]; then
    if [ "$1" == 'init' ]; then
        rm -rf $workdir
        docker stop igem-dev && docker rm igem-dev 
        docker run --name igem-dev \
            -p 4200:4200 \
            -w /usr/src/app \
            -v $workdir:/usr/src/app/igem \
            -it ertuil/igem:v4 /bin/sh install.sh
    else
        docker exec -it igem-dev ng $@
    fi
else
    docker stop igem-dev && docker rm igem-dev 
    docker run --name igem-dev \
        -p 4200:4200 \
        -w /usr/src/app/igem \
        -v $workdir:/usr/src/app/igem \
        -it ertuil/igem:v4 
fi
