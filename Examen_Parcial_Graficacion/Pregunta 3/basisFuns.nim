proc basisFuns(i: int, u: float, p: int, U: seq[float], N: var seq[float]) =
  ## Compute the nonvanishing basis functions
  ## Input: i,u,p,U
  ## Output: N

  var left = newSeq[float](p + 1)
  var right = newSeq[float](p + 1)
  var saved: float = 0.0

  N[0] = 1.0
  for j in 1..p:
    left[j] = u - U[i + 1 - j]
    right[j] = U[i + j] - u
    saved = 0.0
    for r in 0..<j:
      let temp = N[r] / (right[r + 1] + left[j - r])
      N[r] = saved + right[r + 1] * temp
      saved = left[j - r] * temp
    N[j] = saved
