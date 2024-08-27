/*
Nos piden modelar una herramienta para analizar el tablero de un juego de Táctica y Estratégia de Guerra. 
Para eso ya contamos con los siguientes predicados completamente inversibles en nuestra base de conocimiento:
*/

% Se cumple para los jugadores.
jugador(Jugador)
% Ejemplo: jugador(rojo).

% Relaciona un país con el continente en el que está ubicado,
ubicadoEn(Pais, Continente)
% Ejemplo: ubicadoEn(argentina, américaDelSur).

% Relaciona dos jugadores si son aliados.
aliados(UnJugador, OtroJugador)
% Ejemplo: aliados(rojo, amarillo).

% Relaciona un jugador con un país en el que tiene ejércitos.
ocupa(Jugador, País)
% Ejemplo: ocupa(rojo, argentina).

% Relaciona dos países si son limítrofes.
limítrofes(UnPaís, OtroPaís)
% Ejemplo: limítrofes(argentina, brasil).

% Se pide modelar los siguientes predicados, de forma tal que sean completamente inversibles:

% tienePresenciaEn/2: Relaciona un jugador con un continente del cual ocupa, al menos, un país.
tienePresenciaEn(Jugador, Continente) :- ocupa(Jugador, Pais), ubicadoEn(Pais, Continente).

% puedenAtacarse/2: Relaciona dos jugadores si uno ocupa al menos un país limítrofe a algún país ocupado por el otro.
puedenAtacarse(Jugador, OtroJugador) :- 
    ocupa(Jugador, Pais), 
    ocupa(OtroJugador, OtroPais),
    limítrofes(Pais, OtroPais).
%    Jugador \= OtroJugador,
%    Pais \= OtroPais.

% sinTensiones/2: Relaciona dos jugadores que, o bien no pueden atacarse, o son aliados.
sinTensiones(UnJugador, OtroJugador) :- 
    jugador(Jugador),
    jugador(OtroJugador),
    not(puedenAtacarse(UnJugador, OtroJugador)).

sinTensiones(UnJugador, OtroJugador) :- aliados(UnJugador, OtroJugador).

% perdió/1: Se cumple para un jugador que no ocupa ningún país.
perdio(Jugador) :- 
    jugador(Jugador),
    not(ocupa(Jugador, _)).

% controla/2: Relaciona un jugador con un continente si ocupa todos los países del mismo.
controla(Jugador, Continente) :- 
    jugador(Jugador), ubicadoEn(_, Continente),
    forall(ubicadoEn(Pais, Continente), ocupa(Jugador, Pais)).

controla2(Jugador, Continente) :- 
    jugador(Jugador), ubicadoEn(_, Continente),
    not(ubicadoEn(Pais, Continente), not(ocupa(Jugador, Pais))).

% reñido/1: Se cumple para los continentes donde todos los jugadores ocupan algún país.
reñido(Continente) :-
    ubicadoEn(_, Continente),
    forall(jugador(Jugador), (ocupa(Jugador, Pais), ubicadoEn(Pais, Continente))).
%   forall(jugador(Jugador), (tienePresenciaEn(Jugador, Continente))).

% atrincherado/1: Se cumple para los jugadores que ocupan países en un único continente.
atrincherado(Jugador) :-
    jugador(Jugador),
    ubicadoEn(_, Continente),
    forall(ocupa(Jugador, Pais), ubicadoEn(Pais, Continente)).

% puedeConquistar/2: Relaciona un jugador con un continente si no lo controla, pero todos los países del continente 
% que le falta ocupar son limítrofes a alguno que sí ocupa y pertenecen a alguien que no es su aliado.
puedeConquistar(Jugador, Continente) :- 
    jugador(Jugador),
    ubicadoEn(_, Continente),
    not(controla(Jugador, Continente)), 
    forall( (ubicadoEn(Pais, Continente), not(ocupa(Jugador, Pais))), puedeAtacar(Jugador, Pais) ).

puedeAtacar(Jugador, PaisAtacado) :-
    ocupa(Jugador, PaisPropio)
    limítrofes(PaisAtacado, PaisPropio),
    not(aliados(Jugador, Aliado), ocupa(Aliado, PaisAtacado)).