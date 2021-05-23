#!/bin/bash
  
readonly script_dir=$(cd $(dirname $0); pwd)
readonly script_prefix=`basename $0 $extension`
readonly git_root=`git rev-parse --show-toplevel`
PREFIX=0 # Set 0 as null
SUBPREFIX=()
IFS=" "
pushurl=()
config_path="$git_root/dotfiles.conf"
TARGET_BRANCHES=("main" "feature/*")

function load_config(){
  # readonly valid_config=("valid_branch")
  # IFS="|" 
  # valid_config_pattern="${valid_config[*]}"
  #eval "`cat "$config_path" | sed -e "s/($valid_config_pattern)"`"
  valid_branch=(`$script_dir/git-dot-config.sh "remote.valid_branch"`)
}
function set_url () {
  if [ "`git remote | grep -x  $remote_name`" ]; then
    $dryrun_echo git remote set-url $remote_name "$REMOTE_URL"
    $dryrun_echo git config --unset-all remote.$remote_name.pushurl
  else
    $dryrun_echo git remote add $remote_name "$REMOTE_URL"
  fi
  if [ ${#pushurl[@]} -gt 0 ]; then
    $dryrun_echo git remote set-url --push $remote_name "$REMOTE_URL"
    for e in ${pushurl[@]}; do
      $dryrun_echo git remote set-url --add --push $remote_name "${e}"
    done
  fi
}
function get_valid_branch_prefix(){
  # echo "valid_branch=$valid_branch"
  local valid_branch_pattern="`IFS="|"; echo "${valid_branch[*]}" | sed -E "s/\*/.*/g"`"
  local branch_prefix=`git branch | sed -E "s|^.*[[:space:]]([-0-9a-z_]+)/($valid_branch_pattern)$|\1|g" | uniq`
  # branch_prefix=()
  echo "prefix= $branch_prefix"
}
function refresh_branches() {
  
  $dryrun_echo git config --unset-all remote.$remote_name.fetch
  $dryrun_echo git config --unset-all remote.$remote_name.push 
  
  for e in ${TARGET_BRANCHES[@]}; do
    $dryrun_echo git config --add remote.$remote_name.fetch "+refs/heads/${e}:refs/remotes/$remote_name/$PREFIX${e}"  
    $dryrun_echo git config --add remote.$remote_name.push "refs/heads/$PREFIX${e}:refs/heads/${e}"
  done
  
  for s in ${SUBPREFIX[@]}; do
    for e in ${TARGET_BRANCHES[@]}; do
      $dryrun_echo git config --add remote.$remote_name.fetch  "+refs/heads/${s}${e}:refs/remotes/$remote_name/${s}${e}"
      $dryrun_echo git config --add remote.$remote_name.push "refs/heads/${s}${e}" 
    done
  done
}

branch_flag=0
url=""
refresh_flag=0
while getopts nrs:u OPT; do
  case $OPT in
    n)
      dryrun_echo="echo "
      ;;  
    r)
      refresh_flag=1
      ;;
    s) # Sub or shered branch
      SUBPREFIX=("${SUBPREFIX[@]}" "$OPTARG/")
      ;;
    u)
      if [ "$url" = "" ]; then
        url="$OPTARG"
      else
        pushurl+="$OPTARG"
      fi
      ;;
  esac
done
load_config
shift `expr $OPTIND - 1`

remote_name=$1
shift 

if [ "$url" != "" ]; then
  set_url
fi
if [ $refresh_flag = 1 ]; then
  refresh_branch
fi
get_valid_branch_prefix
