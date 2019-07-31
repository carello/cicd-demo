#! /bin/bash

# DRONE and DOCKER ENV

BASE_DIR=$(basename "$(PWD)")
#echo ${BASE_DIR}_default

export DRONE_GOGS_SERVER=http://dc-gogs:3000
export DRONE_SERVER_HOST=dc-drone-server
export DRONE_SERVER_PROTO=http
export CI_NET=${BASE_DIR}_default
