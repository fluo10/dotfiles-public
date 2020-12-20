#!/bin/bash
CWD=$(cd $(dirname $0); pwd)
git config --global --add include.path "$CWD/.gitconfig.public"
