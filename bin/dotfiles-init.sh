#!/bin/bash
# セクション一覧の取得
function load_config() {
	while read line; do
		if echo "$line" | grep  remote >/dev/null ; then
			REMOTE=$line
		else
			echo "$REMOTE $line"
		fi 
	done < dotfiles.conf
}
