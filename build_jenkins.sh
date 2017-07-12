#!/bin/bash

tag=${MGW_MONITOR_DOCKER_IMAGE_TAG}
if [ ${BRANCH_NAME} == 'master' ]; then
    ver = 'latest'
else
    ver=${MGW_MONITOR_DOCKER_IMAGE_VERSION}
fi
if [ -z $tag ]; then
    echo "Bailing out $MGW_MONITOR_DOCKER_IMAGE_TAG is null"
    exit 1
fi
if [ -z $ver ]; then
    echo "Bailing out $MGW_MONITOR_DOCKER_IMAGE_VERSION is null"
    exit 1
fi

dirs="monitor websvr"
for dir in $dirs; do
    pushd $dir
    echo "$PWD building on branch $BRANCH_NAME"
    ./build_docker_image.sh || exit 1
    echo "sudo docker tag $dir:$ver $tag/mgw-docker-$dir:$ver"
    sudo docker tag $dir:$ver "$tag/mgw-docker-$dir:$ver" || exit 1
    echo "sudo docker push $tag/mgw-docker-$dir:$ver"
    sudo docker push "$tag/mgw-docker-$dir:$ver" || exit 1
    popd
done
