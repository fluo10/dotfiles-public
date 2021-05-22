#!/bin/bash
  
PREFIX=0 # Set 0 as null
SUBPREFIX=()
IFS=" "
TARGET_BRANCHES=("main" "feature/*")
while getopts nps: OPT; do
  case $OPT in
    n)
      dryrun_echo="echo "
      ;;  
    p) # Prefix リモートブランチのプレフィクス
      PREFIX="$OPTARG"
      ;;

    s) # Sub or shered branch
      SUBPREFIX=("${SUBPREFIX[@]}" "$OPTARG/")
      ;;
  esac
done

shift `expr $OPTIND - 1`
  

REMOTE_NAME=$1
shift 
REMOTE_URL=$1
shift
REMOTE_PUSHURL=()
while [ "$1" ]; do
  REMOTE_PUSHURL+=( "$1" )
  shift
done
if [ $PREFIX = 0 ]; then
  if [  $REMOTE_NAME = 'origin' ] ; then
      PREFIX=""
  else
      PREFIX="$REMOTE_NAME/"
  fi
fi
if [ "`git remote | grep -x  $REMOTE_NAME`" ]; then
  $dryrun_echo git remote set-url $REMOTE_NAME "$REMOTE_URL"
  $dryrun_echo git config --unset-all remote.$REMOTE_NAME.pushurl
else
  $dryrun_echo git remote add $REMOTE_NAME "$REMOTE_URL"
fi

if [ ${#REMOTE_PUSHURL[@]} -gt 1 ]; then
  $dryrun_echo git remote set-url --push $REMOTE_NAME "$REMOTE_URL"
  for e in ${REMOTE_PUSHURL[@]}; do
    $dryrun_echo git remote set-url --add --push $REMOTE_NAME "${e}"
  done
fi

$dryrun_echo git config --unset-all remote.$REMOTE_NAME.fetch
$dryrun_echo git config --unset-all remote.$REMOTE_NAME.push 

for e in ${TARGET_BRANCHES[@]}; do
  $dryrun_echo git config --add remote.$REMOTE_NAME.fetch "+refs/heads/${e}:refs/remotes/$REMOTE_NAME/$PREFIX${e}"  
  $dryrun_echo git config --add remote.$REMOTE_NAME.push "refs/heads/$PREFIX${e}:refs/heads/${e}"
done

for s in ${SUBPREFIX[@]}; do
  for e in ${TARGET_BRANCHES[@]}; do
    $dryrun_echo git config --add remote.$REMOTE_NAME.fetch  "+refs/heads/${s}${e}:refs/remotes/$REMOTE_NAME/${s}${e}"
    $dryrun_echo git config --add remote.$REMOTE_NAME.push "refs/heads/${s}${e}" 
  done
done
