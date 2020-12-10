BEGIN {
  previous = 0
  diff_1j_in_a_row = 0
  ways_to_arrange = 1
}
function get_multiplier(in_a_row) {
  switch (in_a_row) {
    case 0: # 7 10 13 16
      return 1
    case 1: # there is exactly one way to do 7 10 11 14
      return 1
    case 2: # two ways: 7 10 11 12 15
            #        or 7 10 12 15
      return 2
    case 3: # four ways: 7 10 11 12 13 16
            #         or 7 10 12 13 16
            #         or 7 10 11 13 16
            #         or 7 10 13 16
      return 4
    case 4: # 7 ways: 7 10 11 12 13 14 17
            #      or 7 10    12 13 14 17
            #      or 7 10 11    13 14 17
            #      or 7 10 11 12    14 17
            #      or 7 10    13    14 17
            #      or 7 10    12    14 17
            #      or 7 10 11       14 17
      return 7
    case 5: # 11 ways: 7 10 11 12 13 14 15 18
            #       or 7 10    12 13 14 15 18
            #       or 7 10 11    13 14 15 18
            #       or 7 10 11 12    14 15 18
            #       or 7 10 11 12 13    15 18
            #       or 7 10       13 14 15 18
            #       or 7 10 11       14 15 18
            #       or 7 10 11 12       15 18
            #       or 7 10 11    13    15 18
            #       or 7 10    12       15 18
            #       or 7 10       13    15 18
      return 11
    case 6: # 25 ways: 7 10 11 12 13 14 15 16 19 - full
            #       or 7 10    12 13 14 15 16 19 - 1 missing
            #       or 7 10 11    13 14 15 16 19
            #       or 7 10 11 12    14 15 16 19
            #       or 7 10 11 12 13    15 16 19
            #       or 7 10 11 12 13 14    16 19
            #       or 7 10       13 14 15 16 19 - 2 missing
            #       or 7 10    12    14 15 16 19
            #       or 7 10    12 13    15 16 19
            #       or 7 10 11 12 13 14    16 19
            #       or 7 10 11       14 15 16 19
            #       or 7 10 11    13    15 16 19
            #       or 7 10 11    13 14    16 19
            #       or 7 10 11 12 13 14 15 16 19
            #       or 7 10 11 12       15 16 19
            #       or 7 10 11 12    14    16 19
            #       or 7 10 11 12 13       16 19
            #       or 7 10       13    15 16 19 - 3 missing
            #       or 7 10       13 14    16 19
            #       or 7 10    12       15 16 19
            #       or 7 10    12    14    16 19
            #       or 7 10    12 13       16 19
            #       or 7 10 11       14    16 19
            #       or 7 10 11    13       16 19
            #       or 7 10       13       16 19 - 4 missing
      return 25
    default:
      print "ERROR: OK, you got me, you had more than 6 1j diffs in a row, you had " in_a_row
      exit
  }
}
{
  jolt = $0 + 0
  difference = jolt - previous
  switch (difference) {
    case 1:
      print "1: Last: " previous ", Current: " jolt ", Diff: " difference
      diff_1j_in_a_row++
      break
    case 3:
      print "3: Last: " previous ", Current: " jolt ", Diff: " difference
      diff_3j++
      print diff_1j_in_a_row " 1j diff(s) before this 3j diff!"
      multiplier = get_multiplier(diff_1j_in_a_row)
      print ways_to_arrange " * " multiplier " = " ways_to_arrange * multiplier
      ways_to_arrange *= multiplier
      diff_1j_in_a_row = 0
      break
    default:
      print "ERROR: Not 1 or 3: Last: " previous ", Current: " jolt ", Diff: " difference
      exit
  }
  previous = jolt
done
}
END {
  # Final: Device charge is 3j jump: let's see if there was a 1j sequence going in:
  print "3: Last: " previous ", Current: " jolt + 3 ", Diff: 3"
  diff_3j++
  multiplier = get_multiplier(diff_1j_in_a_row)
  print ways_to_arrange " * " multiplier " = " ways_to_arrange * multiplier
  ways_to_arrange *= multiplier

  print "Found " ways_to_arrange " different arrangements that will work"
}
