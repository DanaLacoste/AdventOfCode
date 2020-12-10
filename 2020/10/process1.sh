#!/usr/local/bin/bash

previous=0
diff_1j=0
diff_3j=0
distance_since_last_3=0

for jolt in $(sort -n < input.txt) ; do
  difference=$((${jolt} - ${previous}))
  if [[ ${difference} -eq 1 ]] ; then
    echo "1: Last: ${previous}, Current: ${jolt}, Diff: ${difference}"
    ((diff_1j++))
  elif [[ ${difference} -eq 3 ]] ; then
    echo "3: Last: ${previous}, Current: ${jolt}, Diff: ${difference}"
    ((diff_3j++))
  else
    echo "Not 1 or 3: Last: ${previous}, Current: ${jolt}, Diff: ${difference}"
  fi
  previous=${jolt}
done

# Final: Device charge
echo "3: Last: ${previous}, Current: $((${jolt} + 3)), Diff: 3"
((diff_3j++))

echo "Found ${diff_1j} * 1 jolt differences"
echo "Found ${diff_3j} * 3 jolt differences"
echo "Multiplies to $((${diff_1j} * ${diff_3j}))"
