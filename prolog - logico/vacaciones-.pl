% 1
destino(dodain, pehuenia).
destino(dodain, sanMartin).
destino(dodain, esquel).
destino(dodain, sarmiento).
destino(dodain, camarones).
destino(dodain, playasDoradas).
destino(alf, bariloche).
destino(alf, sanMartin).
destino(alf, bolson).
destino(nico, marDelPlata).
destino(vale, calafate).
destino(vale, bolson).
destino(martu, bariloche).
destino(martu, sanMartin).
destino(martu, bolson).
destino(martu, marDelPlata).

% 2
atracciones(esquel, parqueNacional(losAlerces)).
atracciones(esquel, excursion(trochita)).
atracciones(esquel, excursion(trevelin)).
atracciones(pehuenia, cerro(mahuida, 2000)).
atracciones(pehuenia, cuerpoAgua(puedePescar, 14)).
atracciones(pehuenia, cuerpoAgua(puedePescar, 19)).

esCopada(cerro(_, Altura)) :- Altura > 2000.
esCopada(cuerpoAgua(puedePescar, Temp)) :- Temp > 20.
esCopada(playa(Diferencia)) :- Diferencia < 5.
esCopada(excursion(Nombre)) :- length(Nombre, N), N > 7.
esCopada(parqueNacional).

atCopadas(Lugar) :-
    atracciones(Lugar, Atraccion)
    esCopada(Atraccion).

tieneAtraccionesCopadas(Persona) :-
    destino(Persona, Lugar)
    forall(destino(Persona, Lugar), atCopadas(Lugar)).

% 3
noSeCruzan(Persona, OtraPersona) :-
    % generador
   not(seCruzan(Persona, OtraPersona)).

seCruzan(Persona, OtraPersona) :-
    destino(Persona, Lugar),
    destino(OtraPersona, Lugar),
    Persona \= OtraPersona.

% 4
costoVida(sarmiento, 100).
costoVida(esquel, 150).
costoVida(pehuenia, 180).
% ...

gasoleras(Persona) :-
    % generador
    forall(destino(Persona, Lugar), esGasolero(Lugar)).

esGasolero(Lugar) :-
    % generador
    costoVida(Lugar, Monto),
    Monto < 160.

% 5
itinerario()