% ============================================================
% genetico.pl  -  Algoritmo genetico para UM Match
%
% compatibles_de/2 ya encuentra TODOS los compatibles (exacto).
% El genetico optimiza el ORDEN en que se muestran: evoluciona
% permutaciones buscando que adelante queden los de mayor
% compatibilidad MUTUA (ida+vuelta, porque compatible/3 es asimetrico).
%
% Asume cargados: perfiles.pl, opciones.pl, compatibilidad.pl
% ============================================================

ag_poblacion(20).
ag_generaciones(30).
ag_mutacion(0.3).

% --- mejores_compatibles_geneticos(+CI, +Cantidad, -ListaCIs) ---
mejores_compatibles_geneticos(CI, Cantidad, Mejores) :-
    compatibles_de(CI, Compatibles),
    ( Compatibles = []
    -> Mejores = []
    ;  ag_poblacion(TamPob),
       poblacion_inicial(TamPob, Compatibles, Pob),
       ag_generaciones(NumGen),
       evolucionar(NumGen, CI, Pob, Mejor),
       primeros_n(Cantidad, Mejor, Mejores)
    ).

% --- FITNESS: premia que los mas compatibles queden ADELANTE.
% A cada candidato lo multiplico por un peso que decrece con la
% posicion (el 1ro pesa Largo, el 2do Largo-1, ...). Asi una
% ordenacion mejor da mayor fitness y el genetico la prefiere.
fitness(CI, Individuo, F) :-
    length(Individuo, Largo),
    fitness_pos(CI, Individuo, Largo, 0, F).

fitness_pos(_, [], _, F, F).
fitness_pos(CI, [X|Xs], Peso, Acum, F) :-
    compat_mutua(CI, X, M),
    NuevoAcum is Acum + M * Peso,
    Peso1 is Peso - 1,
    fitness_pos(CI, Xs, Peso1, NuevoAcum, F).

compat_mutua(A, B, M) :-
    compatible(A, B, Ida),
    compatible(B, A, Vuelta),
    M is Ida + Vuelta.

% --- POBLACION INICIAL: permutaciones al azar ---
poblacion_inicial(0, _, []) :- !.
poblacion_inicial(N, Base, [Ind|Resto]) :-
    N > 0,
    random_permutation(Base, Ind),
    N1 is N - 1,
    poblacion_inicial(N1, Base, Resto).

% --- EVOLUCION ---
evolucionar(0, CI, Pob, Mejor) :- !, mejor_de(CI, Pob, Mejor).
evolucionar(N, CI, Pob, Mejor) :-
    N > 0,
    nueva_generacion(CI, Pob, Nueva),
    N1 is N - 1,
    evolucionar(N1, CI, Nueva, Mejor).

nueva_generacion(CI, Pob, Nueva) :-
    length(Pob, Tam),
    mejor_de(CI, Pob, Elite),          % elitismo: guardo al mejor
    Hijos is Tam - 1,
    generar_hijos(Hijos, CI, Pob, ListaHijos),
    Nueva = [Elite|ListaHijos].

generar_hijos(0, _, _, []) :- !.
generar_hijos(N, CI, Pob, [Hijo|Resto]) :-
    N > 0,
    seleccion(CI, Pob, P1),
    seleccion(CI, Pob, P2),
    cruzar(P1, P2, Crudo),
    mutar(Crudo, Hijo),
    N1 is N - 1,
    generar_hijos(N1, CI, Pob, Resto).

% --- SELECCION POR TORNEO ---
seleccion(CI, Pob, Ganador) :-
    random_member(A, Pob),
    random_member(B, Pob),
    fitness(CI, A, FA),
    fitness(CI, B, FB),
    ( FA >= FB -> Ganador = A ; Ganador = B ).

% --- CRUCE (order crossover): mitad de P1 + lo que falta segun P2 ---
cruzar(P1, P2, Hijo) :-
    length(P1, Largo),
    Mitad is Largo // 2,
    primeros_n(Mitad, P1, Frente),
    completar(P2, Frente, Resto),
    append(Frente, Resto, Hijo).

completar([], _, []).
completar([X|Xs], Ya, Resto) :-
    ( member(X, Ya)
    -> completar(Xs, Ya, Resto)
    ;  Resto = [X|R1], completar(Xs, Ya, R1)
    ).

% --- MUTACION: con prob. ag_mutacion, swap de dos posiciones ---
mutar(Ind, Mut) :-
    ag_mutacion(Prob),
    random(R),
    ( R < Prob -> intercambio_azar(Ind, Mut) ; Mut = Ind ).

intercambio_azar(Lista, Mut) :-
    length(Lista, Largo),
    ( Largo >= 2
    -> Max is Largo - 1,
       random_between(0, Max, I),
       random_between(0, Max, J),
       intercambiar(Lista, I, J, Mut)
    ;  Mut = Lista
    ).

intercambiar(Lista, I, J, Res) :-
    nth0(I, Lista, Ei),
    nth0(J, Lista, Ej),
    reemplazar(Lista, I, Ej, Tmp),
    reemplazar(Tmp, J, Ei, Res).

reemplazar([_|T], 0, X, [X|T]) :- !.
reemplazar([H|T], N, X, [H|R]) :-
    N > 0, N1 is N - 1, reemplazar(T, N1, X, R).

% --- AUXILIARES ---
mejor_de(CI, [P|Ps], Mejor) :-
    fitness(CI, P, F),
    mejor_de(CI, Ps, P, F, Mejor).
mejor_de(_, [], Mejor, _, Mejor).
mejor_de(CI, [P|Ps], MejorAct, FMejor, Mejor) :-
    fitness(CI, P, F),
    ( F > FMejor
    -> mejor_de(CI, Ps, P, F, Mejor)
    ;  mejor_de(CI, Ps, MejorAct, FMejor, Mejor)
    ).

primeros_n(0, _, []) :- !.
primeros_n(_, [], []) :- !.
primeros_n(N, [X|Xs], [X|Ys]) :-
    N > 0, N1 is N - 1, primeros_n(N1, Xs, Ys).