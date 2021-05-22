#!/bin/bash
#local BUF

if [ -p /dev/stdin ]; then
  code="`cat -`"
else
  code="$1"
fi

function convert_to_unicode(){
  if [ -p /dev/stdin ]; then
    index=`cat -`
  else
    index=$1
  fi
  local PIXEL=()
# PIXEL[0]="\u2007"
# PIXEL[1]="\u2597"
# PIXEL[2]="\u2596"
# PIXEL[3]="\u2584"
# PIXEL[4]="\u259d"
# PIXEL[5]="\u2590"
# PIXEL[6]="\u259e"
# PIXEL[7]="\u259f"
# PIXEL[8]="\u2598"
# PIXEL[9]="\u259a"
# PIXEL[10]="\u258c"
# PIXEL[11]="\u2599"
# PIXEL[12]="\u2580"
# PIXEL[13]="\u259c"
# PIXEL[14]="\u259b"
# PIXEL[15]="\u2588"
  PIXEL[0]="\u2007\u2007"
  PIXEL[1]="\u2007\u2584"
  PIXEL[2]="\u2584\u2007"
  PIXEL[3]="\u2584\u2584"
  PIXEL[4]="\u2007\u2580"
  PIXEL[5]="\u2007\u2588"
  PIXEL[6]="\u2584\u2580"
  PIXEL[7]="\u2584\u2588"
  PIXEL[8]="\u2580\u2007"
  PIXEL[9]="\u2580\u2584"
  PIXEL[10]="\u2588\u2007"
  PIXEL[11]="\u2588\u2584"
  PIXEL[12]="\u2580\u2580"
  PIXEL[13]="\u2580\u2588"
  PIXEL[14]="\u2588\u2580"
  PIXEL[15]="\u2588\u2588"
  echo -ne "${PIXEL[index]}"
}
#for ((i=0; i < 16; i++)); do
#  echo `convert_to_unicode $i`
#done
BUF=""
#  if [ -p /dev/stdin ]; then
#    index=`cat -`
#  else
#    index=$1
#  fi
echo "$code" | while read line; do 
  if [ "$BUF" = "" ]; then
    BUF="$line"
  else
    for ((i=0; i < ${#BUF}; i+=2 )); do
#      echo -n ${BUF:i:2}${line:i:2}
      echo  "obase=10; ibase=2; ${BUF:i:2}${line:i:2}" | bc | convert_to_unicode
    done
    echo
    BUF=""
  fi
done
