BEGIN {
  counter = 0
  preamble = "unfinished"
}
function test25(target, last25)
{
  for ( firstnumberindex = 1; firstnumberindex <= 25; firstnumberindex++ ) {
    for ( secondnumberindex = 1; secondnumberindex <= 25; secondnumberindex++ ) {
      if ( firstnumberindex != secondnumberindex ) {
        if (last25[firstnumberindex] + last25[secondnumberindex] == target ) {
          return "true"
        }
      }
    }
  }
  return "false"
}
{ counter++
  if (counter == 26) {
    preamble = "finished"
    counter = 1
  }
  if ( preamble == "finished" ) {
    if ( test25($0 + 0, last25) == "false" ) {
      print $0 " does not come from a sum of the last 25 numbers"
      exit
    }
  }
  last25[counter] = $0 + 0
}
