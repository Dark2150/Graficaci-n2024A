var U: seq[float64] = @[0.0, 0.0, 0.0, 1.0, 1.0, 1.0]
var p: int = 2
var i: int = 1
var u: float64 = 0.5

proc basisFuns(i: int, u: float64, p: int, U: seq[float64]): seq[float64] =
  var N: seq[float64] = newSeq[float64](p + 1)
  var left: seq[float64] = newSeq[float64](p + 1)
  var right: seq[float64] = newSeq[float64](p + 1)
  var temp: float64

  N[0] = 1.0

  for j in 1 .. p:
    left[j] = u - U[i + 1 - j]
    right[j] = U[i + j] - u
    var saved = 0.0

    for r in 0 ..< j:
      let divisor = right[r + 1] + left[j - r]
      if divisor != 0.0:
        temp = N[r] / divisor
        N[r] = saved + right[r + 1] * temp
        saved = left[j - r] * temp
      else:
        temp = 0.0
        N[r] = 0.0
        saved = 0.0
      echo "j=", j, " r=", r, " temp=", temp, " saved=", saved

    N[j] = saved

  result = N

echo basisFuns(i, u, 2, U)


