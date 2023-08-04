#!/usr/bin/env bash

# This script should be only run on a machine with Apple Silicon CPU

set -e

# check if the script is run on a machine with Apple Silicon CPU
if [[ $(uname -m) != "arm64" ]]; then
    echo "This script should be only run on a machine with Apple Silicon CPU"
    exit 1
fi

# user input version
read -p "Enter the version of gt-devcontainer: " version

# check the version meets the semantic versioning
if [[ ! $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "The version should meet the semantic versioning"
    exit 1
fi

# pull the amd64 image
echo "Pulling the amd64 image..."
docker pull ghcr.io/spklai/gt-devcontainer:${version}-amd64

# build the arm64 image
echo "Building the arm64 image..."
devcontainer build --image-name ghcr.io/spklai/gt-devcontainer:${version}-arm64
# tag the image as latest
echo "Tagging the arm64 image as latest..."
docker tag ghcr.io/spklai/gt-devcontainer:${version}-arm64 ghcr.io/spklai/gt-devcontainer:latest-arm64

# push the arm64 images
echo "Pushing the arm64 images..."
docker push ghcr.io/spklai/gt-devcontainer:${version}-arm64
docker push ghcr.io/spklai/gt-devcontainer:latest-arm64

# merge images by creating manifest
echo "Merging the images..."
docker manifest create ghcr.io/spklai/gt-devcontainer:${version} --amend ghcr.io/spklai/gt-devcontainer:${version}-amd64 --amend ghcr.io/spklai/gt-devcontainer:${version}-arm64
# tag the merged image as latest
echo "Tagging the merged image as latest..."
docker manifest create ghcr.io/spklai/gt-devcontainer:latest --amend ghcr.io/spklai/gt-devcontainer:${version}-amd64 --amend ghcr.io/spklai/gt-devcontainer:${version}-arm64

# push the merged images
echo "Pushing the merged images..."
docker manifest push --purge ghcr.io/spklai/gt-devcontainer:${version}
docker manifest push --purge ghcr.io/spklai/gt-devcontainer:latest

# Done
echo "Done."
