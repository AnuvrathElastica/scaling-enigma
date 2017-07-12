#!/bin/bash


if [ $BRANCH='master' ]; then
    version='latest'
else
    version=$MGW_MONITOR_DOCKER_IMAGE_VERSION
fi

if [ -z $version ]; then
    echo "Bailing out VERSION $MGW_MONITOR_DOCKER_IMAGE_VERSION is null"
    exit 1
else
    echo "Building with version = $version : $MGW_MONITOR_DOCKER_IMAGE_VERSION"
fi
if [ -z $MGW_MONITOR_DOCKER_IMAGE_TAG ]; then
    echo "Bailing out TAG $MGW_MONITOR_DOCKER_IMAGE_TAG is null"
    exit 1
else
    echo "If build successful will tag it with $MGW_MONITOR_DOCKER_IMAGE_TAG"
fi

docker_image_tag="$MGW_MONITOR_DOCKER_IMAGE_TAG/mgw-docker"

dirs="monitor websvr"
for dir in $dirs; do
    pushd $dir
    echo "$PWD building on branch $BRANCH_NAME"
    ./build_docker_image.sh $version || exit 1
    echo "sudo docker tag $dir:$version $docker_image_tag-$dir:$version"
    sudo docker tag $dir:$version "$docker_image_tag-$dir:$version" || exit 1
    echo "sudo docker push $docker_image_tag-$dir:$version"
    sudo docker push "$docker_image_tag/mgw-docker-$dir:$version" || exit 1
    popd
done
