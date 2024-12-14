class Barcos {
  var property tripulantes = []
  var property mision
  
  method piratasParteDeMision() {
    tripulantes.filter({ t => mision.esUtil(t) })
  }
}

class Pirata {
  var property edad
  var property temeMorir
  var property items = []
  var property dinero
  
  method cantItems() = items.size()
  
  method intrepido() = (edad < 40) && (!temeMorir)
}

class Mision {
  method esUtil(pirata)
}

object leyenda inherits Mision {
  override method esUtil(pirata) = pirata.cantItems() > 10
}

object tesoro inherits Mision {
  override method esUtil(pirata) {
    (pirata.items().contains("brujula") && pirata.items().contains(
      "grogXD"
    )) && (pirata.edad() < 50)
  }
}

class Saqueos inherits Mision {
  var property monedas
  
  override method esUtil(pirata) {
    pirata.dinero() < monedas
  }
}