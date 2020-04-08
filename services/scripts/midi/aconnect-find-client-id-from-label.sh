#! /bin/bash

echo >&2 "Looking for '$1'"

while read -r LINE; do
  # echo >&2 "* $LINE"
  CLIENT="$(echo $LINE | grep 'client' | grep $1 | awk '{print $2}')"
  # echo >&2 "> $CLIENT"
  test -z "${CLIENT}" || break
done < <(/usr/bin/aconnect -l)

CLIENT="${CLIENT::-1}"
test -z "${CLIENT}" && echo >&2 -e "CLIENT is empty (2)" && exit 1
echo "${CLIENT}"
