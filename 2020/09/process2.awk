BEGIN {
  counter = 0
  preamble = "unfinished"
  target = 14144619
  lowestindex = 1
  startnumber = 0
  sumtotal = 0
  lowestnumber = 0
  largestnumber = 0
}
{ counter++
  newnumber = $0 + 0
  numberindex[counter] = newnumber
  #print "DEBUG: " sumtotal " + " newnumber " = " sumtotal + newnumber
  sumtotal += newnumber
  while ( sumtotal > target ) {
    #print "DEBUG: Too big!"
    #print "DEBUG: " sumtotal " - " numberindex[lowestindex] " = " sumtotal - numberindex[lowestindex]
    sumtotal -= numberindex[lowestindex]
    lowestindex++
  }
  if ( sumtotal == target ) {
    print "Found digits that sum to " target ":"
    print "First is #" lowestindex ": " numberindex[lowestindex]
    print "Last is #" counter ": " newnumber
    for ( minmaxsearch = lowestindex; minmaxsearch <= counter; minmaxsearch++) {
      if ((numberindex[minmaxsearch] < lowestnumber) || (lowestnumber == 0))
        lowestnumber = numberindex[minmaxsearch]
      if (numberindex[minmaxsearch] > largestnumber)
        largestnumber = numberindex[minmaxsearch]
    }
    print "Lowest (" lowestnumber ") + Largest (" largestnumber ") = " lowestnumber + largestnumber
    exit
  }
}
