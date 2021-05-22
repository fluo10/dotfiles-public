#!/bin/bash
dryrun=""
readonly extension=".sh"
readonly script_dir=$(cd $(dirname $0); pwd)
readonly script_prefix=`basename $0 $extension`
readonly git_root=`git rev-parse --show-toplevel`
while getopts n OPT
do
  case $OPT in
    n)
      dryrun_echo="echo "
      ;;
  esac
done

shift $((OPTIND-1))

sub_command="$1"
shift

args="$*"

sub_command_path="$script_dir/$script_prefix-$sub_command$extension"
$dryrun_echo$sub_command_path "$args"
