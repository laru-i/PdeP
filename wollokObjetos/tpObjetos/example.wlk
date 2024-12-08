/* ARMAS PELIGROSAS */
class Arma{
  var poderArma = 100

  method cambiarPoder(_poder) {
    poderArma = _poder
  }
  method poder(guerrero) {
    return poderArma
  }
}
class Guerrero {
  
  var property vida = 100 // EnergiaBase = Vida de un guerrero cuando se lo inicia
 
  var property armas = #{} //Lista de Armas inicializada en 0

  method cambioDeVida(vidaNueva) {
    vida = vidaNueva
  }

  method pocaVida() = vida<10  

  method tieneArmas() = armas.size()  //Getter de la lista de Armas

  method agregarArma(_arma) { //Agregar armas a la lista
    armas.add(_arma)
  }
  
  method pelea(arma) { 
    return arma.poder(self) 
  }
  method poder() = armas.sum({arma => self.pelea(arma)})  

} 

// INT 1
class Baculo inherits Arma{

  const property poderBase = 250 //Poder base de un arma

  override method poder(guerrero) {
    if (guerrero.pocaVida()) {
      return (poderBase * 2).min(400)
    } else {
      return poderBase.min(400)
    }
  }
}

//INT 2
class Espada inherits Arma{
  const poderBase = 10
  method verPoderArma() = poderBase //Getter de Poder del Arma
  var magiaActual = "Élfica"

    override method poder(mago) {
        if (magiaActual == "Élfica") {
            return 25 * 10
        } else if (magiaActual == "Enana") {
            return (mago.vida() / 2) * 10
        } else {
            return 0
        }
    }
  
      method cambiarMagia(nuevaMagia) {
        magiaActual = nuevaMagia
    }

}
const glamdring = new Espada()

// INT 3
class FlechaDeBronce inherits Arma{
  var fechaLustrada = new Date(day = 1, month = 1, year = 2024)
  var fecha = new Date(day = 5, month = 1, year = 2024)
  
  method ultimoUso(newFecha) {
    fecha = newFecha
  }

  method poder() {
    var valor = self.restaDeFechas()
    if (valor >= 100) {
      return poderArma - 100
    } else {
      return poderArma - self.restaDeFechas()
    }
  }
  
  method restaDeFechas() = 
  self.cantidadDeDias(fecha) - self.cantidadDeDias(fechaLustrada)
  
  method cantidadDeDias(fechaAux) {
    const dia = fechaAux.day()
    const mes = fechaAux.month()
    const anio = fechaAux.year()
    
    return ((anio * 365) + (mes * 30)) + dia 
  }
}

//TODOS
class Gandalf inherits Guerrero {

override method poder() {
    var basePoder
    if (self.pocaVida()) {
      basePoder = vida * 200
    } else {
      basePoder = vida * 15
    }
    
    return basePoder + (armas.sum({arma => arma.poder(self)})) * 2
  }
}

class CajaDeFlechasNegras { 
  var flechas = #{}

  method valor() {
    return flechas.sum({flecha => flecha.valor()})
  }
}

class FlechasAluminio inherits Arma{
  const poderFlecha = 50  

  method valor() = poderFlecha 
}

class FlechasHierro inherits Arma{
  var property valor = 70
  var oxidada = true

  method valor() {
    if(oxidada){
        return valor/2
    }else{
        return valor
    }
  }
}

// Recorriendo la Tierra Media
//INT 1
object lebennin {
 const guardias = #{}

  method cantidadDeGuardias() = guardias.size() 

  method puedePasar(guerrero) {
    return (self.cantidadDeGuardias() > 3 and guerrero.poder() > 1500) or (guerrero.poder() > 1000)
    }
}

//INT 2
object minasTirith {
  method puedePasar(guerrero) {
    if(guerrero.tieneArmas()!=0){ 
     guerrero.cambioDeVida(guerrero.vida()  - (guerrero.tieneArmas()*10)) 
     return true 
    }else{
     return false
    }
  } 
}

//INT 3
object lossarnach{
  method puedePasar(guerrero) {
    guerrero.cambioDeVida(guerrero.vida() + (guerrero.tieneArmas()*2))
    return true  
  }
}

object caminoDeGondor {
  const camino = #{lebennin, minasTirith}
  method recorrido(guerrero) {
    return camino.all{c => c.puedePasar(guerrero)}
  }
}

object tom {
  method poder() = 2000
  method tieneArmas() = 100
  method vida() = 100  
  method cambioDeVida(nuevaVida) { }

  method puedePasar(zona) = true
}

