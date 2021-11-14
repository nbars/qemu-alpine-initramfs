#!/bin/sh

# Alpine Linux branch to use. Must be one if https://hub.docker.com/_/alpine.
readonly BRANCH=3.14

# The name of the temporary docker image that is build.
readonly IMAGE_NAME=qemu-alpin:$BRANCH