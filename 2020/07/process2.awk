BEGIN {
  desired_bag = "shiny gold"
}

function how_many_inside(parentbag, children_for, child, bagcount, childsize) {
  for (child in children_for[parentbag]) {
    if ( child in children_for ) {
      childsize = how_many_inside(child, children_for )
      bagcount += ((childsize + 1) * (children_for[parentbag][child] + 0))
    } else {
      bagcount += (children_for[parentbag][child] + 0) 
    }
  }
  return bagcount
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
      children_for[parentbag][childbag] = childbagcount
    }
  } else {
    #print "Skip: " line
  }
}

END {
  baglist[desired_bag] = false
  result = how_many_inside(desired_bag, children_for )
  print desired_bag " bags contain " result " child bags."
}
