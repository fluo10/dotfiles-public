#!/bin/bash
CWD=$(cd $(dirname $0); pwd)
ln -si "$CWD/.gitconfig" "$HOME/"
