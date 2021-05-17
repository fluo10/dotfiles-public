#!/bin/bash
# セクション一覧の取得

function reflesh_remote () {
  
  local OPT
  local OPTARG
  local OPTIND
  local PREFIX=0 # Set 0 as null
  local SUBPREFIX=()
  local IFS=" "
  local TARGET_BRANCHES=("main" "feature/*")
  while getopts ps: OPT; do
      case $OPT in
  
          p) # Prefix リモートブランチのプレフィクス
              PREFIX="$OPTARG"
              ;;
  
          s) # Sub or shered branch
		SUBPREFIX=("${SUBPREFIX[@]}" "$OPTARG/")
              ;;
      esac
  done

  shift `expr $OPTIND - 1`
  local REMOTE_NAME=$1
  
  shift 
  local REMOTE_URL=(${*})
  
  if [ $PREFIX = 0 ]; then
    if [  $REMOTE_NAME = 'origin' ] ; then
        PREFIX=""
    else
        PREFIX="$REMOTE_NAME/"
    fi
  fi
  if [ "`git remote | grep -x  $REMOTE_NAME`" ]; then
    git remote set-url $REMOTE_NAME ${REMOTE_URL[0]}
    git config --unset-all remote.$REMOTE_NAME.pushurl
  else
    git remote add $REMOTE_NAME ${REMOTE_URL[0]}
  fi
  if [ ${#REMOTE_URL[@]} -gt 1 ]; then
    for e in ${REMOTE_URL[@]}; do
      git remote set-url --add --push $REMOTE_NAME ${e}
    done
  fi
    
  
  git config --unset-all remote.$REMOTE_NAME.fetch
  git config --unset-all remote.$REMOTE_NAME.push 
  
  for e in ${TARGET_BRANCHES[@]}; do
   git config --add remote.$REMOTE_NAME.fetch "+refs/heads/${e}:refs/remotes/$REMOTE_NAME/$PREFIX${e}"  
   git config --add remote.$REMOTE_NAME.push "refs/heads/$PREFIX${e}:refs/heads/${e}"
  done

  for s in ${SUBPREFIX[@]}; do
    for e in ${TARGET_BRANCHES[@]}; do
      git config --add remote.$REMOTE_NAME.fetch  "+refs/heads/${s}${e}:refs/remotes/$REMOTE_NAME/${s}${e}"
      git config --add remote.$REMOTE_NAME.push "refs/heads/${s}${e}" 
    done
  done
}

