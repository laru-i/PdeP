data Refugio = Refugio {nombre :: String, animales :: [Animal]}

type Nombre = String

type Raza = String

type Edad = Integer

type Pelaje = [String]

type Resistencia = Integer

type Peso = Integer

type Energía = Integer

data Animal = Perro Nombre Raza Edad Pelaje Peso Resistencia Energía | Gato Nombre Raza Edad Pelaje Peso Resistencia Energía deriving (Show)

type Interesado = (String, [(Animal -> Bool)])

-- 1
deRaza :: Animal -> Bool
deRaza (Perro _ raza _ _ _ _ _) = raza /= "mestizo"
deRaza (Gato _ raza _ _ _ _ _) = raza /= "mestizo"

viejito :: Animal -> Bool
viejito (Perro _ _ edad _ _ _ _) = edad * 7 > 80
viejito (Gato _ _ edad _ _ _ _) = edad * 15 > 80

salvaje :: Animal -> Bool
salvaje (Perro _ _ _ _ _ _ _) = False
salvaje (Gato _ _ _ _ _ _ _) = True

deColor :: Animal -> [Pelaje] -> Bool
deColor (Perro _ _ _ pelaje _ _ _) pelajes = pelaje `elem` pelajes
deColor (Gato _ _ _ pelaje _ _ _) pelajes = pelaje `elem` pelajes

resistencia :: Animal -> Resistencia -> Bool
resistencia (Perro _ _ _ _ _ resistencia _) = (\c -> (c * resistencia) > 50)

esLoQueBusca :: Interesado -> Animal -> Bool
esLoQueBusca interesado animal = all (\c -> c animal) (snd interesado)

animalesQuePuedeAdoptar :: [Animal] -> Interesado -> [Animal]
-- animalesQuePuedeAdoptar animales interesado = filter (\a -> esLoQueBusca interesado a) animales
animalesQuePuedeAdoptar animales interesado = [a | a <- animales, esLoQueBusca interesado a]

cuantosQuierenA :: Animal -> [Interesado] -> Int
cuantosQuierenA animal interesados = length . filter (\i -> esLoQueBusca i animal) $ interesados
-- cuantosQuierenA animal interesados = length (filter (\i -> esLoQueBusca i animal) interesados)
-- cuantosQuierenA animal interesados = length . filter (flip esLoQueBusca animal) interesados

-- obtenerNombres :: [Refugio] -> [String]
-- -- obtenerNombres refugios = concatMap (\refugio -> map nombre (animales refugio)) refugios
-- obtenerNombres refugios = concat (map (map nombre . animales) refugios)

darUnPaseo :: Animal -> Animal
darUnPaseo (Perro nom raza edad pelaje peso res ener) = Perro nom raza edad pelaje peso (res - 2) (ener + 3)
darUnPaseo (Gato nom raza edad pelaje peso res ener) = Gato nom raza edad pelaje peso res (ener + 2)

type Premio = (Animal -> Animal)

premios :: [Premio] -> Animal -> Animal
premios prem animal = foldl (\a p -> p a) animal prem

maximoCrSegun 

maximoSegun [x] _ = x
maximoSegun (x:xs) f | f x > f (maximoSegun xs f) = x 
                    | otherwise = maximoSegun xs f