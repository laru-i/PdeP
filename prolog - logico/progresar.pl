postulante(margarita,estudia(ingenieria,8,20)).
postulante(mario,estudia(arquitectura,7,10)).
postulante(pedro,estudia(psicologia,9,8)).
postulante(ana,estudia(ingenieria,9,15)).
postulante(juan,estudia(abogacia,8,15)).
postulante(julia,estudia(ingenieria,7,25)).
postulante(franco,estudia(medicina,10,11)).     %EJEMPLOS ADICIONALES PARA PROBAR
postulante(jaime, estudia(medicina,7,11)).      %EJEMPLOS ADICIONALES PARA PROBAR

ocupacion(margarita,amaDeCasa(1)).
ocupacion(mario,trabaja(cadete,30000)).
ocupacion(pedro,estudiante).
ocupacion(ana,trabaja(administrativo,50000)).
ocupacion(juan,trabaja(cadete,35000)).
ocupacion(julia,estudiante).
ocupacion(franco,estudiante).                   %EJEMPLOS ADICIONALES PARA PROBAR
ocupacion(jaime,estudiante).                    %EJEMPLOS ADICIONALES PARA PROBAR

carreraEstrategica(medicina).
carreraEstrategica(ingenieria).
carreraEstrategica(arquitectura).

%punto2
esPostulante(Alumno):- postulante(Alumno,_).

cumpleCondicionBeca(Alumno):- esPostulante(Alumno), ocupacion(Alumno,Ocupacion),
                            cumpleCondicionesCarrera(Alumno), 
                            verificaOcupacion(Ocupacion).
cumpleCondicionesCarrera(Alumno):-postulante(Alumno,estudia(_,Promedio,Aprobadas)),Promedio>=8,Aprobadas>=10.

verificaOcupacion(amaDeCasa(_)).
verificaOcupacion(trabaja(_,Sueldo)):- Sueldo <60000.
verificaOcupacion(estudiante).

%punto3
unSoloPostulante(Carrera):- esCarrera(Carrera),cantidadAlumnosBecados(Carrera,Cantidad), Cantidad == 1.

cantidadAlumnosBecados(Carrera,Cantidad):-findall(Alumno,(postulante(Alumno,estudia(Carrera,_,_)),cumpleCondicionBeca(Alumno)),ListaAlumnos),length(ListaAlumnos, Cantidad).


%punto4
esCarrera(Carrera):-postulante(_,estudia(Carrera,_,_)).
carrerasConAltaDemanda(Carrera):- esCarrera(Carrera), cantidadAlumnosBecados(Carrera,Cantidad), carreraEstrategica(Carrera),
                                forall((esCarrera(OtraCarrera),carreraEstrategica(OtraCarrera), cantidadAlumnosBecados(OtraCarrera,OtraCantidad), OtraCarrera\=Carrera), Cantidad>OtraCantidad).

%punto5
todosTienenBeca(Carrera):- esCarrera(Carrera), carreraEstrategica(Carrera), forall(postulante(Alumno,estudia(Carrera,_,_)), cumpleCondicionBeca(Alumno)).

%punto6
conoceA(margarita,juan).
conoceA(juan,pedro).
conoceA(pedro,ana).
conoceA(pedro,mario).
conoceA(ana,julia).
conoceA(mario,franco).      %EJEMPLOS ADICIONALES PARA PROBAR

conoceAAlguienQueAplique(Postulante1,Postulante2):- esPostulante(Postulante1),esPostulante(Postulante2),cumpleCondiciones(Postulante1,Postulante2).

cumpleCondiciones(Postulante1,Postulante2):-not(cumpleCondicionBeca(Postulante1)),conoceA(Postulante1,Postulante2),cumpleCondicionBeca(Postulante2).
cumpleCondiciones(Postulante1,Postulante2):-not(cumpleCondicionBeca(Postulante1)), conoceA(Postulante1,Intermediario), cumpleCondiciones(Intermediario,Postulante2).