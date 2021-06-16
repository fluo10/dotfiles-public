#!/bin/bash

usage_exit(){
    echo "Usage: $0 [-4|-6] keyword"
}
get_ipv4(){
    # echo "get_ipv4 start $1"
    local IPV4_LENGTH=8
    local KEYWORD=$1
    echo -n $KEYWORD | b2sum -l $IPV4_LENGTH | echo $(read v; v=${v:0:$((IPV4_LENGTH/4))}; echo -n "ibase=16;${v^^}")| bc;
#    return
    # echo "get_ipv4 end $1"
}
split_by_colon(){
    # echo "split_by_colon start $1"
    # echo $*
    local RAW=$1
    local REMAINDER=$((${#RAW}%4))
    if [ $REMAINDER -ne 0 ]; then    
        echo -n ${RAW:0:REMAINDER}
    fi
    for ((i=0; i < $((${#1}/4)); i++)); do
        if [ $REMAINDER -ne 0 -o $i -ne 0 ]; then
            echo -n ":"
        fi
        echo -n  "${RAW:$((i*4+${REMAINDER}%4)):4}"
    done
    # echo "split_by_colon end $1"
    return
}
get_ipv6(){
    # echo "get_ipv6 start $*"
    local IPV6_LENGTH=64
    local OPT 
    local OPTARG
    # while getopts l:c OPT
    # do
    #     echo $OPT $OPTARG
    #     case $OPT in
    #         l)
    #             local LENGTH=$OPTARG
    #             ;;
    #         c)  
    #             local WITH_COLON=true
    #             ;;
    #     esac
    # done
    # shift `expr $OPTIND - 1`
    # local KEYWORD=$*
    local KEYWORD=$1
    if [[ $# -eq 2 ]]; then
        local LENGTH=$2
    else
        local LENGTH=$IPV6_LENGTH
    fi
    echo -n $KEYWORD  | b2sum -l $LENGTH | (read v; v=${v:0:$((LENGTH/4))}; echo $v)
    #    return
     # echo "get_ipv6 end $*"
}

while getopts 46l:n:s:h OPT; do
    case $OPT in
        4)
            IPV4=true
            ;;
        6)
            IPV6=true
            ;;
        l)
            IPV6_LENGTH=$OPTARG
            ;;
        n)
            NET_KEYWORD=$OPTARG
            ;;
        s)
            SUBNET_KEYWORD=$OPTARG
            ;;        
    esac
done
shift `expr $OPTIND - 1`
KEYWORD=$*

if  ! ( [ -n "${IPV4+1}" ] || [ -n "${IPV6+1}" ] ) ; then
    IPV4=true
    IPV6=true
fi
#echo "length=$IPV6_LENGTH IPV4=$IPV4 IPV6=$IPV6 KEYWORD=$KEYWORD NET=$NET_KEYWORD SUB=$SUBNET_KEYWORD"
if [ -n "${NET_KEYWORD+1}" ] && [ -n "${SUBNET_KEYWORD+1}" ] ; then
    if [ -n "${IPV4+1}" ] ; then
        echo "10.$(get_ipv4 $NET_KEYWORD).$(get_ipv4 $SUBNET_KEYWORD).$(get_ipv4 $KEYWORD)"
    fi
    if [ -n "${IPV6+1}" ] ; then
        split_by_colon "fd$(get_ipv6 $NET_KEYWORD 40)$(get_ipv6 $SUBNET_KEYWORD 16)$(get_ipv6 $KEYWORD)"
    fi
elif [ -n "${NET_KEYWORD+1}" ] || [ -n "${SUBNET_KEYWORD+1}" ] ; then
    if ! [ -n "${NET_KEYWORD+1}" ] ; then
        NET_KEYWORD=$SUBNET_KEYWORD
    fi
    if [ -n "${IPV4+1}" ] ; then
        echo "192.168.$(get_ipv4 $NET_KEYWORD).$(get_ipv4 $KEYWORD)"
    fi
    if [ -n "${IPV6+1}" ] ; then
        split_by_colon "fd$(get_ipv6 $NET_KEYWORD 56)$(get_ipv6 $KEYWORD)"
    fi
else
    if [ -n "${IPV4+1}" ] ; then
        get_ipv4 $KEYWORD
    fi
    if [ -n "${IPV6+1}" ] ; then
        split_by_colon "$(get_ipv6 $KEYWORD  $IPV6_LENGTH)" 
   fi
fi
echo 
