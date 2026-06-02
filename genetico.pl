% ============================================================
% genetico_global.pl  -  Algoritmo genetico para UM Match
%
% Objetivo: dado el pool completo de usuarios, encontrar la
% asignacion de parejas que maximiza la compatibilidad global.
% Inspirado en The One (Netflix, 2021).
%
% Asume cargados: perfiles.pl, opciones.pl, compatibilidad.pl
% ============================================================

:- consult(perfiles).
:- consult(compatibilidad).
:- consult(opciones).

% parametros del algoritmo genetico
ag_poblacion(20).
ag_generaciones(50).
ag_mutacion(0.2).


% ============================================================
% PREDICADO PRINCIPAL
% ============================================================

% matching_global(-Asignacion)
%
% Punto de entrada. Agarra todos los perfiles, limpia el pool,
% corre el genetico y muestra el resultado.

matching_global(Asignacion) :-
    todos_los_usuarios(Todos),
    limpiar_pool(Todos, Pool, Excluidos),
    reportar_excluidos(Excluidos),
    ( Pool = []
    -> write('No hay suficientes usuarios para emparejar.'), nl,
       Asignacion = []
    ;  ajustar_pool(Pool, PoolFinal, SinPareja),
       reportar_sin_pareja(SinPareja),
       correr_genetico(PoolFinal, Asignacion),
       reportar_asignacion(Asignacion)
    ).


% ============================================================
% PASO 1: OBTENER TODOS LOS USUARIOS
% ============================================================

% todos_los_usuarios(-Lista)
%
% Junta todos los CI que tienen perfil_preferencia definido.

todos_los_usuarios(Lista) :-
    findall(CI, perfil_preferencia(CI, _), Lista).


% ============================================================
% PASO 2: LIMPIAR EL POOL
% ============================================================

% limpiar_pool(+Todos, -Pool, -Excluidos)
%
% Saca a quienes no tienen ningun candidato valido en sexo.
% Un candidato es valido si el sexo de cada uno coincide con
% lo que el otro busca (compatibilidad mutua de sexo).

limpiar_pool([], [], []).
limpiar_pool([CI|Resto], Pool, Excluidos) :-
    ( tiene_candidato_valido(CI, Resto)  % miro si hay alguien que le sirva en el resto
    -> limpiar_pool(Resto, PoolResto, ExcluidosResto),
       Pool = [CI|PoolResto],
       Excluidos = ExcluidosResto
    ;  limpiar_pool(Resto, PoolResto, ExcluidosResto),
       Pool = PoolResto,
       Excluidos = [CI|ExcluidosResto]
    ).

% tiene_candidato_valido(+CI, +OtrosCIs)
%
% Verdadero si existe alguien en OtrosCIs con quien CI
% tenga compatibilidad mutua de sexo.

tiene_candidato_valido(CI, Otros) :-
    member(Otro, Otros),
    sexo_mutuo_ok(CI, Otro),
    !.  % con uno alcanza

% sexo_mutuo_ok(+CI1, +CI2)
%
% Verdadero si CI1 busca el sexo de CI2 Y CI2 busca el sexo de CI1.

sexo_mutuo_ok(CI1, CI2) :-
    perfil_preferencia(CI1, Prefs1),
    perfil_preferencia(CI2, Prefs2),
    perfil_caracteristicas(CI1, Caract1),
    perfil_caracteristicas(CI2, Caract2),
    member(pref(busca_sexo, SexoBuscado1), Prefs1),
    member(pref(busca_sexo, SexoBuscado2), Prefs2),
    member(sexo(SexoBuscado1), Caract2),  % CI2 tiene el sexo que busca CI1
    member(sexo(SexoBuscado2), Caract1).  % CI1 tiene el sexo que busca CI2


% ============================================================
% PASO 3: AJUSTAR SI EL POOL ES IMPAR
% ============================================================

% ajustar_pool(+Pool, -PoolFinal, -SinPareja)
%
% Si el pool tiene cantidad impar de personas, saca al menos
% compatible globalmente. Si es par, no hace nada.

ajustar_pool(Pool, PoolFinal, SinPareja) :-
    length(Pool, Largo),
    ( Largo mod 2 =:= 1
    -> menos_compatible_global(Pool, Peor),
       delete(Pool, Peor, PoolFinal),
       SinPareja = Peor
    ;  PoolFinal = Pool,
       SinPareja = ninguno
    ).

% menos_compatible_global(+Pool, -CI)
%
% Devuelve el CI cuya suma de compatibilidad mutua con sus
% candidatos validos del pool es la mas baja.

