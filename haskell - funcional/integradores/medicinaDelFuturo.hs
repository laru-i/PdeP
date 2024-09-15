data Animal = Raton {nombre :: String, edad :: Double, peso :: Double,
 enfermedades :: [String]} deriving Show
-- Ejemplo de raton
cerebro = Raton "Cerebro" 9.0 0.2 ["brucelosis", "sarampión", "tuberculosis"]
-- Estos son las enfermedades infecciosas
enfermedadesInfecciosas = [ "brucelosis", "tuberculosis"]

-- 1
modificarNombre :: (String -> String) -> Animal -> Animal
modificarNombre f unAnimal = unAnimal { nombre = (f.nombre)unAnimal}
-- modificarNombre f raton = raton {nombre = f (nombre raton)}

modificarEdad :: (Double -> Double) -> Animal -> Animal
modificarEdad f unAnimal = unAnimal { edad = f (edad unAnimal)}

modificarPeso :: (Double -> Double) -> Animal -> Animal
modificarPeso f unAnimal = unAnimal { peso = f (peso unAnimal)}

modificarEnfermedades :: ([String] -> [String]) -> Animal -> Animal
modificarEnfermedades f unAnimal = unAnimal { enfermedades = f (enfermedades unAnimal)}

-- 2 
hierbaBuena :: Animal -> Animal
hierbaBuena animal = modificarEdad sqrt animal

hierbaVerde :: String -> Animal -> Animal
hierbaVerde enfermedad animal = modificarEnfermedades (filter (/= enfermedad)) animal

alcachofa :: Animal -> Animal
alcachofa raton = modificarPeso perderPeso raton

perderPeso :: Double -> Double
perderPeso peso | peso > 2 = peso * 0.9
                | otherwise = peso * 0.95

hierbaMagica :: Animal -> Animal
-- hierbaMagica animal = (modificarEdad (*0) . modificarEnfermedades (const [])) animal 
hierbaMagica animal = (modificarEdad (*0) . modificarEnfermedades (take 0)) animal 



-- 3

medicamento :: [(Animal -> Animal)] -> Animal -> Animal
medicamento hierbas raton = foldl (\unAnimal unaHierba -> unaHierba unAnimal) raton hierbas
-- medicamento hierbas raton = foldl (\unaHierba -> unaHierba raton) hierbas

medicamento' hierbas raton = foldl (flip ($)) raton hierbas

antiAge :: Animal -> Animal
antiAge animal = medicamento (replicate 3 hierbaBuena ++ [alcachofa]) animal

reduceFast :: Int -> Animal -> Animal
reduceFast pot = medicamento ([hierbaVerde "obesidad"] ++ replicate pot alcachofa)

hierbaMilagrosa :: Animal -> Animal
hierbaMilagrosa animal = medicamento (map hierbaVerde enfermedadesInfecciosas) animal

{- 4
Los laboratorios antes de publicar un medicamento, lo prueban con distintos ratones para evaluar los resultados:
Hacer la función que encuentra la cantidadIdeal. Recibe una condición y dice cuál es el primer número natural 
que la cumple.
> cantidadIdeal even           > cantidadIdeal (>5)
2                              6
Hacer la función estanMejoresQueNunca que dado un conjunto de ratones y un medicamento, es cierto cuando cada uno 
pesa menos de 1 kg después de aplicarle el medicamento dado.
Diseñar el siguiente experimento: dado un conjunto de ratones,  encontrar la potencia ideal del 
reduceFatFast necesaria para que todos estén mejores que nunca.
-}

cantidadIdeal :: (Int -> Bool) -> Int
cantidadIdeal criterio = (head . filter criterio) [1..]

estanMejoresQueNunca :: [Animal] -> (Animal -> Animal) -> Bool
estanMejoresQueNunca ratones medic = all ((<1).peso.medic) ratones

potenciaIdeal :: [Animal] -> Int
potenciaIdeal animales = cantidadIdeal(estanMejoresQueNunca animales.reduceFast)