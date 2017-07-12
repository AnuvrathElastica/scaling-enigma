#!/bin/bash

tag=${MGW_MONITOR_DOCKER_IMAGE_TAG}

if [ ${BRANCH_NAME} == 'master' ]; then
    ver = 'latest'
else
    ver=${MGW_MONITOR_DOCKER_IMAGE_VERSION}
fi

dirs="monitor websvr"
for dir in $dirs; do
    pushd $dir
    echo "$PWD building..."
    ./build_docker_image.sh
    echo "sudo docker tag $dir:$ver $tag/mgw-docker-$dir:$ver"
    sudo docker tag $dir:$ver "$tag/mgw-docker-$dir:$ver"
    echo "sudo docker push $tag/mgw-docker-$dir:$ver"
    sudo docker push "$tag/mgw-docker-$dir:$ver"
    popd
done
