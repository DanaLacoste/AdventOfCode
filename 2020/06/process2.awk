BEGIN {
  groupnumber = 0
  sumtotal = 0
  groupmember = 0
}
{
  line = $0
  #print line
  if ( length(line) > 0 ) {
    groupmember++
    questioncount = split(line, questions, "")
    for (questionindex = 1; questionindex <= questioncount; questionindex++) {
      answered[questions[questionindex]] += 1
    }
  } else {
    groupnumber++
    for ( answer in answered ) {
      if ( answered[answer] == groupmember )
        allyes[answer] = groupmember
    }
    print "Group " groupnumber " had " groupmember " members and all answered yes to " length(allyes) " times"
    sumtotal += length(allyes)
    groupmember = 0
    delete questions
    delete answered
    delete allyes
  }
}
END {
  if (length(answered) > 0) {
    groupnumber++
    allyes = 0
    for ( answer in answered ) {
      if ( answered[answer] == groupmember )
        allyes[answer] = groupmember
    }
    print "Group " groupnumber " had " groupmember " members and all answered yes to " length(allyes) " times"
    sumtotal += length(allyes)
  }
  print "For a total of " sumtotal " yes answers in all groups"
}
