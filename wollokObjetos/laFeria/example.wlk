object julieta {
  var tickets = 15
  var cansancio = 0
  
  method punteria() = 20
  
  method fuerza() = 80 - cansancio
  
  method tickets() = tickets
  
  method tickets(valor) {
    tickets = valor
  }
  
  method jugar(juego) {
    tickets += juego.ticketsGanados()
    cansancio += juego.cansancioGenerado()
  }
  
  method puedeCanjear(premio) = tickets >= premio.costo()
}

object geru {
  method jugar(juego) = {}

  method puedeCanjear(premio) = true  
}

object ositoPeluche {
  method costo() = 45
}

object taladro {
  var property costo = 200 
}

object tiroAlBlanco {
  method ticketsGanados(jugador) = (jugador.punteria() / 10).roundUp()
  
  method cansancioGenerado() = 3
}

object pruebaDeFuerza {
  method ticketsGanados(jugador) = if (jugador.fuerza() > 75) 20 else 0
  
  method cansancioGenerado() = 8
}

object ruedaDeLaFortuna {
  var property aceitada = true // property genera estos por defecto:
  
  // method aceitada() = aceitada
  //method aceitada(valor) {
  //  aceitada = valor
  //}
  method ticketsGanados(jugador) = 0.randomUpTo(20).roundUp()
  
  method cansancioGenerado() = if (aceitada) 0 else 1
}