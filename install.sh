#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)

function mkln() {
    SRC="$SCRIPT_DIR/$1"
    DST="$2"
    DST_DIR="${DST%/*}"
    #echo "$DST_DIR"
    mkdir -p "$DST_DIR"
    ln -si "$SRC" "$DST"
}

mkln ".gitconfig" "$HOME/"
mkln "nvim/init.vim" "$HOME/.config/nvim/"
