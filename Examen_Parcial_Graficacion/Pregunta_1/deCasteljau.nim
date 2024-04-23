import math

type
  Point2D = object
    x, y: float

# Evalúa la curva de Bézier en el parámetro t
proc evaluateBezier(controlPoints: seq[Point2D], t: float): Point2D =
  var points: seq[Point2D] = controlPoints

  for r in 1 .. points.len:
    for i in 0 .. points.len - r - 1:
      points[i].x = (1.0 - t) * points[i].x + t * points[i + 1].x
      points[i].y = (1.0 - t) * points[i].y + t * points[i + 1].y

  return points[0]

# Ejemplo de puntos de control para una curva de Bézier cúbica
var controlPoints: seq[Point2D] = @[
  Point2D(x: 100.0, y: 100.0),
  Point2D(x: 200.0, y: 300.0),
  Point2D(x: 400.0, y: 50.0),
  Point2D(x: 500.0, y: 200.0)
]

# Valor de t para evaluar la curva de Bézier
let t = 0.5

# Evaluar la curva de Bézier en el parámetro t
let result = evaluateBezier(controlPoints, t)

echo "Punto en la curva de Bezier en t=", t, ": (", result.x, ", ", result.y, ")"

