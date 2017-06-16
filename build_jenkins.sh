#!/bin/bash

if [ $1 == "dev" ] ; then
    tag="730926784978.dkr.ecr.us-west-2.amazonaws.com/dev/el-mgw-docker-monitor"
else
    tag="730926784978.dkr.ecr.us-west-2.amazonaws.com/release/el-mgw-docker-monitor"
fi
ver=1.0
dirs="monitor websvr redis syslogdocker"
for dir in $dirs; do 
    pushd $dir
    echo "$PWD building..."
    ./build_docker_image.sh  $ver
    echo "sudo docker tag $dir:latest $tag-$dir:$ver"
    sudo docker tag $dir:latest $tag-$dir:$ver
    echo "sudo docker push $tag-$dir:$ver"
    sudo docker push $tag-$dir:$ver
    popd
done
