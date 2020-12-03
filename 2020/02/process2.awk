{ counts = $1
  letter = gensub(/^(.):/, "\\1", "g", $2)
  password = $3
  
  minimum = gensub(/^([0-9]+)-([0-9]+)/, "\\1", "g", counts) + 0
  maximum = gensub(/^([0-9]+)-([0-9]+)/, "\\2", "g", counts) + 0

  split(password, splitpass, "")

  if (((splitpass[minimum] == letter) || (splitpass[maximum] == letter)) && (splitpass[minimum] != splitpass[maximum]))
    result = "success"
  else
    result = "failure"

  print $0 " : " minimum " : " testcount " : " maximum " : " splitpass[minimum] " : " splitpass[maximum] " : " result
}
