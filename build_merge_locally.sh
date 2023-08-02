#!/bin/bash

# This script should be only run on a machine with Apple Silicon CPU

set -e

docker pull ghcr.io/spklai/gt-devcontainer:latest-amd64

devcontainer build --image-name ghcr.io/spklai/gt-devcontainer:latest-arm64
docker push ghcr.io/spklai/gt-devcontainer:latest-arm64

# Merge images by creating manifest
docker manifest create ghcr.io/spklai/gt-devcontainer:latest --amend ghcr.io/spklai/gt-devcontainer:latest-amd64 --amend ghcr.io/spklai/gt-devcontainer:latest-arm64

docker manifest push --purge ghcr.io/spklai/gt-devcontainer:latest
