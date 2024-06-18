-- 1
esNotaBochazo :: Integer -> Bool
esNotaBochazo nota = nota < 6

aprobo :: (Integer, Integer) -> Bool
aprobo (nota1, nota2) = (not.esNotaBochazo) nota1 && (not.esNotaBochazo) nota2
-- aprobo not.esNotaBochazo.fst && not.esNotaBochazo.snd

promociono :: (Integer, Integer) -> Bool
promociono (nota1, nota2) =  (nota1 >= 8) && (nota2 >= 8)

-- ghci> (not.esNotaBochazo.fst) (5,8)

-- 2
data Empleado = Comun {sueldoBas :: Integer, nombre :: String} | Jerarquico {sueldoBas :: Integer, gente :: Integer, nombre :: String}  

calcularSueldo :: Empleado -> Integer
calcularSueldo (Comun sueldoBas _) = sueldoBas
calcularSueldo (Jerarquico sueldoBas gente _) = sueldoBas + (gente * 5000)
-- revisar xq no funca

-- 3
data Bebida = Cafe {nombreBebida :: String} | Gaseosa {sabor :: String, azucar :: Integer}

esEnergizante :: Bebida -> Bool
esEnergizante (Cafe nombreBebida) = nombreBebida == "capuchino"
esEnergizante (Gaseosa sabor azucar) = (sabor == "pomelo") && (azucar > 10)
