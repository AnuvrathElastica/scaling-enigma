#!/bin/bash


if [ $BRANCH='master' ]; then
    VERSION='latest'
else
    VERSION=$MGW_MONITOR_DOCKER_IMAGE_VERSION
fi

if [ -z $MGW_MONITOR_DOCKER_IMAGE_TAG ]; then
    echo "Bailing out TAG $MGW_MONITOR_DOCKER_IMAGE_TAG is null"
    exit 1
fi
if [ -z $VERSION ]; then
    echo "Bailing out VERSION $MGW_MONITOR_DOCKER_IMAGE_VERSION is null"
    exit 1
fi

docker_image_tag="$MGW_MONITOR_DOCKER_IMAGE_TAG/mgw-docker"

dirs="monitor websvr"
for dir in $dirs; do
    pushd $dir
    echo "$PWD building on branch $BRANCH_NAME"
    ./build_docker_image.sh || exit 1
    echo "sudo docker docker_image_tag $dir:$VERSION $docker_image_tag-$dir:$VERSION"
    sudo docker tag $dir:$VERSION "$docker_image_tag-$dir:$VERSION" || exit 1
    echo "sudo docker push $docker_image_tag-$dir:$VERSION"
    sudo docker push "$docker_image_tag/mgw-docker-$dir:$VERSION" || exit 1
    popd
done
