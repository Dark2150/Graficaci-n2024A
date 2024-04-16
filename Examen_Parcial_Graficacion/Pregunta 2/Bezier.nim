import math

# Calcula el coeficiente binomial "n choose k"
proc binomialCoefficient(n, k: int): int =
  if k == 0 or k == n:
    return 1
  return binomialCoefficient(n - 1, k - 1) + binomialCoefficient(n - 1, k)

# Evalúa la curva de Bézier en el parámetro t
proc evaluateBezier(controlPoints: seq[seq[int]], t: float): float =
  var n = controlPoints.len - 1
  var m = controlPoints[0].len - 1
  var result: float = 0.0

  for i in 0 .. n:
    for j in 0 .. m:
      var binomialCoeff = binomialCoefficient(n, i) * binomialCoefficient(m, j)
      var term = float(binomialCoeff) * pow(t, float(i)) * pow(1.0 - t, float(n - i)) * pow(t, float(j)) * pow(1.0 - t, float(m - j))
      result += term * float(controlPoints[i][j])

  return result

# Ejemplo de puntos de control para una curva de Bézier
var controlPoints: seq[seq[int]] = @[
  @[100, 200, 300],
  @[50, 150, 200],
  @[200, 250, 400]
]

# Valor de t para evaluar la curva de Bézier
let t = 0.5

# Evaluar la curva de Bézier en el parámetro t
let result = evaluateBezier(controlPoints, t)

echo "Valor de la curva de Bezier en t=", t, ": ", result

