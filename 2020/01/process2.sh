#!/usr/local/bin/bash

INPUT=input.txt

for first_value in $(cat input.txt) ; do
  for second_value in $(cat input.txt) ; do
    if [[ $((${first_value} + ${second_value})) -lt 2021 ]] ; then
      for third_value in $(cat input.txt) ; do
        sum=$((${first_value} + ${second_value} + ${third_value}))
        if [[ ${sum} -eq 2020 ]] ; then
          total=$((${first_value} * ${second_value} * ${third_value}))
          echo ${first_value} * ${second_value} * ${third_value} = ${total}
        fi
      done
    fi
  done
done
