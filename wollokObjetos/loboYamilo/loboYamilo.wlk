// LOBO YAMILO
object yamilo {
  var calorias = 100
  
  method calorias() = calorias
  
  method comer(unAnimal) {
    calorias = unAnimal.peso() / 10
  }
  
  method sobrepeso() = calorias > 200
  
  method saludable() {
    calorias.between(20, 150)
  }
  
  method corre(tiempo) {
    calorias -= tiempo * 2
  }
}

object chanchito {
  var peso = 10
  
  method peso() = peso
  
  method peso(unPeso) {
    peso = unPeso
  }
} /* TOM Y JERRY */

object tom {
  var energia = 20
  var posicion = 30
  
  method energia() = energia
  
  method energia(unaEnergia) {
    energia = unaEnergia
  }
  
  method posicion() = posicion
  
  method velocidad() = 5 + (energia / 5)
  
  method atrapar(unAnimal) = self.velocidad() > unAnimal.velocidad()
  
  method corre(unAnimal) {
    energia -= self.consumo(unAnimal)
    posicion = unAnimal.posicion()
  }
  
  method consumo(unAnimal) = (0.5 * self.velocidad()) * self.distancia(unAnimal)
  
  method distancia(unAnimal) = (unAnimal.posicion() - posicion).abs()
}

object jerry {
  var peso = 4
  var posicion = 34
  
  method peso() = peso
  
  method peso(unPeso) {
    peso = unPeso
  }
  
  method posicion() = posicion
  
  method velocidad() = 10 - peso
}

object ratonRobot {
  var peso = 4
  var posicion = 34
  
  method peso() = peso
  
  method peso(unPeso) {
    peso = unPeso
  }
  
  method posicion() = posicion
  
  method velocidad() = 8
} /* AFECCIONES */

object sara {
  var property peso = 55
  var property vitalidad = 90
  var property temp = 37
  
  method incrementarTemp(valor) {
    temp += valor
  }
  
  method modificarVitalidad(valor) {
    vitalidad += valor
  }
  
  method modificarPeso(valor) {
    peso += valor
  }
}

object malaria {
  method afecta(persona) {
    persona.incrementarTemp(3)
  }
}

object varicela {
  method afecta(persona) {
    persona.modificarVitalidad(-5)
    persona.modificarPeso((-persona.peso()) * 0.1)
  }
}

object gripe {
  method afecta(persona) {
    persona.modificarVitalidad((-persona.vitalidad()) * 0.2)
  }
}

object paracetamol {
  method afecta(persona) {
    if (persona.temp() > 37) persona.temp(37)
  }
}

object polen {
  method afecta(persona) {
    persona.modificarVitalidad(persona.vitalidad() * 0.1)
  }
}

object nuez {
  method afecta(persona) {
    persona.modificarVitalidad(persona.vitalidad() * 0.3)
  }
}

object baculo {
  var property poderBase = 250
  
  method poder(guerrero) {
    if (guerrero.pocaVida()) {
      return (poderBase * 2).min(400)
    } else {
      return poderBase.min(400)
    }
  }
}

object guerrero {
  var property vida = 20
  
  method pocaVida() = vida < 50
}

object flechaDeBronce {
  var property puntos = 100
  const fechaLustrada = new Date(day = 1, month = 1, year = 2024)
  
  method puntosFinales(fecha) {
    var valor = self.restaDeFechas(fecha)
    if (valor >= 100) {
      return puntos - 100
    } else {
      return puntos - self.restaDeFechas(fecha)
    }
  }
  
  method restaDeFechas(fecha) = self.cantidadDeDias(
    fecha
  ) - self.cantidadDeDias(fechaLustrada)
  
  method cantidadDeDias(fecha) {
    var dia = fecha.day()
    var mes = fecha.month()
    var anio = fecha.year()
    
    return ((anio * 365) + (mes * 30)) + dia
  }
}