data Postulante = UnPostulante {nombre :: String, edad :: Double, remuneracion :: Double, conocimientos :: [String]} deriving (Show)

data Puesto = UnPuesto {puesto :: String, conocRequeridos :: [String]} deriving (Show)

type Nombre = String

apellidoDueno :: Nombre
apellidoDueno = "Gonzalez"

-- 1
tieneConocimientos :: Puesto -> Postulante -> Bool
tieneConocimientos puesto postulante = (all (\c -> c `elem` (conocimientos postulante)) . conocRequeridos) puesto

edadAceptable :: Double -> Double -> Postulante -> Bool
edadAceptable min max postulante = edad postulante > min && edad postulante < max
-- edadAceptable min max postulante = between postulante min max 


sinArreglo :: Postulante -> Bool
sinArreglo postulante = ((/= apellidoDueno) . last . words) (nombre postulante)
-- sinArreglo postulante = last (nombre postulante) (/= apellidoDueno)

-- 2
type Requisitos = (Postulante -> Bool)

preseleccion :: [Postulante] -> [Requisitos] -> [Postulante]
preseleccion postulantes requisitos = filter (cumpleTodos requisitos) postulantes

cumpleTodos :: [Requisitos] -> Postulante -> Bool
cumpleTodos requisitos postulante = all (\req -> req postulante) requisitos

-- ghci> preseleccion [tito, pepe] [tieneConocimientos puesto, edadAceptable 30 40, sinArreglo]

-- ghci> preseleccion [pepe] [tieneConocimientos jefe, edadAceptable 30 40, sinArreglo, (not . `elem` . "repetir logica" . conocimientos pepe)]

-- 3
incrementarEdad :: Postulante -> Postulante
incrementarEdad postulante = postulante {edad = edad postulante + 1}

actualizarSueldo :: Double -> Postulante -> Postulante
actualizarSueldo porc postulante = postulante {remuneracion = (remuneracion postulante) + (remuneracion postulante * (porc / 100))}

actualizarPostulantes :: [Postulante] -> [Postulante]
-- lista por comprension
actualizarPostulantes postulantes = [(actualizarSueldo 27 . incrementarEdad) post | post <- postulantes]
-- actualizarPostulantes postulantes = [post | post <- postulantes,  actualizarSueldo 27 incrementarEdad]

-- comp y ap parcial
actualizarPostulantes' :: [Postulante] -> [Postulante]
actualizarPostulantes' postulantes = map (actualizarSueldo 27 . incrementarEdad) postulantes

-- 4
data Estudiante = UnEstudiante{conocimientoss :: [String], legajo :: Double}
data Persona = Estudiante | Postulante

capacitar :: Postulante -> String -> Postulante
capacitar postulante conoc = postulante {conocimientos = agregarConoc (conocimientos postulante) conoc}

agregarConoc conocimientos conoc = conocimientos ++ [conoc]

capacitarEst :: Estudiante -> String -> Estudiante
capacitarEst estudiante conoc = estudiante {conocimientoss = agregarConoc (init (conocimientoss estudiante)) conoc}

capacitacion :: Puesto -> Postulante -> Postulante
-- capacitacion puesto post = foldl (\c p -> p c) post (conocRequeridos puesto)
capacitacion puesto post = ((foldl capacitar post) . conocRequeridos) puesto
