class Micros {
  var property sentados
  var property parados
  var property volumen
  var property pasajeros = []
  
  method hayLugar() = self.capacidad() > self.cantPasajeros()
  
  method capacidad() = sentados + parados
  
  method cantPasajeros() = pasajeros.size()
  
  method hayLugarSentado() = self.cantPasajeros() < sentados
  
  method lugaresLibres() = self.capacidad() - self.cantPasajeros()
  
  method subir(emp) {
    if (self.hayLugar() && emp.subir(self)) {
      pasajeros.add(emp)
    } else {
      throw new DomainException(message = "no puede subir")
    }
  }
  
  method bajar(emp) {
    self.validarEmp(emp)
    pasajeros.remove(emp)
  }
  
  method validarEmp(emp) {
    if (!pasajeros.contains(emp)) {
      throw new DomainException(message = "no está")
    }
  }
}

class Empleados {
  var edad = 0
  
  method subir(micro)
}

object apurados inherits Empleados {
  override method subir(micro) = true
}

object claust inherits Empleados {
  override method subir(micro) = micro.volumen() > 120
}

object fiacas inherits Empleados {
  override method subir(micro) = micro.hayLugarSentado()
}

class Moderados inherits Empleados {
  var property libre = 0
  
  override method subir(micro) = micro.lugaresLibres() > libre
}