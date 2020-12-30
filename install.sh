#!/bin/bash
# Supporting installation of dotfiles
# When this script called by source command from other install.sh, it only define shared functions and variables.  
# When this script executed by shell like bash, it call whole children's install.sh. 

# Shared variant
OPT_DRY_RUN=
OPT_BACKUP=
OPT_VERBOSE=

#SCRIPT_DIR=$(cd $(dirname $0); pwd)
#echo $(cd $(dirname $0); pwd)
#CALLER_PATH=${CALLER[1]}
#CALLER_FILE=${CALLER[1]}
#CALLER_DIR=$(cd $(dirname ${CALLER[1]}) && pwd)

# Copy as file
function dotfiles_copy(){
    echo "UNIMPLEMENTED!"
	local HELP="push lxd usage"
}

# Link 
function dotfiles_link(){
    echo "UNIMPLEMENTED!"
    local HELP="push lxd usage"
}

function dotfiles_lxd(){
	local HELP="Usage: push_lxd [-b] [-d] [-h] CONTAINER SOURCE_PATH... DESTINATION_PATH"
	
    local OPT
    while getopts bdhv OPT
	do 
		case $OPT in
			b) # BackUp
				local FLAG_BACKUP=1
				;;
			n)
				local FLAG_DRY_RUN=1
                local FRY_RUN_PREFIX=echo
				;;
			h)
				echo $HELP
                return 0
				;;
            v) 
                local vorbose
		esac
	done
	shift $((OPTIND - 1))
	

    if [ $# -lt 3 ]; then
		echo $HELP
		return 1
	fi

	local CONTAINER="$1"
    shift 

    local SRC_PATHS=()
    while [ $# -gt 1]
    do 
        SRC_PATHS+=( "$1" )
        shift
    done
    local DST_PATH="$1"
    
    
    if [ BACKUP_FLAG = 1 ]; then
        echo "UNIMPEMENTED!"
    fi
	
    local SRC_PATH
    for SRC_PATH in "${SRC_PATHS[@]}"
    do
        $DRY_RUN_PREFIX lxc files push $SRC_PATH "$CONTAINER/$DST_PATH"
    done
}

function install_dotfiles(){
	local OPT
	local OPT_DRY_RUN
	local OPT_BACKUP
	local OPT_VERBOSE
	local HELP="invalid argument"
	if [ "$#" = "0" ] ; then
		echo $HELP
		return 1
	fi
	case $1 in
		copy)
			echo cp
			;;
		link)
			echo ln
			;;
		lxd)	
			echo lxd
			;;
		\?)
			echo $HELP
			return 1
	esac
	shift
	while getopts bcdhlruvV: OPT
	do
		case $OPT in
			# Back up
			b) 
			;;
		d)  # Dry run
			OPT_DRY_RUN="-d"
			;;
		h) # help
			;;
		o) # Owner
			;;		
		u) # Update only
			;;	
		h)  usage_exit
			;;
		v) # verbose
			;;
		V)
			echo $VERSION
			;;
		\?) usage_exit
			;;
	esac
done

}


HELP="USAGE: $0 [-b] [-n] [-h] [-v] [-V] "
while getopts rnbvVh: OPT
do
	case $OPT in
	b) 	# Back up
		;;
	n)  # Dry run
		OPT_DRY_RUN="-n"
        set -nx
		;;
	h) # help
		;;
	o) # Owner
		;;
	u) # Update only 
		;;
	h)  usage_exit
		;;
	v) # verbose
       VERBOSE_OPT="-v" 
		;;
    r) #recursive
        ;;
	V) 
        echo $VERSION
		;;
	\?) usage_exit
		;;
esac
done
shift $((OPTIND - 1))




## Exit if this called by source command
if [[ "$0" != "${BASH_SOURCE:-$0}" ]]; then
	echo "Called by source"
	return 
fi 

## Process for dotfiles root
echo "Executed by shell"

