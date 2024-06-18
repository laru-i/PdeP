type Bien = (String,Float)
data Ciudadano = UnCiudadano {profesion :: String, sueldo :: Float, hijos :: Float, bienes :: [Bien] } deriving Show

-- 1
difDePatrimonio :: [Ciudadano] -> Float
difDePatrimonio ciudadanos = maximum (patrimonios ciudadanos) - minimum (patrimonios ciudadanos)

patrimonios :: [Ciudadano] -> [Float]
patrimonios ciudadanos = map (\c -> sueldo c + sum (map snd (bienes c))) ciudadanos

-- 2
-- autoAltaGama :: Float -> [Bien] -> Bool
-- autoAltaGama valor bienes = any (\b -> snd b > valor) bienes
auto :: Ciudadano -> Bool
auto ciud = null . filter (\(tipo, valor) -> tipo == "auto" && valor > 100000) ciud

-- 3
-- a
auh :: Ciudadano -> Ciudadano
auh ciudadano | hijos ciudadano > 0 = ciudadano {sueldo = sueldo ciudadano + 1000 * hijos ciudadano}
              | otherwise = ciudadano

-- b
impuestoGanancias :: Float -> Ciudadano -> Ciudadano
impuestoGanancias min ciudadano | sueldo ciudadano < min = ciudadano {sueldo = sueldo ciudadano - (30 * sueldo ciudadano /100)}
                                | otherwise = ciudadano

-- c
impuestoAltaGama :: Ciudadano -> Ciudadano
impuestoAltaGama ciudadano | autoAltaGama 100000 (bienes ciudadano) = ciudadano {sueldo = sueldo ciudadano - (10 * sueldo ciudadano /100)}
                           | otherwise = ciudadano

-- d
negociarSueldoProfesion :: String -> Float -> Ciudadano -> Ciudadano
negociarSueldoProfesion prof porc ciudadano | prof == profesion ciudadano = ciudadano {sueldo = sueldo ciudadano + (porc * sueldo ciudadano / 100)}
                                            | otherwise = ciudadano

-- 4
data Gobierno = UnGobierno {años :: [Float], medidas :: [Ciudadano->Ciudadano]}

--a
gobiernoA :: Gobierno
gobiernoA = UnGobierno {años = [1999,2003], medidas = [impuestoGanancias 30000 . negociarSueldoProfesion "profesor" 10, negociarSueldoProfesion "empresarios" 40, impuestoAltaGama, auh]}

gobiernoA' :: Gobierno
gobiernoA' = UnGobierno {años = [1999,2003], medidas = [impuestoGanancias 30000 . negociarSueldoProfesion "profesor" 10, negociarSueldoProfesion "empresarios" 40, impuestoAltaGama, auh]}

--b
gobiernoB :: Gobierno
gobiernoB = UnGobierno  {años = [2004,2008], medidas = [impuestoGanancias 40000 . negociarSueldoProfesion "profesor" 30, negociarSueldoProfesion "camioneros" 40]}

--c
gobernarUnAno :: Gobierno -> [Ciudadano] -> [Ciudadano]
gobernarUnAno _ [] = []
gobernarUnAno gob (ciudadano:resto) = aplicarMedidas gob ciudadano : gobernarUnAno gob resto -- recursiva

gobernarUnAno' gob ciudadanos = map (\c -> aplicarMedidas gob c) ciudadanos

aplicarMedidas :: Gobierno -> Ciudadano -> Ciudadano
aplicarMedidas gobierno ciudadano = foldl (\c m -> m c) ciudadano (medidas gobierno)

--d
gobernarPeriodoCompleto :: Gobierno -> [Ciudadano] -> [Ciudadano]
gobernarPeriodoCompleto _ [] = []
-- gobernarPeriodoCompleto gob (ciudadano:resto) = gobernarUnAno 

--e


--5
trineosInfinitos :: [(String, Float)]
trineosInfinitos = zip (repeat "Rosebud") [5,10..]

kane :: Ciudadano
kane = UnCiudadano {profesion = "Empresario", sueldo = 1000000, hijos = 0, bienes = trineosInfinitos}

--6
-- 
