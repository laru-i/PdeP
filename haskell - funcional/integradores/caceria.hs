
data Personaje = UnPersonaje
  { experiencia :: Float,
    elemento :: Elemento,
    fuerzaBasica :: Float
  }

type Elemento = Float -> Float

nivel :: Personaje -> Integer
nivel personaje = ceiling (experiencia personaje ^ 2 / (experiencia personaje + 1))

capacidad :: Personaje -> Float
capacidad personaje = elemento personaje (fuerzaBasica personaje)

type Alquimista = Personaje -> Personaje

aprendices :: Alquimista
aprendices personaje = alterarElem (* 2) personaje

alterarElem :: Elemento -> Alquimista
alterarElem elem personaje = personaje {elemento = elem . elemento personaje}

maestros :: Int -> Alquimista
maestros años pers = (alterarElem (extraPorAntiguedad años) . aprendices) pers

extraPorAntiguedad 0 = id
extraPorAntiguedad años = (* 1.1) . extraPorAntiguedad (años - 1)

estafadores :: Alquimista
estafadores pers = pers {elemento = id}

inventado :: Alquimista
inventado personaje = personaje {elemento = (\x -> x * experiencia personaje)}

capacidadSuperiorA :: Float -> Personaje -> [Alquimista] -> [Alquimista]
-- capacidadSuperiorA valor personajes = filter (\p -> capacidad p > valor) personajes
capacidadSuperiorA valor personaje alquimistas = filter (tieneCapacidadSuperiorA valor personaje) alquimistas

tieneCapacidadSuperiorA :: Float -> Personaje -> Alquimista -> Bool
tieneCapacidadSuperiorA valor pers alqui = (valor <) . capacidad . alqui $ pers

todosConvienen :: Personaje -> [Alquimista] -> Bool
todosConvienen pers alquimistas = all (tieneCapacidadSuperiorA (capacidad pers) pers) alquimistas

-- mounstros
data Mounstro = Mounstro {especie :: String, resistencia :: Float, habilidades :: [Habilidad]}
type Habilidad = (String, String)

agresivo :: Mounstro -> Bool
-- agresivo mounstro = length (filter (\x -> esHabilidadOfensiva x) habilidades mounstro) >  && resistencia mounstro > 0 && (not.especieInofensiva) (especie mounstro)
agresivo mounstro = tieneMasHabOfensivas (habilidades mounstro) && resistencia mounstro > 0 && (not.especieInofensiva) (especie mounstro)

tieneMasHabOfensivas :: [Habilidad] -> Bool
tieneMasHabOfensivas habilidades = (length . filter (esHabilidadOfensiva.snd)) habilidades > div (length habilidades) 2

esHabilidadOfensiva :: String -> Bool
esHabilidadOfensiva habilidad = habilidad == "magica" || habilidad == "fisica"

especieInofensiva :: String -> Bool
especieInofensiva especie = especie == "animal" || especie == "choboco"

leGana :: Personaje -> Mounstro -> Bool
leGana personaje mounstro = capacidad personaje > resistencia mounstro

estado :: Personaje -> [Mounstro] -> Personaje
estado personaje mounstros = foldl estadoPersonaje personaje mounstros

estadoPersonaje :: Personaje -> Mounstro -> Personaje
estadoPersonaje personaje mounstro | leGana personaje mounstro = personaje {experiencia = experiencia personaje + 100}
                                   | otherwise = personaje {experiencia = experiencia personaje - 50, elemento = (*0.9) . elemento personaje}

noPuedeVencer :: [Mounstro] -> Personaje -> Bool
noPuedeVencer mounstros pers = any (\x -> not (leGana pers x)) mounstros










-- aprendiz :: Alquimista
-- aprendiz personaje = alterarElemento (2 *) personaje

-- alterarElemento :: Elemento -> Personaje -> Personaje
-- alterarElemento elem personaje = personaje {elemento = elem . elemento personaje}

-- maestro :: Int -> Alquimista
-- maestro anos personaje = alterarElemento (extraPorAntiguedad años) . aprendiz $ personaje

-- -- extraPorAntiguedad :: Int -> Float
-- extraPorAntiguedad 0 = id
-- extraPorAntiguedad años = (* 1.1) extraPorAntiguedad (años - 1)