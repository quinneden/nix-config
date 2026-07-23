BEGIN {
  sum = 0
  count = 0
}

match($0, /id="Vector(_[0-9]*)?" d="M[0-9.]*/) {
  match($0, /M[0-9\.]+/)
  count += 1
  sum += substr($0, RSTART + 1, RLENGTH)
}

END {
  print sum / count
}
