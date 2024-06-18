data Persona = Persona {nombre :: String, habilidades :: [String], reflejos :: Double, bebidas :: [(Persona -> Persona)]}

-- bebidas
cafe :: Persona -> Persona
cafe persona = persona {reflejos = reflejos persona + 5}

whisky :: Persona -> Double -> Double -> Persona
whisky persona porc hielo = persona {habilidades = filter longitudMayorA6 (habilidades persona), reflejos = reflejos persona - abs (porc - hielo)}
-- whisky persona porc hielo = persona {habilidades = filter ((> 6) . length) (habilidades persona), reflejos = reflejos persona - abs (porc - hielo)}


longitudMayorA6 :: String -> Bool
longitudMayorA6 habilidad = ((> 6) . length) habilidad

cerveza :: Persona -> Double -> Persona
-- cerveza persona porc = persona {reflejos = reflejos persona - porc, habilidades = tail (habilidades persona)}
cerveza persona porc = persona {reflejos = reflejos persona - porc, habilidades = reducirHabilidades (habilidades persona)}

reducirHabilidades (x : xs) = xs
reducirHabilidades [] = []

gaseosa :: Persona -> Double -> Persona
gaseosa persona azucar = persona {reflejos = reflejos persona + (azucar / 2)}

agua :: Persona -> Persona
agua persona = persona

-- chocolatada :: Persona -> Persona
-- chocolatada persona =

ana :: Persona
ana = (Persona "Ana", ["jugar al pocker", "cantar"], 20, [])

tomar :: Persona -> (Persona -> Persona) -> Persona
tomar persona bebida = bebida persona {bebidas = bebidas persona ++ [bebida]}

degustar :: [(Persona -> Persona)] -> Persona -> Persona
degustar tragos persona = foldl (\p t -> t p) persona tragos

sobrias :: [Persona] -> [(Persona -> Persona)] -> [Persona]
sobrias personas tragos = filter (sobria . (degustar tragos)) personas
-- sobrias personas tragos = filter (sobria) $ (\p -> degustar tragos p) personas

sobria :: Persona -> Bool
sobria persona = reflejos persona > 80 && length (habilidades persona) > 2

-- mejorBebida :: Persona -> [(Persona -> Persona)] -> Persona
-- mejorBebida persona tragos = maximum reflejos persona (map (\t -> t persona) tragos) persona
-- mejorBebida persona tragos = foldl1 (\t p -> t persona > p persona) tragos 
-- mejorBebida persona tragos = foldl1 (\t p -> maximum ((reflejos . t persona) (reflejos  .p persona))) tragos persona
mejorBebida :: Persona -> [(Persona -> Persona)] -> (Persona -> Persona)
mejorBebida persona tragos = foldl1 (\t1 t2 -> bebidaElegir t1 t2 persona) tragos
-- mejorBebida persona tragos = snd . maximum (map (\b -> (reflejos (b persona), b)) tragos)


bebidaElegir ::(Persona -> Persona) -> (Persona -> Persona) -> Persona -> (Persona -> Persona)
bebidaElegir t1 t2 persona
    | reflejos (t1 persona) > reflejos (t2 persona) = t1
    | otherwise = t2

-- tragos infinitos
tragoInfinito :: (Persona -> Persona) -> [(Persona -> Persona)]
tragoInfinito trago = repeat trago

habilidadesInfinitas :: Persona -> Persona
habilidadesInfinitas persona = persona {habilidades = cycle (habilidades persona)}

