object sara {
  var property peso = 55
  var property vitalidad = 90
  var property temperatura = 37
  var property fiebre = 38 
  
  method cambiarTemp(valor) {
    temperatura -= valor
  }
  
  method cambiarVitalidad(valor) {
    vitalidad -= valor
  }
  
  method cambiarPeso(valor) {
    peso -= valor
  }
  
  method afectaEnfermedad(enfermedad) {
    enfermedad.afectar(self)
  }
  
  method ingiereDosis(medicacion) {
    medicacion.afectar(self)
  }
}

object malaria {
  method afectar(persona) {
    persona.cambiarTemp(3)
  }
}

object vericela {
  method afectar(persona) {
    persona.cambiarVitalidad(5)
    persona.cambiarPeso(persona.peso() * 0.1)
  }
}

object gripe {
  method afectar(persona) {
    persona.cambiarVitalidad(persona.vitalidad() * 0.2)
  }
}

object paracetamol {
  method afectar(persona) {
    if (persona.fiebre() > 37) {
      persona.fiebre(37)
    }
  }
}

object polen {
  var property cantidad = 10

  method afectar(persona) {
    persona.cambiarVitalidad(-cantidad * 0.1)
  }
}

object nuez {
  method afectar(persona) {
     persona.cambiarVitalidad(-persona.vitalidad() * 0.3)
  }
}