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
ln -si "$CWD/.zshrc" "$HOME/"

mkdir -p ~/.zprompts
ln -si "$CWD/mytheme.zsh" "$HOME/.zprompts/prompt_mytheme_setup"
