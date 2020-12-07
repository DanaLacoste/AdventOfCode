BEGIN {
  groupnumber = 0
  sumtotal = 0
}
{
  line = $0
  #print line
  if ( length(line) > 0 ) {
    questioncount = split(line, questions, "")
    for (questionindex = 1; questionindex <= questioncount; questionindex++) {
      answered[questions[questionindex]] = 1
    }
  } else {
    groupnumber++
    print "Group " groupnumber " answered yes " length(answered) " times"
    sumtotal += length(answered)
    delete questions
    delete answered
  }
}
END {
  if (length(answered) > 0) {
    groupnumber++
    print "Group " groupnumber " answered yes " length(answered) " times"
    sumtotal += length(answered)
  }
  print "For a total of " sumtotal " yes answers in all groups"
}
