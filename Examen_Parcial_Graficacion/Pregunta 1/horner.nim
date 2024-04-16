proc horner(u: float64, a: seq[float64]): float64 =
  var c: float64 = a[a.len() - 1]
  echo "c[", a.len() - 1, "]=", c, "\n"
  for i in 2 .. a.len():  # Cambio aquí: comienza desde 2 en lugar de 1
    c = a[a.len() - i] + c * u
    echo "c[", a.len() - i, "]=", c, "\n"
  result = c

var a: seq[float64] = @[1.0, 2.0, 2.0, -3, -3.0, 4.0, -10.0, 4.1, -10.0]
var u: float64 = 0.5
echo horner(u, a), ",", a.len()
