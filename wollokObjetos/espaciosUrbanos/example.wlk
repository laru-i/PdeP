object municipio {
  
}

class EspacioUrbano {
  var property valuacion
  var property superficie
  var property nombre
  var property vallado
  const property trabajosRealizados = []
  
  method cierraDeNoche() = vallado
  
  method esGrande() = superficie > 50
  
  method esEspacioVerde() = false
  
  method incrementarValuacion(valor) {
    valuacion += valor
  }
  
  method esLimpiable() = false
  
  method registrar(trabajo) {
    trabajosRealizados.add(trabajo)
  }
}

class Plazas inherits EspacioUrbano {
  var property canchas
  
  override method esGrande() = super() && (canchas.size() > 2)
  
  override method esEspacioVerde() = canchas.size() == 0
  
  override method esLimpiable() = true
}

class Plazoletas inherits EspacioUrbano {
  var property espacioSinCesped
  var property procer
  
  override method esGrande() = (super() && self.cierraDeNoche()) && (procer == "San Martin")
}

class Anfiteatro inherits EspacioUrbano {
  var property capacidad
  var property escenarioMetros
  
  override method esGrande() = super() && (capacidad > 500)
  
  override method esLimpiable() = self.esGrande()
}

class Multiespacio inherits EspacioUrbano {
  const property espacios = []
  
  override method esGrande() = espacios.all({ e => e.esGrande() })
  
  override method esEspacioVerde() = espacios.size() > 3
}

class Trabajadores {
  var property profesion = ""
  const property espacios = []
  
  method costo() = 1000
  
  method cambiarProfesion(nuevaProfesion) {
    profesion = nuevaProfesion
  }
  
  method puedeTrabajar(espacio)
  
  method trabajoHecho(espacio)
  
  method duracion(espacio)
  
  method valorTotal(espacio) = self.costo() * self.duracion(espacio)
  
  method validarTrabajo(espacio) {
    if (!self.puedeTrabajar(espacio)) {
      throw new DomainException(message = "error")
    }
  }
  
  method trabajarEn(espacio) {
    self.validarTrabajo(espacio)
    self.trabajoHecho(espacio)
    self.registrarTrabajo(espacio, self)
  }
  
  method registrarTrabajo(espacioUrbano, trabajador) {
    espacioUrbano.registrar(
      new Trabajo(
        persona = trabajador,
        monto = self.valorTotal(espacioUrbano),
        duracion = self.duracion(espacioUrbano),
        fecha = new Date()
      )
    )
  }
}

object cerrajero inherits Trabajadores {
  override method puedeTrabajar(espacio) = !espacio.vallado()
  
  override method trabajoHecho(espacio) {
    espacio.vallado(true)
  }
  
  override method duracion(espacio) {
    if (espacio.esGrande()) {
      return 5
    } else {
      return 3
    }
  }
}

object jardinero inherits Trabajadores {
  override method puedeTrabajar(espacio) = espacio.esEspacioVerde()
  
  override method trabajoHecho(espacio) {
    espacio.incrementarValuacion(espacio.valuacion() * 0.1)
  }
  
  override method duracion(espacio) = 1 * (espacio.superficie() / 10)
  
  override method costo() = 2500
}

object encargado inherits Trabajadores {
  override method puedeTrabajar(espacio) = espacio.esLimpiable()
  
  override method trabajoHecho(espacio) {
    espacio.incrementarValuacion(5000)
  }
  
  override method duracion(espacio) = 8
}

class Trabajo {
  var property persona
  var property fecha
  var property duracion
  var property monto
}