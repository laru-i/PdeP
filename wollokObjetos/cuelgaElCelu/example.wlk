class Celular {
  var property apps = []
  var property ram = 1000
  var property bateria = 100
  
  method memoriaRAMLibre() = ram - apps.sum({ a => a.ocupa() })
  
  method seUsa1min() = bateria - apps.sum({ s => s.gastaBateria() })
} // TODO HACER COMO CLASES

object wpp {
  var property mb = 40
  var property mbConv = 5
  var property cantidadConversaciones = 3
  
  method ocupa() = 40 + (cantidadConversaciones * mbConv)
  
  method gastaBateria() = cantidadConversaciones * mbConv
}

object reproductor {
  var property mb = 2
  var property mbCancion = 2
  var property canciones = 5
  
  method ocupa() = (2 * canciones).min(50)
  
  method gastaBateria() = 2
}

object calculadora {
  var property mb = 2
  var property mbCancion = 2
  var property canciones = 5
  
  method ocupa() = 10
  
  method gastaBateria() = 0
}