-- Modelo inicial
data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

-- Jugadores de ejemplo
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int

-- Funciones útiles
between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b | f a > f b = a
                 | otherwise = b

-- 1
putter :: Habilidad -> Tiro
putter habilidad = UnTiro {velocidad = 10, precision = (precisionJugador habilidad) * 2, altura = 0}

madera :: Habilidad -> Tiro 
madera habilidad = UnTiro {velocidad = 100, precision = div (precisionJugador habilidad) 2, altura = 5}

hierros :: Int -> (Habilidad -> Tiro)
hierros n habilidad = UnTiro {velocidad = fuerzaJugador habilidad * n, precision = div (precisionJugador habilidad) n, altura = (n-3) `max` 0}

type Palo = (Habilidad -> Tiro)

palos :: [Palo]
palos = [putter, madera] ++ map hierros [1..10]

-- 2
golpe :: Jugador -> Palo -> Tiro
golpe jugador palo = palo (habilidad jugador)

-- 3
type Obstaculo = Tiro -> Tiro

superaObstaculo :: (Tiro -> Bool) -> (Tiro -> Tiro) -> Obstaculo
superaObstaculo condicion efecto tiro | condicion tiro = efecto tiro
                                      | otherwise = tiro {velocidad = 0, precision = 0, altura = 0}

tunelConRampa :: Obstaculo
tunelConRampa tiro = superaObstaculo superaTunel despuesTunel tiro

superaTunel :: Tiro -> Bool
superaTunel tiro = precision tiro > 90 && altura tiro == 0

despuesTunel :: Tiro -> Tiro
despuesTunel tiro = tiro {velocidad = velocidad tiro * 2, precision = 100, altura = 0}

laguna :: Int -> Obstaculo
laguna largo tiro = superaObstaculo superaLaguna (despuesLaguna largo) tiro

superaLaguna :: Tiro -> Bool
superaLaguna tiro = velocidad tiro > 80 && altura tiro > 1 && altura tiro < 5

despuesLaguna :: Int -> Tiro -> Tiro
despuesLaguna largo tiro = tiro {velocidad = velocidad tiro, precision = precision tiro, altura = div (altura tiro) largo}

hoyo :: Obstaculo
hoyo tiro = superaObstaculo superaHoyo despuesHoyo tiro

superaHoyo :: Tiro -> Bool
superaHoyo tiro = between (velocidad tiro) 5 20 && altura tiro == 0 && precision tiro > 95

despuesHoyo :: Tiro -> Tiro
despuesHoyo tiro = tiro  {velocidad = 0, precision = 0, altura = 0}

-- 4
palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles jugador obst = filter (\p -> pasaObst obst (golpe jugador p)) palos

pasaObst :: Obstaculo -> Tiro -> Bool
pasaObst obst tiro = obst tiro /= UnTiro 0 0 0

consecutivos :: [Obstaculo] -> Tiro -> Int
consecutivos obstaculos tiro = (length . takeWhile) (\ob -> pasaObst ob tiro) obstaculos

paloMasUtil :: Jugador -> [Obstaculo] -> Palo
paloMasUtil jug obstaculos = maximoSegun (\o -> palosUtiles jug o)  ???

