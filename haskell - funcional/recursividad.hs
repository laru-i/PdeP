-- 1a
data Flor = Flor{nombre :: String, aplicacion :: String, cantidadDeDemanda :: Integer}

maximaFlorSegun :: (Flor -> Integer) ->  [Flor] -> String
maximaFlorSegun f lista = (nombre . maximoSegun f) lista

maximoSegun _ [x] = x
maximoSegun f (x:xs) | f x > f (maximoSegun f xs) = x
                     | otherwise = maximoSegun f xs

-- 1b
ordenada :: [Flor] -> Bool
ordenada [_] = True
ordenada (x:y:xs) = cantidadDeDemanda x > cantidadDeDemanda y && ordenada (y:xs)

-- 2
reversa [] = []
reversa (x:xs) = reversa xs ++ [x]

-- foldl (\(antes, despues) x -> valor > x valor) eventosOrdenados xs
