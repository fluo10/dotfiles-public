#!/bin/bash

readonly script_dir=$(cd $(dirname $0); pwd)
readonly script_prefix=`basename $0 $extension`
readonly git_root=`git rev-parse --show-toplevel`

readonly valid_config=("url" "shared_branch")
valid_config_pattern="$(IFS="|"; echo "${valid_config[*]}")"
for i in ${valid_config[@]}; do
  eval "$i=()"
done

config_path="$git_root/dotfiles.conf"

while getopts c:n OPT; do
  case $OPT in
    c)
      config_path=$OPTARG
      ;;
    n)
      dryrun_echo="echo "
      ;;
  esac
done

# Update remote

function apply_config() {
  echo "section = $section "
  echo "url = ${url[@]}"
  echo "sb = ${shared_branch[@]}"
  return 0
}
section=""
while read line; do
  echo "line=$line"
  if echo "$line" | grep -q "\[*\]" ; then
    if [ "$section" != "" ]; then
      apply_config
    fi
    section="`echo "$line" | sed -E "s/^\[(.*)\]/\1/"`"
  else
    eval "`echo "$line" | sed -n -E "s/^\s*($valid_config_pattern)\s*=\s*(.+)$/\1+=\2/p"`"
  fi
done <  $config_path  
# if [ "$section" != "" ]; then
  apply_config
# fi

