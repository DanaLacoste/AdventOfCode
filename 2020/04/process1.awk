function check_passport(passport, valid) {
  if ( ( length(passport["byr"]) == 0 ) ||
       ( length(passport["iyr"]) == 0 ) ||
       ( length(passport["eyr"]) == 0 ) ||
       ( length(passport["hgt"]) == 0 ) ||
       ( length(passport["hcl"]) == 0 ) ||
       ( length(passport["ecl"]) == 0 ) ||
       ( length(passport["pid"]) == 0 ) ) {
    valid = "invalid"
  } else {
    valid = "valid"
  }

  return valid
}
{
  line = $0
  if ( length(line) > 1 ) {
    attributecount = split(line, attributes, " ")
    #print line " = " attributecount
    for (attributeindex = 1; attributeindex <= attributecount; attributeindex++) {
      attributename  = gensub(/([^:]*):.*/, "\\1", "g", attributes[attributeindex])
      attributevalue = gensub(/[^:]*:(.*)/, "\\1", "g", attributes[attributeindex])
      passport[attributename] = attributevalue
      #print "  " attributename ":" passport[attributename]
    }
  } else {
    if (length(passport) > 0) {
      passport["valid"] = check_passport(passport)
      print "Passport ID '" passport["pid"] "' is " passport["valid"]
    }
    delete passport
    delete attributes
  }
}
END {
  if (length(passport) > 0) {
    passport["valid"] = check_passport(passport)
    print "Passport ID '" passport["pid"] "' is " passport["valid"]
  }
}
