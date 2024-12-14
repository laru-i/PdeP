class Plato {
  var property cocinero
  
  method azucar()
  
  method bienDecorada()
  
  method calorias() = (3 * self.azucar()) + 100
  
  method disminuir(valor) {
    self.azucar() == (self.azucar() - valor)
  }
}

class Entradas inherits Plato {
  override method azucar() = 0
  
  override method bienDecorada() = true
}

class Principales inherits Plato {
  var property azucar
  var property bienDecorada
}

class Postres inherits Plato {
  var property colores
  
  override method azucar() = 120
  
  override method bienDecorada() = colores > 3
}

class Cocinero {
  var property especialidad
  
  method cambiarEspecialidad(nueva) {
    especialidad = nueva
  }
  
  method degustar(plato) {
    especialidad.degustar(plato)
  }
  
  method participarTorneo(torneo) {
    especialidad.cocinar(self) // torneo.presentar
  }
}

class Chef {
  var property calorias
  
  method calificacion(plato) {
    if (plato.bienDecorada() && self.caloriasAcept(plato)) {
      return 10
    } else {
      return self.calificacionBaja(plato)
    }
  }
  
  method calificacionBaja(plato) = 0
  
  method caloriasAcept(plato) = plato.calorias() < calorias
  
  method cocinar(unCoc) = new Principales(
    cocinero = unCoc,
    bienDecorada = true,
    azucar = calorias
  )
}

class Repostero {
  var property dulceDeseado
  
  method calificacion(plato) = ((5 * plato.azucar()) / dulceDeseado).min(10)
  
  method cocinar(unCoc) = new Postres(
    cocinero = unCoc,
    colores = dulceDeseado / 50
  )
}

class GardeManger inherits Chef {
  override method calificacionBaja(plato) = (plato.calorias() / 100).min(6)
  
  override method cocinar(unCoc) = new Entradas(cocinero = unCoc)
}

class Torneo {
  const property cocineros = []
}