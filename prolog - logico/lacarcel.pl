
% guardia(Nombre)
guardia(bennett).
guardia(mendez).
guardia(george).

% prisionero(Nombre, Crimen)
prisionero(piper, narcotráfico([metanfetaminas])).
prisionero(alex, narcotráfico([heroína])).
prisionero(alex, homicidio(george)).
prisionero(red, homicidio(rusoMafioso)).
prisionero(suzanne, robo(450000)).
prisionero(suzanne, robo(250000)).
prisionero(suzanne, robo(2500)).
prisionero(dayanara, narcotráfico([heroína, opio])).
prisionero(dayanara, narcotráfico([metanfetaminas])).

% 1 controla(Controlar, Controlado)
controla(piper, alex).
controla(bennett, dayanara).
% controla(Guardia, Otro):- prisionero(Otro,_), not(controla(Otro, Guardia)).

% no es inversible ya que no cuenta con el generador para Guardia
controla(Guardia, Otro):- 
    guardia(Guardia),
    prisionero(Otro,_), not(controla(Otro, Guardia)).

% 2
conflictoDeIntereses(Persona, OtraPersona) :- 
    controla(Persona, Otro),
    controla(OtraPersona, Otro),
    not(controla(Persona, OtraPersona)),
    not(controla(OtraPersona, Persona)),
    Persona \= OtraPersona.

% 3
peligroso2(Preso) :- 
    prisionero(Preso, _),
    forall(prisionero(Preso, Crimen), grave(Crimen)).

grave(homicidio(_)).
grave(narcotráfico(Lista)) :- length(Lista, N), N >= 5.
grave(narcotráfico(Lista)) :- member(metanfetaminas, Lista).

peligroso(Preso) :- prisionero(Preso, homicidio(_)).
peligroso(Preso) :- prisionero(Preso, narcotráfico(Lista)), length(Lista, 5).
peligroso(Preso) :- prisionero(Preso, narcotráfico(Lista)), member(metanfetaminas, Lista).

% 4
ladronDeGuanteBlanco(Preso) :-
    prisionero(Preso, _),
    forall(prisionero(Preso, Crimen), (monto(Crimen, Monto), N > 100000)).

monto(robo(Monto), Monto).

ladronDeGuanteBlanco(Preso) :-
    prisionero(Preso, _),
    forall(prisionero(Preso, robo(Monto)), Monto > 100000).

% 5
condena(Preso) :-
    prisionero(Preso, _), 
    findall(Pena, (prisionero(Preso, Crimen), pena(Crimen, Pena)), Penas),
    sumlist(Penas, Condena).

pena(robo(Monto), Pena) :- Pena is Monto / 10000.
pena(homicidio(Persona), 7) :- guardia(Persona).
pena(homicidio(Persona), 5) :- not(guardia(Persona)).
pena(narcotráfico(Drogas), Anos) :- length(Drogas, Cantidad), Anos is Cantidad * 2.

% 6
capoDiTutiLiCapi(Capo) :-
    prisionero(Capo, _),
    not(controla(_, Capo)),
    forall(persona(Persona),  controlaAll(Capo, Persona)).

persona(Persona) :- prisionero(Persona, _).
persona(Persona) :- guardia(Persona).

controlaAll(Uno, Otro) :- controla(Uno, Otro).
controlaAll(Uno, Otro) :- controla(Uno, Tercero), controlaAll(Tercero, Otro).
