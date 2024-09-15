ratas(remy, gusteaus).
ratas(emile, chesMilleBar).
ratas(django, pizzeriaJeSuis).

humanos(linguini, cocina(ratatouille, 3), gusteaus).
humanos(linguini, cocina(sopa, 5), gusteaus).
humanos(colette, cocina(salmon, 9), gusteaus).
humanos(horst, cocina(ensaladaRusa, 8), gusteaus).

% restaurante(gusteaus, cocineros(linguini, colette, skinner))
tutor(remy, linguini).
tutor(amelie, skinner).

menu(restaurante, platos([ensaladaRusa, salmon])).

% 1
platoEstaEnElMenu(Plato, Restaurante) :-
    humanos(_, cocina(Plato, _), Restaurante).

% 2
cocinaBien(Plato, Persona) :-
    humanos(Persona, cocina(Plato,_)_),
    forall(humanos(Persona, cocina(Plato, Exp), _), condicion(Plato, Persona, Exp)).

cocinaBienRata(_, remy).

condicion(Plato, Persona, Exp) :- Exp > 7.
condicion(Plato, Persona, Exp) :- 
    tutor(Tutor, Persona),
    cocinaBienRata(Plato, Tutor).

% 3
chef(Restaurante, Persona) :-
    humanos(Persona, _, Restaurante),
    forall(menu(Restaurante, platos(Platos)), cocinaBien(Platos, Persona)).

chef(Restaurante, Persona) :-
    humanos(Persona, _, Restaurante),
    findall(Plato, humanos(Persona, cocina(Plato, Exp), Restaurante), Platos),
    sumlist(Platos, N),
    N > 20.

% 4
encargada(Plato, Restaurante) :-
    % generador
    forall(humanos(Persona, cocina(Plato, Exp), Restaurante), masExperiencia(Persona, OtraPersona, Exp)).

% masExperiencia(Persona, OtraPersona, Exp)

% 5
plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 20)).
plato(frutillasConCrema, postre(265)).

esSaludable(Plato) :-
    plato(Plato, Tipo),
    saludable(Tipo).

saludable(entrada(Ingredientes)) :-
    sumlist(Ingredientes, N),
    N < 75.

saludable(principal(Guarnicion, Coccion)) :-
    guarnicion(Guarnicion, Cal),
    Calorias is ((Coccion * 5) + Cal).

guarnicion(pure, 20).
guarnicion(papasFritas, 50).

saludable(postre(Calorias)) :-
    Calorias < 75.

% 6
reseñaPositiva(Restaurante, Critico) :-
    not(ratas(Rata, Restaurante))
