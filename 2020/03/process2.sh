#!/usr/local/bin/bash

slope1=$(awk -v over=1 -v down=1 -f process1.awk input.txt)
slope2=$(awk -v over=3 -v down=1 -f process1.awk input.txt)
slope3=$(awk -v over=5 -v down=1 -f process1.awk input.txt)
slope4=$(awk -v over=7 -v down=1 -f process1.awk input.txt)
slope5=$(awk -v over=1 -v down=2 -f process1.awk input.txt)

echo Ran into ${slope1}, ${slope2}, ${slope3}, ${slope4}, and ${slope5} trees for a multiplicative total of $((${slope1} * ${slope2} * ${slope3} * ${slope4} * ${slope5}))
