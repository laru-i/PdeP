// ENTRENADOR
object ash {
  var property pokemones = []
  
  method groso() = pokemones.sum({ p => p.nivel() }) > 100
  
  method pokemonesPulentas() = pokemones.filter({ p => p.esPulenta() })
} // POKEMONES

object charizard {
  var property ataque = lanzallamas
  var property potencia = 5
  
  method aprenderAtaque(nuevoAtaque) {
    ataque = nuevoAtaque
  }
  
  method nivel() = ataque.potencia()
  
  method esPulenta() = false
}

object pikachu {
  var property ataques = [agilidad, trueno, colaDeHierro]
  
  method nivel() = ataques.sum({ ataque => ataque.potencia() })
  
  method esPulenta() = ataques.size() > 2
}

object psyduck {
  method nivel() = 0
  
  method esPulenta() = false
}

object blastoise {
  var property principal = hidrobomba
  var property secundario = rayoDeHielo
  
  method entrenarse(ataque) {
    secundario = principal
    principal = ataque
  }
  
  method nivel() = principal.potencia() + secundario.potencia()
  
  method esPulenta() = false
} // ATAQUES

object agilidad {
  var property potencia = 5
}

object hidrobomba {
  var property potencia = 5
}

object rayoDeHielo {
  var property potencia = 1
}

object trueno {
  var property potencia = 5
}

object colaDeHierro {
  var property potencia = 5
}

object lanzallamas {
  var property potencia = 5
}