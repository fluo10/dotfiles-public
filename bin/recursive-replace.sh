#!/bin/bash
# Replacing word for each child file recursive.


while getopts dv OPT; do
	case $OPT in
		d)
			DRY_RUN=d
			;;
		v)
			VERBOSE=v
			;;
	esac
done

shift `expr $OPTIND - 1`
echo $#
REGEXP=$1
REPLACEMENT=$2
#PATH=$3
echo $REGEXP
echo $REPLACEMENT
#grep -l '置換対象の文字列' ./* | xargs sed -i.bak -e 's/置換対象の文字列/置換後の文字列/g'
grep -lr  $REGEXP --exclude-dir=".git" ./* | xargs
grep -lr  $REGEXP --exclude-dir=".git" ./* | xargs sed -i -e "s/$REGEXP/$REPLACEMENT/g"