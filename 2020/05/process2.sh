#!/usr/local/bin/bash

seatlist=$(cat input.txt|tr "F" "0"|tr "B" "1" | tr "L" "0" | tr "R" "1" | sort )
for binary_seat in ${seatlist} ;  do
  seat_id=$((2#$(echo ${binary_seat})))
  if [[ -z ${counter} ]] ; then
    counter=$((${seat_id} - 1))
  fi
  if [[ ${seat_id} -ne $((${counter} + 1)) ]] ; then
    ((counter++))
    echo Skipped: ${counter}
  fi
  ((counter++))
done
