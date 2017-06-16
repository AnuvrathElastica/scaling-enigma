#!/bin/bash

tag="730926784978.dkr.ecr.us-west-2.amazonaws.com/dev/scaling-enigma"
ver=1.0
dirs="monitor websvr redis syslogdocker"
for dir in $dirs; do 
    pushd $dir
    echo "$PWD building..."
    ./build_docker_image.sh 
    echo "sudo docker tag $dir:latest $tag-$dir:$ver"
    sudo docker tag $dir:latest $tag-$dir:$ver
    echo "sudo docker push $tag-$dir:$ver"
    sudo docker push $tag-$dir:$ver
    popd
done
