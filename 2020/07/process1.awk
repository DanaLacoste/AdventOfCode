BEGIN {
  desired_bag = "shiny gold"
}

function what_can_hold(childbag, parents_for, suffix, baglist, parentbag) {
  for (parentbag in parents_for[childbag]) {
    print "Path: " parentbag " => " childbag suffix
    baglist[parentbag] = "true"
    if ( parentbag in parents_for ) {
      what_can_hold(parentbag, parents_for, " => " childbag suffix, baglist  )
    }
  }
}

{
  line = $0
  if (match(line, /^.* bags contain no other bags.$/) == 0) {
    parentbag = gensub(/^(.*) bags contain .*/, "\\1", "g", line)
    childlist = gensub(/^.* bags contain (.*)/, "\\1", "g", line)

    childcount = split(childlist, children, ",")

    for ( childindex in children ) {
      childbag = gensub(/^ *[0-9]+ (.*) bag(s|s\.|\.)?$/, "\\1", "g", children[childindex])
      childbagcount = gensub(/^ *([0-9]+) .* bag(s|s\.|\.)?$/, "\\1", "g", children[childindex])
      parents_for[childbag][parentbag] = childbagcount
    }
  } else {
    print "Skip: " line
  }
}

END {
  baglist[desired_bag] = false
  what_can_hold(desired_bag, parents_for, "", baglist )
  for ( bag in baglist) {
    if (baglist[bag] == "true")
      print "Result: A " desired_bag " can be contained [eventually] in a " bag " bag"
  }
}
