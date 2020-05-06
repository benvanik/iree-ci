#!/bin/bash
set -e o pipefail

docker build \
    -t iree-ci/build-host-linux \
    build-host/linux/
docker build \
    -t iree-ci/build-host-linux-clang-10 \
    build-host/linux/clang-10/

docker build \
    -t iree-ci/distcc-host-linux-clang-10 \
    distcc-host/linux/clang-10/
