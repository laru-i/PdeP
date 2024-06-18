data Auto = UnAuto {color :: String, velocidad :: Integer, distancia :: Integer}

-- data Carrera = UnaCarrera{kilometros :: Integer}

type Carrera = [Auto]

-- 1
-- a
estaCerca :: Auto -> Auto -> Bool
estaCerca auto1 auto2 = abs (distancia auto1 - distancia auto2) < 10 && color auto1 /= color auto2

-- b
vaTranki :: Auto -> Carrera -> Bool
vaTranki auto autos = all (\a -> not (estaCerca a auto)) autos && mayorDistancia auto autos

mayorDistancia :: Auto -> Carrera -> Bool
mayorDistancia auto autos = all (\a -> distancia a < distancia auto) autos

-- c
puesto :: Auto -> Carrera -> Int
puesto auto autos = 1 + length (filter (\a -> distancia a > distancia auto) autos)

-- 2
-- a
corra :: Auto -> Integer -> Auto
corra auto tiempo = auto {distancia = distancia auto + (tiempo * velocidad auto)}

-- b
-- i
type ModificadorDeVelocidad = Integer -> Integer

alterarVelocidad :: ModificadorDeVelocidad -> Auto -> Auto
alterarVelocidad modif auto = auto {velocidad = modif (velocidad auto)}

-- ii
bajarVelocidad :: Integer -> Auto -> ModificadorDeVelocidad -> Auto
bajarVelocidad cant auto modif = auto {velocidad = max 0 (modif (velocidad auto - cant))} 

bajarVelocidad' cant auto modif = auto {velocidad = max 0 (velocidad (alterarVelocidad (\v -> v - cant) auto)) } 


bajarVelocidad'' :: Integer -> Auto -> Auto
bajarVelocidad'' velocidadABajar  = alterarVelocidad (max 0 . subtract velocidadABajar)

--3
afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a] 
afectarALosQueCumplen criterio efecto lista = (map efecto . filter criterio) lista ++ filter (not . criterio) lista

--a
terremoto :: Auto -> Carrera -> Carrera
terremoto auto = afectarALosQueCumplen (estaCerca auto) (bajarVelocidad'' 50)

--b
miguelitos :: Auto -> Carrera -> Integer -> Carrera
miguelitos auto autos cant = afectarALosQueCumplen (vaGanando auto autos)  (bajarVelocidad'' cant) autos

leVaGanando :: Auto -> Auto -> Bool
leVaGanando auto1 auto2 = distancia auto1 > distancia auto2

vaGanando :: Auto -> Carrera -> Bool
vaGanando auto autos = all (\a -> leVaGanando auto a) autos

--c
jetPack :: Integer -> Auto -> Carrera -> Carrera
jetPack tiempo auto = afectarALosQueCumplen (==auto) (alterarVelocidad (\ _ -> velocidad auto) . corra tiempo . alterarVelocidad (*2)) 

