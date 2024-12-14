object productora {
  var property impuesto = 100
  const property bandas = []
  const property asistentes = []
  
  method gananciaTotal() = self.totalAsistentes() - self.presupuestoBandas()
  
  method presupuestoBandas() = bandas.sum({ b => b.presupuesto() })
  
  method totalAsistentes() = asistentes.sum({ a => a.totalGastado() })
  
  method entradasVendidas() = asistentes.sum({ a => a.cantEntradas() })
  
  method bandaMasPopular() = bandas.max({ b => b.popularidad() })
}

class Entrada {
  var property banda
  var property fecha
  var property precioBase = 1000
  
  method precioAlPublico() = precioBase + productora.impuesto()
}

class Asistentes {
  var property abono
  var property historialEntradas = []
  var property dinero
  
  method validarCompra(entrada) {
    if (self.saldoPositivo()) {
      self.comprar(entrada)
    } else {
      throw new Exception(message = "error")
    }
  }
  
  method comprar(entrada) {
    dinero -= abono.precioConDescuento(entrada.precioAlPublico())
    historialEntradas.add(entrada)
  }
  
  method saldoPositivo() = dinero > 0
  
  method totalGastado() = historialEntradas.sum({ e => e.precioTotal() })
  
  method nombreBandas() = historialEntradas.map({ e => e.banda() }).asSet()
  
  method cantEntradas() = historialEntradas.size()
}

class Vip {
  var property porcentaje
  
  method precioConDescuento(monto) = (monto * porcentaje) / 100
}

object fan {
  var property porcentaje = 0
  
  method precioConDescuento(monto) = monto
}

class Bandas {
  var property nombre
  var property canon = 1000000
  
  method presupuesto() = canon
  
  method popularidad()
}

class Rock inherits Bandas {
  var property extra = 10000
  var property solos = 2
  
  override method presupuesto() = super() + extra
  
  override method popularidad() = 100 * solos
}

class Trap inherits Bandas {
  var property tieneHielo
  
  override method popularidad() {
    if (tieneHielo) {
      return 1000
    } else {
      return 0
    }
  }
  
  override method presupuesto() = super() * self.popularidad()
}

class Indies inherits Bandas {
  var property extra
  var property inst = []
  
  method cantInstrumentos() = inst.size()
  
  override method presupuesto() = super() + (500 * self.cantInstrumentos())
  
  override method popularidad() = 3.14 * nombre.size()
}