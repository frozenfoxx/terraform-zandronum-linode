#!/usr/bin/env bash

# Variables
CONFIG=${CONFIG:-''}
DATA_DIR=${DATA_DIR:-'/data'}
IMAGE=${IMAGE:-'frozenfoxx/zandronum-server:latest'}
OPTIONS=${OPTIONS:-''}
RESTART=${RESTART:-'always'}

# Functions

## Install the container
install_container()
{
  echo "Setting up container..."
  docker pull ${IMAGE}
}

## Run the container
run_container()
{
  echo "Running the container..."
  docker run -it \
    -d \
    --restart=${RESTART} \
    -p 10666:10666 \
    -v ${DATA_DIR}/wads/:/wads
    -e CONFIG=${CONFIG} \
    --name='zandronum-server' \
    ${IMAGE} \
    ${OPTIONS}
}

## Display usage information
usage()
{
  echo "Usage: [Environment Variables] install_zandronum_server.sh [arguments]"
  echo "  Arguments:"
  echo "    -h                     display usage information"
  echo "  Environment Variables:"
  echo "    CONFIG                 contents of a Zandronum configuration file, base64 encoded (default: '')"
  echo "    IMAGE                  the image to pull (default: 'frozenfoxx/zandronum-server:latest')"
  echo "    OPTIONS                string of options to pass to the container (default: '')"
  echo "    RESTART                the restart policy for the container (default: 'always')"
}

# Logic

## Argument parsing
while [[ "$1" != "" ]]; do
  case $1 in
    -h | --help ) usage
                  exit 0
                  ;;
    * )           usage
                  exit 1
  esac
  shift
done

install_container
run_container
