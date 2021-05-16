#!/bin/bash
# Template of installer for dotfiles
CWD=$(cd $(dirname $0); pwd)

if [[ $(id -u) -eq 0 ]] ; then
    echo "Please run as a non-root user" ; exit 1 ; 
    :
else
    #echo "Please run as the root user" ; exit 1 ; 
    :
fi

## Main
DEIN_DIR="$HOME/.cache/dein"
if [ ! -e $DEIN_DIR ]; then
	mkdir -p $DEIN_DIR
	curl -L https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | bash -s -- $DEIN_DIR
fi
ln -si $CWD/init.vim $HOME/.config/nvim/
ln -si $CWD/dein.toml $HOME/.config/nvim/
