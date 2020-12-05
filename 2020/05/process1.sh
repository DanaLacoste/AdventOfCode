#!/usr/local/bin/bash

echo "$((2#$(cat input.txt|tr "F" "0"|tr "B" "1" | tr "L" "0" | tr "R" "1" | sort | tail -1)))"
