#!/bin/bash

function replace_link_to_copy(){
    local OPT
    local DRYRUN_OPT
    local PREFIX_OPT
    local PREFIX_ARG
    while getopts np: OPT
    do
        case $OPT in
            n)
                DRYRUN_OPT="-d"
                ;;
            p)
                PREFIX_OPT="-p"
                PREFIX_ARG="$OPTARG"
                echo "$OPTARG"
                ;;
        esac
    done

    shift $(($OPTIND -1))
    local LINK_FILE="$1"

    cd $(dirname "$LINK_FILE")
    local LINK_TARGET=$(readlink $LINK_FILE)
    if [[ "$LINK_TARGET" != "$PREFIX_ARG"* ]]; then
        echo "SKIPPING $LINK_FILE $LINK_TARGET"
        exit 0
    fi
    echo "Replacing $LINK_FILE to $LINK_TARGET"
    if [ -z "$DRYRUN_OPT" ]; then
        unlink $LINK_FILE    
    else
        echo "unlink $LINK_FILE"
    fi
    if [ -z "$DRYRUN_OPT" ]; then
        cp $LINK_TARGET $LINK_FILE
    else
        echo "cp $LINK_TARGET $LINK_FILE"
    fi
}

export -f replace_link_to_copy

USAGE="USAGE: link2copy.sh [-inv] [-p TARGET_PREFIX] PATH"


VERBOSE_OPT=
DRYRUN_OPT=

while getopts hinp: OPT
do
    case $OPT in
        h)
            echo "$USAGE"
            exit 0
            ;;
        n)
            DRYRUN_OPT="-n"
            ;;
        i)
            ;;
        p)
            PREFIX_OPT="-p" 
            PREFIX_ARG="$OPTARG"
            echo "$OPTARG"
            ;;
    esac
done

shift $(($OPTIND -1))
LINK_PATH="$1"

if [ -L "$LINK_PATH" ]; then
    replace_link_to_copy $DRYRUN_OPT $PREFIX_OPT $PREFIX_ARG  "$LINK_PATH"
elif [ -d "$LINK_PATH" ]; then
    find "$LINK_PATH" -type l | xargs -I {} bash -c "replace_link_to_copy $DRYRUN_OPT $PREFIX_OPT $PREFIX_ARG {}"
else
    exit 1
fi

