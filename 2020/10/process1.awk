BEGIN {
  previous = 0
  diff_1j = 0
  diff_3j = 0
}
{
  jolt = $0 + 0
  difference = jolt - previous
  switch (difference) {
    case 1:
      print "1: Last: " previous ", Current: " jolt ", Diff: " difference
      diff_1j++
      break
    case 3:
      print "3: Last: " previous ", Current: " jolt ", Diff: " difference
      diff_3j++
      break
    default:
      print "Not 1 or 3: Last: " previous ", Current: " jolt ", Diff: " difference
  }
  previous = jolt
done
}
END {
  # Final: Device charge
  print "3: Last: " previous ", Current: " jolt + 3 ", Diff: 3"
  diff_3j++

  print "Found " diff_1j " * 1 jolt differences"
  print "Found " diff_3j " * 3 jolt differences"
  print "Multiplies to " diff_1j * diff_3j
}
