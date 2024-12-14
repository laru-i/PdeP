class Jugador {
  var property antiguedad = 100
  var property competenciasIntern = 2
  var property cansancio = 0
  var property bebidas = 2
  
  method titular() = antiguedad > 3
  
  method experiencia() = competenciasIntern > 2
  
  method puedeJugar() = self.titular() && self.experiencia()
  
  method tomarBebidaEnergizante() {
    cansancio -= bebidas * 10
  }
  
  method jugar() {
    cansancio += 20
  }
  
  method habilidad() = ((antiguedad * 2) + (competenciasIntern * 3)) - cansancio
}

const rekkes = new Jugador(antiguedad = 9, competenciasIntern = 14)

const josedeodo = new Jugador(antiguedad = 4, competenciasIntern = 1)

object faker {
  var property tilteado = true
  var property habilidadAcumulada = 10
  
  method habilidad() {
    if (tilteado) 0 else habilidadAcumulada
  }
  
  method tomaUnTe() {
    tilteado = false
  }
  
  method puedeJugar() = !tilteado
  
  method jugar() {
    habilidadAcumulada += 50
  }
}

object partidas {
  var property participantes = []
  
  method agregarParticipante(participante) {
    participantes.add(participante)
  }
  
  method comenzar() {
    participantes.forEach({ p => p.jugar() })
  }
  
  method ganador() {
    participantes.max({ p => p.habilidad() })
  }
}

class Equipo {
  var property jugadores = []
  
  method agregarJugador(jugador) {
    jugadores.add(jugador)
  }
  
  method todosDisponibles() {
    jugadores.all({ j => j.puedeJugar() })
  }
  
  method habilidad() {
    jugadores.sum({ j => j.habilidad() })
  }
}