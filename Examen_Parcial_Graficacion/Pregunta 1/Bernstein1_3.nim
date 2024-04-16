proc computeBernstein(n: int, u: float): seq[float] =
    var B: seq[float] = newSeq[float](n + 1)
    B[0] = 1.0
    var ul: float = 1.0 - u
    
    for j in 1..n:
        var saved = 0.0
        for k in 0..<j:
            var temp = B[k]
            B[k] = saved + ul * temp
            saved = u * temp
        B[j] = saved

    return B

# Ejemplo de uso:
var n = 5
var u = 0.3
var B = computeBernstein(n, u)
echo B
