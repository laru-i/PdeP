// TODO: rehacer con el jugar en persona
object tiroAlBlanco {
  var property pato = 10
  
  method jugar(persona) {
    const tickets = persona.punteria() / 10
    persona.cansancio(+3)
    return tickets
  }
}

object pruebaDeFuerza {
  method jugar(persona) {
    if (persona.fuerza() > 75) {
      persona.cansancio(+8)
      return 20
    }
    
    return 0
  }
}

object ruedaDeLaFortuna {
  var property pato = 10
  
  method jugar(persona) {
    if (persona.fuerza() > 75) {
      persona.cansancio(+8)
      return 20
    }
    
    return 0
  }
}

object julieta {
  var property tickets = 15
  var property punteria = 20
  var property cansancio = 0
  var property fuerza = 80 - cansancio

  method cambiarFuerza(valor) {
    fuerza = fuerza - valor
  }

  method incrementarTickets(valor) {
    tickets = tickets + valor
  }

  method jugar(juego) {
    
  }
}