menos_compatible_global([P|Ps], Peor) :-
    suma_compat_global(P, [P|Ps], SP),
    menos_compatible_global(Ps, P, SP, Peor).

menos_compatible_global([], PeorAct, _, PeorAct).
menos_compatible_global([P|Ps], PeorAct, SPeor, Peor) :-
    suma_compat_global(P, [P|Ps], SP),
    ( SP < SPeor
    -> menos_compatible_global(Ps, P, SP, Peor)
    ;  menos_compatible_global(Ps, PeorAct, SPeor, Peor)
    ).

% suma_compat_global(+CI, +Pool, -Suma)
%
% Suma la compatibilidad mutua de CI con todos los candidatos
% validos en sexo que hay en el pool (excluyendose a si mismo).

suma_compat_global(CI, Pool, Suma) :-
    findall(M,
            (   member(Otro, Pool),
                Otro \= CI,
                sexo_mutuo_ok(CI, Otro),
                compat_mutua(CI, Otro, M)
            ),
            Mutuas),
    sumlist(Mutuas, Suma).

% compat_mutua(+CI1, +CI2, -M)
%
% Compatibilidad ida + vuelta, porque compatible/3 es asimetrico.

compat_mutua(A, B, M) :-
    compatible(A, B, Ida),
    compatible(B, A, Vuelta),
    M is Ida + Vuelta.


% ============================================================
% ALGORITMO GENETICO
% ============================================================

% correr_genetico(+Pool, -MejorAsignacion)
%
% Genera la poblacion inicial, evoluciona y devuelve la mejor
% asignacion encontrada.

correr_genetico(Pool, Mejor) :-
    ag_poblacion(TamPob),
    poblacion_inicial(TamPob, Pool, Pob),
    ag_generaciones(NumGen),
    evolucionar(NumGen, Pob, Mejor).

% poblacion_inicial(+N, +Pool, -Poblacion)
%
% Genera N cromosomas aleatorios. Cada cromosoma es una
% asignacion completa: una lista de pares (A, B).

poblacion_inicial(0, _, []) :- !.
poblacion_inicial(N, Pool, [Ind|Resto]) :-
    N > 0,
    asignacion_aleatoria(Pool, Ind),
    N1 is N - 1,
    poblacion_inicial(N1, Pool, Resto).

% asignacion_aleatoria(+Pool, -Asignacion)
%
% Mezcla el pool al azar y arma pares de a dos.

asignacion_aleatoria(Pool, Asignacion) :-
    random_permutation(Pool, Mezclado),
    armar_pares(Mezclado, Asignacion).

% armar_pares(+Lista, -Pares)
%
% Toma la lista de a dos y forma parejas.
% Caso base: lista vacia, no quedan pares.

armar_pares([], []).
armar_pares([A, B | Resto], [(A, B) | OtrosPares]) :-
    armar_pares(Resto, OtrosPares).


% --- FITNESS ---

% fitness(+Asignacion, -F)
%
% El fitness de una asignacion es la suma de compatibilidad
% mutua de todos sus pares. Cuanto mayor, mejor.

fitness(Asignacion, F) :-
    fitness_acum(Asignacion, 0, F).

fitness_acum([], F, F).
fitness_acum([(A, B) | Resto], Acum, F) :-
    compat_mutua(A, B, M),
    NuevoAcum is Acum + M,
    fitness_acum(Resto, NuevoAcum, F).


% --- EVOLUCION ---

evolucionar(0, Pob, Mejor) :- !, mejor_de(Pob, Mejor).
evolucionar(N, Pob, Mejor) :-
    N > 0,
    nueva_generacion(Pob, Nueva),
    N1 is N - 1,
    evolucionar(N1, Nueva, Mejor).

nueva_generacion(Pob, Nueva) :-
    length(Pob, Tam),
    mejor_de(Pob, Elite),           % elitismo: el mejor pasa directo
    Hijos is Tam - 1,
    generar_hijos(Hijos, Pob, ListaHijos),
    Nueva = [Elite | ListaHijos].

generar_hijos(0, _, []) :- !.
generar_hijos(N, Pob, [Hijo | Resto]) :-
    N > 0,
    seleccion(Pob, P1),
    seleccion(Pob, P2),
    cruzar(P1, P2, Crudo),
    mutar(Crudo, Hijo),
    N1 is N - 1,
    generar_hijos(N1, Pob, Resto).


% --- SELECCION POR TORNEO ---

% seleccion(+Pob, -Ganador)
%
% Elige dos individuos al azar y devuelve el de mayor fitness.

