{ counts = $1
  letter = gensub(/^(.):/, "\\1", "g", $2)
  password = $3
  
  minimum = gensub(/^([0-9]+)-([0-9]+)/, "\\1", "g", counts) + 0
  maximum = gensub(/^([0-9]+)-([0-9]+)/, "\\2", "g", counts) + 0

  passtest = gensub(letter, "", "g", password)
  testcount = length(password) - length(passtest)

  if ((testcount >= minimum) && (testcount <= maximum))
    result = "success"
  else
    result = "failure"

  print $0 " : " minimum " : " testcount " : " maximum " : " result
}
