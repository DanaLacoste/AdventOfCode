function check_passport(passport, valid) {
  if ( match(passport["byr"], /^[[:digit:]]{4}$/) != 1) {
    passport["byr"] = ""
  } else {
    value = passport["byr"] + 0
    if (( value < 1920 ) || ( value > 2002 ))
      passport["byr"] = ""
  }
  if ( match(passport["iyr"], /^[[:digit:]]{4}$/) != 1) {
    passport["iyr"] = ""
  } else {
    value = passport["iyr"] + 0
    if (( value < 2010 ) || ( value > 2020 ))
      passport["iyr"] = ""
  }
  if ( match(passport["eyr"], /^[[:digit:]]{4}$/) != 1) {
    passport["eyr"] = ""
  } else {
    value = passport["eyr"] + 0
    if (( value < 2020 ) || ( value > 2030 ))
      passport["eyr"] = ""
  }
  if ( match(passport["hgt"], /^[[:digit:]]+(cm|in)$/) != 1) {
    passport["hgt"] = ""
  } else {
    value = passport["hgt"]
    if ( match(value, /^.*cm$/) == 1) {
      if (( (value + 0) < 150 ) || ( (value + 0) > 193 ))
        passport["hgt"] = ""
    } else {
      if (( (value + 0) < 59 ) || ( (value + 0) > 76 ))
        passport["hgt"] = ""
    }
  }
  if ( match(passport["hcl"], /^#[0-9a-f]{6}$/) != 1) {
    passport["hcl"] = ""
  }
  if ( match(passport["ecl"], /^(amb|blu|brn|gry|grn|hzl|oth)$/) != 1) {
    passport["ecl"] = ""
  }
  if ( match(passport["pid"], /^[0-9]{9}$/) != 1) {
    passport["pid"] = ""
  }
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
