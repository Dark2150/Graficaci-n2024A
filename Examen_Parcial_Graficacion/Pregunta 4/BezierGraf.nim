import
  x11/xlib,
  x11/xutil,
  x11/x

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
      result += float(term * controlPoints[i][j])

  return result

# Crear una conexión con el servidor X
var display = XOpenDisplay(nil)
if display == nil:
  quit()

# Obtener el identificador de la pantalla predeterminada
var screen = DefaultScreen(display)

# Crear una ventana
var win = XCreateSimpleWindow(display, RootWindow(display, screen),
                              0, 0, 600, 400, 0,
                              BlackPixel(display, screen),
                              WhitePixel(display, screen))

# Seleccionar eventos a los que responder
var mask = ExposureMask or KeyPressMask
XSelectInput(display, win, mask)

# Mostrar la ventana
XMapWindow(display, win)

# Crear un contexto de gráficos
var gc = XCreateGC(display, win, 0, nil)

# Ejemplo de puntos de control para una curva de Bézier
var controlPoints: seq[seq[int]] = @[
  @[100, 200, 300],
  @[50, 150, 200],
  @[200, 250, 400]
]

# Dibujar la curva de Bézier
for t in 0 .. 100:
  let x = evaluateBezier(controlPoints, float(t) / 100.0)
  let y = evaluateBezier(controlPoints[0 .. 1].newSeq, float(t) / 100.0)

  XDrawPoint(display, win, gc, x.int, y.int)
  XFlush(display)

# Bucle principal
while true:
  var event = XEvent()
  XNextEvent(display, &event)
  case event.type:
    of Expose:
      # Redibujar la curva de Bézier si la ventana es expuesta
      for t in 0 .. 100:
        let x = evaluateBezier(controlPoints, float(t) / 100.0)
        let y = evaluateBezier(controlPoints[0 .. 1].newSeq, float(t) / 100.0)

        XDrawPoint(display, win, gc, x.int, y.int)
        XFlush(display)
    of KeyPress:
      # Salir si se presiona una tecla
      break

# Liberar recursos
XFreeGC(display, gc)
XDestroyWindow(display, win)
XCloseDisplay(display)
