object pepe {
  var property categoria = 0
  var bonoPresentismo = 0
  var bonoPorResultado = 0
  var faltas = 0
  
  method sueldo() {
    (categoria.neto() + bonoPresentismo.monto(faltas)) + bonoPorResultado.monto(
      categoria.neto()
    )
  }
  
  method categoria(unaCategoria) {
    categoria = unaCategoria
  }
  
  method bonoPresentismo(bono) {
    bonoPresentismo = bono
  }
  
  method bonoPorResultado(bono) {
    bonoPorResultado = bono
  }
}

object gerente {
  method neto() = 10000
}

object cadetes {
  var property neto = 15000
  
  method neto() = neto
}

object bonoDependeDeFaltas {
  method monto(faltas) {
    if (faltas == 0) {
      return 1000
    }
    
    if (faltas == 1) {
      return 500
    }
    return 0
  }
}

object bonoNulo {
  method monto() = 0
}

object bonoFijo {
  method monto() = 800
}

object bonoPorcentaje {
  method monto(neto) = neto * 0.1
}