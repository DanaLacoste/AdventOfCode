BEGIN {
  accumulator = 0
  counter = 1
}
{
  line = $0
  linecount=split(line, splitline, " ")

  instruction = splitline[1]
  argument    = splitline[2] + 0

  program[counter]["instruction"] = instruction
  program[counter]["argument"]    = argument
  program[counter]["has_run"]     = "false"

  counter++
}
END {
  for ( runcounter = 1; runcounter <= counter; runcounter++ ) {
    if ( program[runcounter]["has_run"] == "true" ) {
      print "Second run of line " runcounter " and accumulator is " accumulator
      break
    } 
    program[runcounter]["has_run"] = "true"
    switch ( program[runcounter]["instruction"] ) {
      case "acc":
        print "Adding " program[runcounter]["argument"] " to accumulator!"
        accumulator += (program[runcounter]["argument"] + 0)
        break
      case "jmp":
        print "Jumping " program[runcounter]["argument"] " instructions!"
        # "- 1" because for loop will add one
        runcounter += (program[runcounter]["argument"] - 1)
        break
      case "nop":
        print "Doing nothing cuz I am lazy"
      default:
        break
    }
  }
  print
}
