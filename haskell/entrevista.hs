data Postulante = Postulante {nombre :: String, edad :: Double, remuneracion :: Double, conocimientos :: [String]} | Estudiante {legajo :: String, conocimientos :: [String]}

pepe = Postulante "Jose Perez" 35 15000.0 ["Haskell", "Prolog", "Wollok", "C"]

tito = Postulante "Roberto Gonzalez" 20 12000.0 ["Haskell", "PHP"]

type Nombre = String

data Puesto = Puesto {puesto :: String, conocimientoRequeridos :: [String]} deriving (Show)

jefe = Puesto "gerente de sistemas" ["Haskell", "Prolog", "Wollok"]

chePibe = Puesto "cadete" ["ir al banco"]

-- 1) Recursos Humanos

type Requisito = Postulante -> Bool

apellidoDuenio :: Nombre
apellidoDuenio = " Gonzalez"

tieneConocimientos :: Puesto -> Requisito
tieneConocimientos puesto postulante =
  all (\requerimiento -> elem requerimiento (conocimientos postulante)) . conocimientoRequeridos $ puesto

tieneConocimientos' :: Puesto -> Requisito
tieneConocimientos' puesto postulante = all (flip elem (conocimiento postulante)) . conocimientoRequeridos $ puesto

edadAceptable :: Int -> Int -> Requisito
edadAceptable edadMin edadMax postulante = (edad postulante) >= edadMin && (edadPostulante) <= edadMAx

sinArreglo :: Requisito
sinArreglo postulante = (\= apellidoDueno) . last . words . nombre $ postulante

-- 2) Preselección

preseleccion :: [Postulante] -> [Requisito] -> [Postulante]
preseleccion postulantes requisitos = filter (cumpleTodos requisitos) postulantes

cumpleTodos :: [Requisito] -> Postulante -> Bool
cumpleTodos requisitos postulante = all (\req -> req postulante) requisitos

-- ghci>preseleccion [pepe, tito] [tieneConocimientos jefe, edadAceptable 30 40, sinArrego, (not.elem "repetir logica". conocimientos)]

-- 3) Esperando que te llamen

-- Por Lista por comprension
actualizarPostulantes :: [Postulante] -> [Postulante]
actualizarPostulantes postulantes = [(aumentarSueldo 27 . incrementarEdad) postulante | postulante <- postulantes]

-- Composicion y aplicacion parcial
actualizarPostulantes' :: [Postulante] -> [Postulante]

actualizarPostulantes postulantes = map (aumentarSueldo 27 . incrementarEdad) postulantes

-- ¿Cual de las dos preferis? ¿Por qué?
-- Prefiero la opcion b por mas expresividad en el codigo
-- Expresividad es distinto de Declaratividad

-- ¿Qué sucede si la lista de postulantes es infinita?

postulantesInfinitos :: [Postulante]
postulantesInfinitos = pepe : postulantesInfinitos

postulantesInfinitosCon :: Postulante -> [Postulante]
postulantesInfinitosCon unPostulante = unPostulante : (postulantesInfinitosCon unPostulante)

-- Como me devuelve una lista infinita de postulantes mi programa no termina al actualizar los postulantes, no tengo condicion de corte

-- 4) Capacitaciones
-- a)
capacitar :: Postulante -> String -> Postulante
capacitar (Postulante nom edad remune conocimientos) unConocimiento = Postulante nom edad remune (agregar conocimientos unConocimiento)
capacitar (Estudiante legajo conocimientos) unConocimiento = Estudiante legajo (agregar (init conocimientos) unConocimiento)

agregar :: [String] -> String -> [String]
agregar lista elem = (elem : lista)

-- b)
capacitacion :: Puesto -> Postulante -> Postulante
capacitacion unPuesto unPostulante = ((fold capacitar unPostulante) . conocimientosRequeridos) unPuesto

-- (a -> b -> a) -> a -> [b]

-- c)
-- juana = Estudiante "1023040-2" ["Wollok", "Haskell", "Juana"]
-- capacitacion jefa juana