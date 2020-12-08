BEGIN {
  accumulator = 0
  instructioncounter = 1
}
{
  line = $0
  linecount=split(line, splitline, " ")

  instruction = splitline[1]
  argument    = splitline[2] + 0

  program[instructioncounter]["instruction"] = instruction
  program[instructioncounter]["argument"]    = argument
  program[instructioncounter]["has_run"]     = "false"

  instructioncounter++
}
END {
  modified = "false"
  counter = 1
  for ( runcounter = 1; runcounter <= instructioncounter; runcounter++ ) {
    runstack[counter] = runcounter
    print counter ":" runcounter ":" program[runcounter]["instruction"] " " program[runcounter]["argument"] ":" program[runcounter]["has_run"]
    if ( program[runcounter]["has_run"] == "true" ) {
      print "ERROR: infinite loop again :("
      exit
    }
    lastrun = runcounter
    program[runcounter]["has_run"] = "true"
    switch ( program[runcounter]["instruction"] ) {
      case "acc":
        destination = runcounter + 1
        if ((modified == "false") && (program[destination]["has_run"] == "true")) {
          print "Rolling back to previous jmp or nop to avoid infinite loop!"
          found_previous_jmp_or_nop = "false"
          while ( found_previous_jmp_or_nop == "false") {
            counter--
            runcounter = runstack[counter]
            switch ( program[runcounter]["instruction"] ) {
              case "acc":
                print "Undoing " runcounter ":" program[runcounter]["instruction"] " " program[runcounter]["argument"]
                accumulator -= program[runcounter]["argument"]
                break
              case "nop":
                print "Changing " runcounter ":" program[runcounter]["instruction"] " " program[runcounter]["argument"] " to jmp"
                program[runcounter]["instruction"] = "jmp"
                runcounter--
                found_previous_jmp_or_nop = "true"
                break
              case "jmp":
                print "Changing " runcounter ":" program[runcounter]["instruction"] " " program[runcounter]["argument"] " to nop"
                program[runcounter]["instruction"] = "nop"
                runcounter--
                found_previous_jmp_or_nop = "true"
                break
              default:
                break
            }
          }
          modified = "true"
        } else {
          print modified " " runcounter ":Adding " program[runcounter]["argument"] " to accumulator!"
          accumulator += (program[runcounter]["argument"] + 0)
        }
        break
      case "jmp":
        destination = runcounter + program[runcounter]["argument"]
        if ( (modified == "false") && (program[destination]["has_run"] == "true" )) {
          print "Rolling back to previous jmp or nop to avoid infinite loop!"
          found_previous_jmp_or_nop = "false"
          while ( found_previous_jmp_or_nop == "false") {
            counter--
            runcounter = runstack[counter]
            switch ( program[runcounter]["instruction"] ) {
              case "acc":
                print "Undoing " runcounter ":" program[runcounter]["instruction"] " " program[runcounter]["argument"]
                accumulator -= program[runcounter]["argument"]
                program[runcounter]["has_run"] = "false"
                break
              case "nop":
                print "Changing " runcounter ":" program[runcounter]["instruction"] " " program[runcounter]["argument"] " to jmp"
                program[runcounter]["instruction"] = "jmp"
                program[runcounter]["has_run"] = "false"
                runcounter--
                found_previous_jmp_or_nop = "true"
                break
              case "jmp":
                print "Changing " runcounter ":" program[runcounter]["instruction"] " " program[runcounter]["argument"] " to nop"
                program[runcounter]["instruction"] = "nop"
                program[runcounter]["has_run"] = "false"
                runcounter--
                found_previous_jmp_or_nop = "true"
                break
              default:
                break
            }
          }
          modified = "true"
        } else {
          print modified " " runcounter ":Jumping " program[runcounter]["argument"] " instructions!"
          # "- 1" because for loop will add one
          runcounter = destination - 1
        }
        break
      case "nop":
        destination = runcounter + 1
        if ((modified == "false") && ( program[destination]["has_run"] == "true" )) {
          print "Rolling back to previous jmp or nop to avoid infinite loop!"
          found_previous_jmp_or_nop = "false"
          while ( found_previous_jmp_or_nop == "false") {
            counter--
            runcounter = runstack[counter]
            switch ( program[runcounter]["instruction"] ) {
              case "acc":
                print "Undoing " runcounter ":" program[runcounter]["instruction"] " " program[runcounter]["argument"]
                accumulator -= program[runcounter]["argument"]
                program[runcounter]["has_run"] = "false"
                break
              case "nop":
                print "Changing " runcounter ":" program[runcounter]["instruction"] " " program[runcounter]["argument"] " to jmp"
                program[runcounter]["instruction"] = "jmp"
                program[runcounter]["has_run"] = "false"
                runcounter--
                found_previous_jmp_or_nop = "true"
                break
              case "jmp":
                print "Changing " runcounter ":" program[runcounter]["instruction"] " " program[runcounter]["argument"] " to nop"
                program[runcounter]["instruction"] = "nop"
                program[runcounter]["has_run"] = "false"
                runcounter--
                found_previous_jmp_or_nop = "true"
                break
              default:
                break
            }
          }
          modified = "true"
        } else {
          print modified " " runcounter ":Doing nothing cuz I am lazy"
        }
        break
      default:
        break
    }
    counter++
  }
  print "Normal exit!  Accumulator is " accumulator
}
