object andy {
  var property libros = #{}
  
  method ultimoLibro() = libros.last()
  
  method primerLibro() = libros.head()
  
  method librosLeidos() = libros.size()
  
  method eliminarPrimerLibro() {
    libros.remove(self.primerLibro())
  }
  
  method eliminarLibro(lib) = libros.remove(lib)
  
  method mejorLibro() {
    libros.max({ l => l.valoracion() })
  }
  
  method peorLibro() {
    libros.min({ l => l.valoracion() })
  }
  
  method librosBuenos() = libros.filter({ l => l.valoracion() > 12 })
  
  method librosMalos() {
    libros.remove(libros.filter({ l => l.valoracion() < 7 }))
  }
  
  method valoracionLibros() = libros.sum(
    { l => l.valoracion() }
  ) / self.librosLeidos()
  
  method libroN(n) {
    libros.find({ l => l.valoracion() > n })
  }
}

object harryPotter {
  var property lectores = 10500156
  
  method valoracion() = lectores / 100000
}

object senorDeLosAnillos {
  var property paginas = 450
  
  method valoracion() = paginas / 45
}

object principito {
  method valoracion() = 50
}

object juegosDelHambre {
  var property votosPositivos = 1600200
  var property votosNegativos = 300600
  
  method coeficiente() = (votosPositivos - votosNegativos).max(0)
  
  method valoracion() {
    if (self.coeficiente() > 0) {
      return self.coeficiente() / 1000
    } else {
      return 0
    }
  }
}

object venasAbiertas {
  var property publicacion = 2000
  
  method valoracion() = publicacion / 3
}

object rayuela {
  var property letras = 2000
  
  method valoracion() = letras * 2
}