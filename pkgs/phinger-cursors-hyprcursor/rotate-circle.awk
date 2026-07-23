BEGIN {
  angleDeg = angleDeg
  angleRad = angleDeg % 360 * (3.141592 / 180)
  centerx = centerx
  centery = centery
  FS = "[C]"
  OFS = "C"
}

/<path id="(Vector|Vector_[0-9])" d=/ {
  v = 1
}

! v {
  print
}

v {
  mcommand = substr($1, match($1, /M/))
  split(mcommand, mvals, " |M")
  mnewvals = ""
  mnewvals = mnewvals " " (mvals[2] - centerx) * cos(angleRad) - (mvals[3] - centery) * sin(angleRad) + centerx
  mnewvals = mnewvals " " (mvals[3] - centery) * cos(angleRad) + (mvals[2] - centerx) * sin(angleRad) + centery
  sub(/([0-9]+(\.[0-9]+)? )+([0-9]+(\.[0-9]+)?)/, mnewvals, $1)
  for (i = 2; i <= NF; i++) {
    if (i > 9) {
      break
    }
    split($i, cvals, " |Z")
    newvals = ""
    newvals = newvals " " (cvals[1] - centerx) * cos(angleRad) - (cvals[2] - centery) * sin(angleRad) + centerx
    newvals = newvals " " (cvals[2] - centery) * cos(angleRad) + (cvals[1] - centerx) * sin(angleRad) + centery
    newvals = newvals " " (cvals[3] - centerx) * cos(angleRad) - (cvals[4] - centery) * sin(angleRad) + centerx
    newvals = newvals " " (cvals[4] - centery) * cos(angleRad) + (cvals[3] - centerx) * sin(angleRad) + centery
    newvals = newvals " " (cvals[5] - centerx) * cos(angleRad) - (cvals[6] - centery) * sin(angleRad) + centerx
    newvals = newvals " " (cvals[6] - centery) * cos(angleRad) + (cvals[5] - centerx) * sin(angleRad) + centery
    sub(/([0-9]+(\.[0-9]+)? )+([0-9]+(\.[0-9]+)?)/, newvals, $i)
  }
  print $0
  v = 0
}
