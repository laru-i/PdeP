{- 1)  Dada una lista de tuplas, sacar la cantidad de elementos utilizando foldl y foldr. -}
cantElementos :: [(Integer, Integer)] -> Integer
cantElementos lista = foldl (\sem _ -> sem + 1) 0 lista

-- cantElementos' :: [(Integer, Integer)] -> Integer
cantElementos' lista = foldr 0 (\sem _ -> sem + 1) lista

cantElementosLength :: [(Integer, Integer)] -> Int
cantElementosLength lista = length lista

{- 2) Dada una lista de pares (empleado, gasto), conocer el empleado más gastador usando foldl y foldr. -}
empleMasGastador :: [(String, Integer)] -> (String, Integer)
empleMasGastador (cab : lista) = foldl masGasto cab lista

masGasto :: (String, Integer) -> (String, Integer) -> (String, Integer)
masGasto empleado otroEmpleado
  | snd empleado > snd otroEmpleado = empleado
  | otherwise = otroEmpleado

empleMasGastador' (cab : lista) = foldr masGasto cab lista

-- empleadoMasGastador :: [(String, Integer)] -> (String, Integer)
-- empleadoMasGastador (cab:lista) = foldl mayorGasto cab lista

-- mayorGasto :: (String, Integer) -> (String, Integer) -> (String, Integer)
-- mayorGasto per otrPer | snd per > snd otrPer = per
--                      | otherwise = otrPer

-- empleadoMasGastadorFoldr (cab:gasto) = foldr mayorGasto cab gasto

{- 3) Dada una lista de (empleado, gasto), conocer el gasto total usando foldl y foldr. -}
gastoTotalEmpleados :: [(String, Integer)] -> Integer
gastoTotalEmpleados lista = foldl (\sem emple -> sem + snd emple) 0 lista

gastoTotalEmpleados' lista = foldr (\(_, monto) sem -> sem + monto) 0 lista

-- gastoTotal :: [(String, Integer)] -> Integer
-- gastoTotal lista = foldl (\sem emple -> sem + snd emple) 0 lista
-- gastoTotal' lista = foldr (\(_, monto) sem -> sem + monto) 0 lista

{- 4) Completar con lo que corresponda para: -}
-- >foldl (\sem fun -> sem fun) 2 [(3+), (*2), (5+)] 15
-- >foldr (\fun sem -> fun sem) 2 [(3+), (*2), (5+)] 17

{- 5) Dada una lista de proyectos -}

type Nombre = String

type InversionInicial = Int

type Profesionales = [String]

data Proyecto = Proy {nombre :: Nombre, inversionInicial :: InversionInicial, profesionales :: Profesionales} deriving (Show)

proyectos = [Proy "red social de arte" 20000 ["ing. en sistemas", "contador"], Proy "restaurante" 5000 ["cocinero", "adm. de empresas", "contador"], Proy "ventaChurros" 1000 ["cocinero"]]

{- 5.1) Determine una función que permita conocer el máximo proyecto según. Revolverlo usando foldl y foldr.
a) La inversión inicial
b) El nro de profesionales.
c) La cantidad de palabras del proyecto.
Muestre por cada caso ejemplos de invocación y respuesta.
-}
maximoProyectoSegun :: [Proyecto] -> (Proyecto -> Int) -> Proyecto
maximoProyectoSegun (proyecto : proyectos) f = foldl (maximoSegun f) proyecto proyectos

maximoSegun :: (Proyecto -> Int) -> Proyecto -> Proyecto -> Proyecto
maximoSegun f unProyecto otroProyecto
  | f unProyecto > f otroProyecto = unProyecto
  | otherwise = otroProyecto

-- maximoProyectoSegun proyectos inversionInicial
-- maximoProyectoSegun proyectos (length.profesionales)
-- maximoProyectoSegun proyectos (length.words.nombre) con length.nombre devuelve el numero de chars, con words el de palabras

maximoProyectoSegun' :: [Proyecto] -> (Proyecto -> Int) -> Proyecto
maximoProyectoSegun' (proyecto : proyectos) f = foldr (maximoSegun f) proyecto proyectos