seleccion(Pob, Ganador) :-
    random_member(A, Pob),
    random_member(B, Pob),
    fitness(A, FA),
    fitness(B, FB),
    ( FA >= FB -> Ganador = A ; Ganador = B ).


% --- CRUCE ---

% cruzar(+P1, +P2, -Hijo)
%
% Toma la primera mitad de P1 y completa con los pares de P2
% que no repitan a nadie. Asi el hijo no tiene personas duplicadas.

cruzar(P1, P2, Hijo) :-
    length(P1, Largo),
    Mitad is Largo // 2,
    primeros_n(Mitad, P1, Frente),
    personas_en(Frente, YaUsadas),
    completar_pares(P2, YaUsadas, Resto),
    append(Frente, Resto, Hijo).

% personas_en(+Pares, -Personas)
%
% Saca todas las personas que ya estan en una lista de pares.

personas_en([], []).
personas_en([(A, B) | Resto], [A, B | Personas]) :-
    personas_en(Resto, Personas).

% completar_pares(+P2, +YaUsadas, -Resto)
%
% Recorre P2 y agrega los pares donde ninguno de los dos
% esta ya en YaUsadas.

completar_pares([], _, []).
completar_pares([(A, B) | Resto], YaUsadas, Pares) :-
    ( \+ member(A, YaUsadas), \+ member(B, YaUsadas)
    -> Pares = [(A, B) | OtrosPares],
       completar_pares(Resto, [A, B | YaUsadas], OtrosPares)
    ;  completar_pares(Resto, YaUsadas, Pares)
    ).


% --- MUTACION ---

% mutar(+Ind, -Mut)
%
% Con probabilidad ag_mutacion, intercambia dos personas
% entre dos pares distintos al azar.

mutar(Ind, Mut) :-
    ag_mutacion(Prob),
    random(R),
    ( R < Prob -> mutar_swap(Ind, Mut) ; Mut = Ind ).

% mutar_swap(+Ind, -Mut)
%
% Elige dos pares al azar e intercambia un integrante de cada uno.
% Por ejemplo (ana, beto) y (caro, diego) pueden dar
% (ana, diego) y (caro, beto).

mutar_swap(Ind, Mut) :-
    length(Ind, Largo),
    ( Largo >= 2
    -> Max is Largo - 1,
       random_between(0, Max, I),
       random_between(0, Max, J),
       I \= J,
       nth0(I, Ind, (A1, B1)),
       nth0(J, Ind, (A2, B2)),
       reemplazar(Ind, I, (A1, B2), Tmp),  % intercambio un integrante
       reemplazar(Tmp, J, (A2, B1), Mut)
    ;  Mut = Ind
    ).


% ============================================================
% AUXILIARES
% ============================================================

mejor_de([P | Ps], Mejor) :-
    fitness(P, F),
    mejor_de(Ps, P, F, Mejor).

mejor_de([], Mejor, _, Mejor).
mejor_de([P | Ps], MejorAct, FMejor, Mejor) :-
    fitness(P, F),
    ( F > FMejor
    -> mejor_de(Ps, P, F, Mejor)
    ;  mejor_de(Ps, MejorAct, FMejor, Mejor)
    ).

primeros_n(0, _, []) :- !.
primeros_n(_, [], []) :- !.
primeros_n(N, [X | Xs], [X | Ys]) :-
    N > 0, N1 is N - 1, primeros_n(N1, Xs, Ys).

reemplazar([_ | T], 0, X, [X | T]) :- !.
reemplazar([H | T], N, X, [H | R]) :-
    N > 0, N1 is N - 1, reemplazar(T, N1, X, R).


% ============================================================
% REPORTES
% ============================================================

reportar_excluidos([]).
reportar_excluidos([CI | Resto]) :-
    perfil_nombre(CI, Nombre),
    format("~w no tiene candidatos validos en sexo, queda fuera del sistema.~n", [Nombre]),
    reportar_excluidos(Resto).

reportar_sin_pareja(ninguno) :- !.
reportar_sin_pareja(CI) :-
    perfil_nombre(CI, Nombre),
    format("El pool es impar. ~w es el menos compatible globalmente y queda sin emparejar.~n", [Nombre]).

reportar_asignacion([]) :-
    write('--- Fin del matching ---'), nl.
reportar_asignacion([(A, B) | Resto]) :-
    perfil_nombre(A, NomA),
    perfil_nombre(B, NomB),
    compat_mutua(A, B, M),
    format("~w  <-->  ~w   (compatibilidad mutua: ~w)~n", [NomA, NomB, M]),
    reportar_asignacion(Resto).