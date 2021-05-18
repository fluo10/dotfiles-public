#!/bin/bash

PATTERN="$1"
REPLACEMENT="$2"

BRANCHES=`git branch | sed -E "s|$.*[[:space:]]([-0-9a-z/_]+$)|\1|g" | sed -E "|$PATTERN|p"`

for b in ${BRANCHES[@]} ; do
  echo git branch -m ${b} `echo ${b} | sed -E "s|$PATTERN|$REPLACEMENT|g"`
done
