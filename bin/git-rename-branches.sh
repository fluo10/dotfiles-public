#!/bin/bash

PATTERN="$1"
REPLACEMENT="$2"

BRANCHES=`git branch | sed -e "s|^.*[[:space:]]\([-0-9a-z/_]\+\)$|\1|g"`

for b in ${BRANCHES[@]} ; do
  NEW=`echo ${b} | sed -e "s|$PATTERN|$REPLACEMENT|g"`
  if [ ! ${b} = $NEW ]; then
    git branch -m ${b} $NEW
  fi
done
