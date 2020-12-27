#!/bin/bash
# Supporting installation of dotfiles
# When this script called by source command from other install.sh, it only define shared functions and variables.  
# When this script executed by shell like bash, it call whole children's install.sh. 

# Shared variant
DRY_RUN_FLAG=
BACKUP_FLAG=
VERBOSE_FLAG=

#SCRIPT_DIR=$(cd $(dirname $0); pwd)
#echo $(cd $(dirname $0); pwd)
#CALLER_PATH=${CALLER[1]}
#CALLER_FILE=${CALLER[1]}
#CALLER_DIR=$(cd $(dirname ${CALLER[1]}) && pwd)
function func_l(){
	echo "func_l@$SCRIPT_DIR"
}



while getopts bcdhlruvV: OPT
do
    case $OPT in
        # Back up
        b) 
            ;;
        d)  # Dry run
            IS_DRY_RUN=1
            ;;
        h) # help
            ;;
        o) # Owner
        u) # Update only 
        h)  usage_exit
            ;;
        v) # verbose
        V) echo $VERSION
        \?) usage_exit
            ;;
    esac
done





## Exit if this called by source command
if [[ "$0" != "${BASH_SOURCE:-$0}" ]]; then
	echo "Called by source"
	return 
fi 

## Process for dotfiles root
echo "Executed by shell"

