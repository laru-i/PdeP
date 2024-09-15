
tareas(dani, tomarExamen(logico, aula522), fecha(10, 08, 2023)).
tareas(dani, meterGol(primeraDivision), fecha(10, 08, 2023)).
tareas(alf, discurso(utn, 0), fecha(11, 08, 2023)).

nacimiento(dani, buenosAires).
nacimiento(alf, buenosAires).
nacimiento(nico, buenosAires).

%% quedaEn(lugar, lugar)
quedaEn(venezuela, america).
quedaEn(argentina, america).
quedaEn(patagonia, argentina).
quedaEn(aula522, utn). % Sí, un aula es un lugar!
quedaEn(utn, buenosAires).
quedaEn(buenosAires, argentina).

temasComplejos([aa, bb, cc]).
lugarTorneo(primeraDivision, buenosAires).

% 1
dulceHogar(Persona) :-
    nacimiento(Persona, LugarNacimiento),
    forall(tareaEnLugar(Persona, _, Lugar), mismoLugar(Lugar, LugarNacimiento)).
%    forall(tareas(Persona, Tareas, _), lugar(Tareas, LugarNacimiento)).

mismoLugar(Lugar, Lugar).

tareaEnLugar(Persona, Tarea, Lugar) :-
    tareas(Persona, Tarea, _),
    lugar(Tarea, Lugar).

lugar(tomarExamen(_, Lugar), Lugar).
lugar(meterGol(Torneo), Lugar) :- lugarTorneo(Torneo, Lugar).
lugar(discurso(Lugar, _), Lugar).

% con not
dulceHogar(Persona) :-
    nacimiento(Persona, LugarNacimiento),
    not((tareaEnLugar(Persona, _, Lugar), not(mismoLugar(Lugar, LugarNacimiento)))).

% 2
estresNacional(Tarea) :- 
    %tareas(_, Tarea, _),
    %lugar(Tarea, Lugar),
    tareaEnLugar(_, Tarea, Lugar)
    pertenece(Lugar, argentina),
    tareasEstres(Tarea).

pertenece(Lugar, OtroLugar) :- quedaEn(Lugar, OtroLugar).
pertenece(Lugar, OtroLugar) :- 
    quedaEn(Lugar, Lugar2),
    pertenece(Lugar2, OtroLugar).

tareasEstres(discurso(_, Personas)) :- Personas > 30000.
%tareasEstres(tomarExamen(Tema, _)) :- member(Tema, temasComplejos(Temas)).
tareasEstres(tomarExamen(Tema, _)) :- temaComplejo(Tema).
tareasEstres(meterGol(Torneo)) :- 
    lugarTorneo(Torneo, Lugar)
    pertenece(Lugar, argentina).

temaComplejo(logico).

% 3
alterados(Persona, Tipo) :-
    trabajador(Persona),
    tipo(Persona, Tipo).

trabajador(Persona) :-
    tareas(Persona, _. _).

tipo(Persona, zen) :- 
    forall(tareas(Persona, Tarea, _), not(estresNacional(Tarea))).

tipo(Persona, locos) :- 
    forall(tareas(Persona, Tarea, fecha(_,_,2023)), estresNacional(Tarea)).
    
tipo(Persona, sabios) :- 
    realizoTareaEstresante(Persona, Tarea),
    not((realizoTareaEstresante(Persona, OtraTarea), OtraTarea \= Tarea)).

realizoTareaEstresante(Persona, Tarea) :-
    tareas(Persona, Tarea, _),
    estresNacional(Tarea).

% 4
elMasChapita(Persona) :-
    /*findall(Tarea, tareas(Persona, Tarea, _), Tareas),
    findall(TareaDos, tareas(OtraPersona, TareaDos, _), TareasDos),
    length(Tareas, Uno),
    length(TareasDos, Dos),
    Uno > Dos,
    Persona \= OtraPersona.*/
    cantidad(Persona, Max),
    forall(cantidad(_, OtraCnt), Max >= OtraCnt).

cantidad(Persona, Max) :-
    % generador
    findall(Tarea, realizoTareaEstresante(Persona, Tarea, _), Tareas),
    length(Tareas, Max).

% 5
/*
- 1
lugar, xq relaciona una tarea con un lugar, xq espera tipos diferentes y descompone según lo que necesite.
idem tareasEstres.

- 2
ambos son completamente inversibles, es necesario que lo sean, xq sino solo se pueden hacer consultas individuales, 
así se permite que se hagan existenciales

*/