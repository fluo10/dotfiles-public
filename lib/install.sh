#!/bin/bash
CALLER=($(caller))
#CALLER_PATH=${CALLER[1]}
CALLER_FILE=${CALLER[1]}
CALLER_DIR=$(cd $(dirname ${CALLER[1]}) && pwd)
echo $CALLER_DIR

