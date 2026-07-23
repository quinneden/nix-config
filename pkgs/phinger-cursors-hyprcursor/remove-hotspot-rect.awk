BEGIN {
  state = 0
}

/<g id="hotspot" clip-path="url\(#clip[0-9]+_[0-9]+_[0-9]+\)">/ {
  state = 1
  next
}

/<\/g>/ {
  if (state) {
    state = 0
    next
  }
}

! state {
  print
}
