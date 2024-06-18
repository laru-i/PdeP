{- 1) Definir la función calcular’, que recibe una tupla de 2 elementos, y devuelve una nueva tupla según 
 las siguientes reglas:
 ●  si el primer elemento es par lo duplica; si no lo deja como está
 ●  si el segundo elemento es impar le suma 1; si no deja como está -}

siguiente :: Integer -> Integer
siguiente nro = nro + 1

doble :: Integer -> Integer
doble nro = nro * 2

primeroPar :: Integer -> Integer
primeroPar nro | even nro = doble nro
               | otherwise = nro

segundoImpar :: Integer -> Integer
segundoImpar nro | odd nro = siguiente nro
                 | otherwise = nro

calcular :: (Integer, Integer) -> (Integer, Integer)
calcular (nro1, nro2) = (primeroPar nro1, segundoImpar nro2)

{-- 2) Definir las funciones boolenas estándar. Sin usar las funciones predefinidas.
2.1) Definir la función and’
2.2) Definir la función or’. --}
