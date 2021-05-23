#!/bin/bash

readonly script_dir=$(cd $(dirname $0); pwd)
readonly script_prefix=`basename $0 $extension`
readonly git_root=`git rev-parse --show-toplevel`

# readonly valid_config=("url" "shared_branch")
# valid_config_pattern="$(IFS="|"; echo "${valid_config[*]}")"

for i in ${valid_config[@]}; do
  eval "$i=()"
done
function show_list() {
  section=""
  while read line; do
    if echo "$line" | grep -q "\[*\]" ; then
      section="`echo "$line" | sed -E "s/^\[(.*)\]/\1/"`"
    else
      echo "$line" | sed -n -E "s/^\s*(\S+)\s*=\s*(.+)$/$section.\1=\2/p"
    fi
  done <  $config_path  
}
config_path="$git_root/dotfiles.conf"

list_flag=0
while getopts c:ln OPT; do
  case $OPT in
    c)
      config_path=$OPTARG
      ;;
    l)
      list_flag=1
      ;;
    n)
      dryrun_echo="echo "
      ;;
  esac
done

if [ $list_flag = 1 ]; then
  show_list
fi
