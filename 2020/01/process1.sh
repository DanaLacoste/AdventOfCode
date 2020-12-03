#!/usr/local/bin/bash

INPUT=input.txt

for first_value in $(cat input.txt) ; do
  for second_value in $(cat input.txt) ; do
    sum=$((${first_value} + ${second_value}))
    if [[ ${sum} -eq 2020 ]] ; then
      total=$((${first_value} * ${second_value}))
      echo ${first_value} * ${second_value} = ${total}
    fi
  done
done
