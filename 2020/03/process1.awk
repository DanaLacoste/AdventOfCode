BEGIN {
  position = 1
  downcount = 0
  trees = 0
}

function join(array, start, end, sep,    result, i)
{
    if (sep == "\\")
       sep = " "
    else if (sep == SUBSEP) # magic value
       sep = ""
    result = array[start]
    for (i = start + 1; i <= end; i++)
        result = result sep array[i]
    return result
}

{ 
  line = $0
  split(line, splitline, "")

  if (downcount == 0) {
    if (splitline[position] == ".") {
      splitline[position] = "O"
      #joinline = join(splitline, 1, length(line), "")
      #print joinline " (" position ": Open)"
    } else {
      trees++
      splitline[position] = "X"
      #joinline = join(splitline, 1, length(line), "")
      #print joinline " (" position ": Tree)"
    }
    position += over
    if (position > length(line))
      position -= length(line)
  } else {
    #print line
  }

  downcount++
  if (downcount == down)
    downcount = 0

}
END {
  #print "Encountered " trees " trees."
  print trees
}
