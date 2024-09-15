pares numeros = [num | num <- numeros, even num]
divisiblePor n numeros = [num | num <- numeros, esDivisiblePor n num]
mayoresA n numeros = [num | num <- numeros , (> n) num]
esDivisiblePor n m = ((==0).(` mod `n))m


find' :: (a -> Bool) -> [a] -> a
find' f lista = (head . filter f) lista 

data Politico = Politico {proyectosPresentados :: [String], sueldo :: Integer,  edad :: Int } deriving Show 
politicos = [ Politico ["ser libres", "libre estacionamiento coches politicos", "ley no fumar", "ley 19182"] 20000 81, Politico ["tratar de reconquistar luchas sociales"] 10000 63, Politico ["tolerancia 100 para delitos"] 15500 49 ]

{- ghci> find' ((<50).edad politicos
Politico {proyectosPresentados = ["tolerancia 100 para delitos"], sueldo = 15500, edad = 49})

ghci> find' ((>3). length.proyectosPresentados) politicos

ghci> find' (any((>3).length.words).proyectosPresentados) politicos
-}

type Nombre = String
type Notas = [Int]
data Persona = Alumno {nombre :: Nombre, notas :: Notas}

{-promediosAlumnos :: [Persona] -> [(Nombre, Int)]
promediosAlumnos listaAlumnos = map (\ Alumno nombre notas -> (nombre, promedio notas)) listaAlumnos -}

promedio :: Notas -> Int
promedio notas = (sum notas) `div` (length notas)

promediosSinAplazos :: [Notas] -> [Int]
promediosSinAplazos lista = map (promedio.filter(>=6)) lista

aprobo :: Persona -> Bool
aprobo alumno = (all (>=6).notas) alumno 

aprobaron :: [Persona] -> [Nombre]
aprobaron alumnos = (map nombre.filter aprobo) alumnos

productos :: [String] -> [Int] -> [(String, Int)]
productos nombres precios = zip nombres precios

productos' :: [String] -> [Int] -> [(String, Int)]
productos' nombres precios = zipWith (\nom pre -> (nom, pre)) nombres precios
