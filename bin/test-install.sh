#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)

function test(){
	echo "test function"
}

source $SCRIPT_DIR/../lib/install.sh
