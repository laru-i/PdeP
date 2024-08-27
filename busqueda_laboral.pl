contador(roque).
joven(roque).
trabajoEn(roque,acme).
trabajoEn(ana,omni).
trabajoEn(lucia,omni).
honesto(roque).
ingeniero(ana).
habla(roque,frances).
habla(ana,ingles).
habla(ana,frances).
habla(lucia,ingles).
habla(lucia,frances).
habla(cecilia,frances).
abogado(cecilia).
ambicioso(cecilia).

ambicioso(Persona) :- contador(Persona), joven(Persona).
tieneExperiencia(Persona) :- trabajoEn(Persona,_).
profesional(Persona) :- contador(Persona).
profesional(Persona) :- abogado(Persona).
profesional(Persona) :- ingeniero(Persona).

% 1
puedeAndar(comercioExterior, Persona) :- ambicioso(Persona).
puedeAndar(contaduria, Persona) :- honesto(Persona).
puedeAndar(ventas, Persona) :- ambicioso(Persona), tieneExperiencia(Persona).
puedeAndar(ventas, lucia).

% 2
puedeAndar(proyectos, Persona) :- ingeniero(Persona), tieneExperiencia(Persona).
puedeAndar(proyectos, Persona) :- abogado(Persona), joven(Persona).
puedeAndar(logistica, Persona) :- profesional(Persona), cumpleCondiciones. 
cumpleCondiciones(Persona) :- joven(Persona).
cumpleCondiciones(Persona) :- trabajoEn(Persona, omni).

% 3
ingeniero(julia).
trabajoEn(julia, acme).

ambicioso(pepe).
trabajoEn(pepe, fiat).

% --------------------------------------
% Relaciones Familiares

madre(mona, homero).
madre(jaqueline, marge).
madre(marge, maggie).
madre(marge, bart).
madre(marge, lisa).
padre(abraham, herbert).
padre(abraham, homero).
padre(clancy, jaqueline).
padre(homero, maggie).
padre(homero, bart).
padre(homero, lisa).

% 1
% hermano(Uno, Otro) :- madre(Madre, Uno), madre(Madre, Otro), padre(Padre, Uno), padre(Padre, Otro), Uno \= Otro.
hermano(Uno, Otro) :- mismaMadre(Uno, Otro), mismoPadre(Uno, Otro), Uno \= Otro.

mismaMadre(Uno, Otro) :- madre(Madre, Uno), madre(Madre, Otro), Uno \= Otro.
mismoPadre(Uno, Otro) :- padre(Padre, Uno), padre(Padre, Otro), Uno \= Otro.

% 2
medioHermano(Uno, Otro) :- madre(Madre, Uno), madre(Madre, Otro), not(padre(Padre, Uno), padre(Padre, Otro).), Uno \= Otro.
medioHermano(Uno, Otro) :- padre(Padre, Uno), padre(Padre, Otro), Uno \= Otro.

% 3
hijoUnico(Uno) :- not(hermano(Uno, _)), not(medioHermano(Uno,_)).

% 4
% tio(Uno, Otro) :- 

% -------------------------------------
% Medios de Transporte

transporte(juan, camina).
transporte(marcela, subte(a)).
transporte(pepe, colectivo(160,d)).
transporte(elena, colectivo(76)).
transporte(maria, auto(500, fiat, 2014)).
transporte(ana, auto(fiesta, ford, 2020)).
transporte(roberto, auto(qubo, fiat, 2015)).
manejaLento(manuel).
manejaLento(ana).


% 1) Realizar las consultas que permita conocer quiénes son los que vienen en auto de marca fiat.
autoFiat(Persona) :- transporte(Persona, auto(_, fiat, _)).

% 2) Definir tardaMucho/1, se verifica si la persona viene caminando o viene en auto y maneja lento. ( debe ser totalmente inversible).
tardaMucho(Persona) :- transporte(Persona, camina).
tardaMucho(Persona) :- transporte(Persona, auto(_,_,_)), manejaLento(Persona).

% 3) ¿ Quiénes son las personas que viajan en colectivo?.
colectivo(Persona) :- transporte(Persona, colectivo(_, _)).
colectivo(Persona) :- transporte(Persona, colectivo(_)).