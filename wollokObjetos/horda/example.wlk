class Personaje {
  var property rol // guerrero, cazador, brujo
  var property localidades = []
  var property fuerza
  var property inteligencia
  
  method potencial() = (fuerza * 10) + rol.extra()
  
  method esGroso() = self.inteligente() || self.grosoRol()
  
  method inteligente()
  
  method grosoRol() = rol.groso(self)
}

class Humanos inherits Personaje {
  override method inteligente() = inteligencia > 50
}

class Orcos inherits Personaje {
  override method potencial() = super() * 1.1
  
  override method inteligente() = false
}

class Guerrero {
  method extra() = 100
  
  method groso(pers) = pers.fuerza() > 50
}

class Cazador {
  var property mascota
  
  method extra() = mascota.potencial()
  
  method groso(pers) = mascota.longeva()
}

class Mascota {
  var property fuerza
  var property edad
  var property garras = true
  
  method potencial() {
    if (garras) fuerza * 2 else fuerza
  }
  
  method longeva() = edad > 10
}

class Brujo {
  method extra() = 0
  
  method groso(pers) = true
}

class Ejercito {
  var property miembros = []
  
  method potencial() = miembros.sum({ m => m.potencial() })
  
  method invadir(zona) {
    if (zona.potencia() < self.potencial()) zona.esOcupada(self)
  }

  method miembrosMasPotencial() {

  }
}

class Zona {
  var property habitantes
  
  method potencia() = habitantes.potencia()
  
  method esGrande()
  
  method esOcupada(ejercito) {
    habitantes = ejercito
  }
}

class Ciudad inherits Zona {
  override method potencia() = super() + 300
}

class Aldea inherits Zona {
  
}