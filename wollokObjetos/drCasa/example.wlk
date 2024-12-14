// TEMPORADA 1
class Enfermedad {
  var property celulasAmenazadas = 100
  
  method esAgresiva(persona)
  
  method afecta(persona)

  method atenuar(dosis, persona) {
    
  } 
}

class Infecciosa inherits Enfermedad {
  override method afecta(persona) {
    persona.cambiarTemp(celulasAmenazadas / 1000)
  }
  
  method reproducirse() {
    celulasAmenazadas += celulasAmenazadas
  }
  
  override method esAgresiva(
    persona
  ) = celulasAmenazadas > (persona.celulas() * 0.001)
}

class AutoInmune inherits Enfermedad {
  var property dias
  
  override method afecta(persona) {
    dias += 1
    persona.disminuirCelulas(celulasAmenazadas)
  }
  
  override method esAgresiva(persona) = dias > 30
}

class Persona {
  var property temperatura
  var property celulas
  var property enf = []
  
  method cambiarTemp(valor) {
    temperatura = 45.min(temperatura + valor)
  }
  
  method disminiurCelulas(valor) {
    celulas -= valor
  }
  
  method contraerEnfermedad(enfermedad) {
    enf.add(enfermedad)
  }
  
  method vivirUnDia() {
    enf.forEach({ e => e.afecta(self) })
  }
  
  method coma() = (temperatura == 45) || (celulas < 1000000)

  method atenuar(dosis) {
    enf.forEach({ e => })
  } 
}

class Medico inherits Persona {
  var property dosis

  method atender()
}