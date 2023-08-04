#!/bin/bash
set -e
export BASE=focal
export LLVM_VERSION=14
export RUN_TESTS=1
./build-docker-image.sh
./build-debug.sh "$@"
