#!/usr/bin/env bash

# Variables
CONFIG=${CONFIG:-''}
DATA_DIR=${DATA_DIR:-'/data'}
IMAGE=${IMAGE:-'frozenfoxx/zandronum-server:latest'}
OPTIONS=${OPTIONS:-''}
RESTART=${RESTART:-'always'}

# Functions

## Output the configuration to disk
dump_config()
{
  echo "Saving config to ${DATA_DIR}/zandronum-server-config..."
  echo ${CONFIG} > ${DATA_DIR}/zandronum-server-config
  chmod 640 ${DATA_DIR}/zandronum-server-config
}

## Output the options to disk
dump_options()
{
  echo "Saving options to ${DATA_DIR}/zandronum-server-options..."
  echo ${OPTIONS} > ${DATA_DIR}/zandronum-server-options
  chmod 640 ${DATA_DIR}/zandronum-server-options
}

## Install the container
install_container()
{
  echo "Setting up container..."
  docker pull ${IMAGE}
}

## Load CONFIG from file on disk
load_config()
{
  echo "Loading config from ${DATA_DIR}/zandronum-server-config..."
  CONFIG=$(cat ${DATA_DIR}/zandronum-server-config)
}

## Load OPTIONS from file on disk
load_options()
{
  echo "Loading options from ${DATA_DIR}/zandronum-server-options..."
  OPTIONS=$(cat ${DATA_DIR}/zandronum-server-options)
}

## Run the container
run_container()
{
  echo "Running the container..."
  docker run -it \
    -d \
    --restart=${RESTART} \
    --network host \
    -e CONFIG=${CONFIG} \
    -p 10666:10666 \
    -v ${DATA_DIR}/wads/:/wads:ro \
    --name='zandronum-server' \
    ${IMAGE} \
    ${OPTIONS}
}

## Stop the container
stop_container()
{
  echo "Stopping the container..."
  docker kill zandronum-server
  echo y | docker container prune
}

## Display usage information
usage()
{
  echo "Usage: [Environment Variables] install_zandronum_server.sh [arguments] [command]"
  echo "  Arguments:"
  echo "    -h                     display usage information"
  echo "  Commands:"
  echo "    install                set up and install the server"
  echo "    restart                restart the server"
  echo "    start                  start the server"
  echo "    stop                   stop the server"
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
    install )     install_container
                  dump_config
                  dump_options
                  run_container
                  exit 0
                  ;;
    restart )     stop_container
	          install_container
                  load_options
                  load_config
                  run_container
                  ;;
    start )       install_container
	          load_options
                  load_config
                  run_container
                  ;;
    stop )        stop_container
                  ;;
    -h | --help ) usage
                  exit 0
                  ;;
    * )           usage
                  exit 1
  esac
  shift
done
