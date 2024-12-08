class EspaciosUrbanos {
  var valorPesos = 100
  var superficie = 100
  var tieneVallado = false
  var nombre = "Pepe"
  
  method esGrande() {
    return superficie > 50
  }
}

class Plazas inherits EspaciosUrbanos {
  var cantCanchas = 10
  var espEsparcimiento = 10 

  override method esGrande() = super() && cantCanchas > 2
}

class Plazoletas inherits EspaciosUrbanos {
  var procer = "pepe"
  var espSinPasto = 10 

  override method esGrande() = super() && procer == "SanMartin" && tieneVallado
}

class Anfiteatro inherits EspaciosUrbanos {
  var capacidad = 10
  var tamEscenarios = 10  

  override method esGrande() = super() && capacidad > 500
}

class Multiespacio inherits EspaciosUrbanos {
  var espacios = []

  override method esGrande() = super() && espacios.forEach({esp => esp.esGrande()})
}

class Trabajador {
  var costo = 10
  var duracion = 10
  var profesion = ""

  method puedeHacerTrabajo(espacio) = true
  method cambiarProfesion(trabajador) = true 
}

object cerrajero inherits Trabajador {
  
  override method puedeHacerTrabajo(espacio) {
    espacio
  }
}