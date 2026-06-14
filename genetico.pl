% Objetivo: dado el pool completo de usuarios, encontrar la
% asignacion de parejas que maximiza la compatibilidad global.
% Inspirado en The One (Netflix, 2021).


%para quitar los wrnings por itercambiar las clausulas de perfil_nombre/2
:- discontiguous perfil_nombre/2.
:- discontiguous perfil_caracteristicas/2.
:- discontiguous perfil_preferencia/2.

:- consult('perfiles.pl').     
:- consult('compatibilidad.pl'). 
:- consult('opciones.pl').

% parametros del algoritmo genetico
ag_poblacion(50).
ag_generaciones(100).
ag_mutacion(0.3).


% donde empieza. Agarra todos los perfiles, limpia el pool,
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


% lista de CIs de todos los usuarios del sistema
todos_los_usuarios(Lista) :-
    findall(CI, perfil_preferencia(CI, _), Lista).

% Elimina del pool a quienes no tienen ningun candidato valido
% usa limpiar_pool_aux para revisar cada CI contra todos los demas.
limpiar_pool(Pool, PoolFinal, Excluidos) :-
    limpiar_pool_aux(Pool, Pool, PoolFinal, Excluidos).

limpiar_pool_aux([], _, [], []).
limpiar_pool_aux([CI|Resto], Todos, Pool, Excluidos) :-
    select(CI, Todos, Otros),
    ( tiene_candidato_valido(CI, Otros)
    -> limpiar_pool_aux(Resto, Todos, PoolResto, ExcluidosResto),
       Pool = [CI|PoolResto],
       Excluidos = ExcluidosResto
    ;  limpiar_pool_aux(Resto, Todos, PoolResto, ExcluidosResto),
       Pool = PoolResto,
       Excluidos = [CI|ExcluidosResto]
    ).

% Verdadero si existe al menos un CI en Otros con quien
% CI pasa todos los filtros mutuamente.
tiene_candidato_valido(CI, Otros) :-
    member(Otro, Otros),
    filtros_mutuos_ok(CI, Otro),
    !.

% Verdadero si CI1 y CI2 pasan los filtros excluyentes mutuamente.
filtros_mutuos_ok(CI1, CI2) :-
    pasa_filtros(CI1, CI2),  %estan en compatibilidad
    pasa_filtros(CI2, CI1).


% AJUSTAR SI EL POOL ES IMPAR

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

% Suma la compatibilidad mutua de CI con todos los candidatos que pasan los filtros excluyentes 
% (sexo, fuma, toma, estado, civil y signo) en el pool, excluyendose a si mismo.
suma_compat_global(CI, Pool, Suma) :-
    findall(M,
            (   member(Otro, Pool),
                Otro \= CI,
                filtros_mutuos_ok(CI, Otro),
                compat_mutua(CI, Otro, M)
            ),
            Mutuas),
    sumlist(Mutuas, Suma).

% ida + vuelta, porque compatible es asimetrico.
compat_mutua(A, B, M) :-
    ( compatible(A, B, Ida) -> true ; Ida = 0 ),
    ( compatible(B, A, Vuelta) -> true ; Vuelta = 0 ),
    M is Ida + Vuelta.


% ALGORITMO GENETICO

% Genera la poblacion inicial, evoluciona y devuelve la mejor
% asignacion encontrada.
correr_genetico(Pool, Mejor) :-
    ag_poblacion(TamPob),
    poblacion_inicial(TamPob, Pool, Pob),
    ag_generaciones(NumGen),
    evolucionar(NumGen, Pob, Mejor).

% Genera N cromosomas aleatorios. 
poblacion_inicial(0, _, []) :- !.
poblacion_inicial(N, Pool, [Ind|Resto]) :-
    N > 0,
    asignacion_aleatoria(Pool, Ind),
    N1 is N - 1,
    poblacion_inicial(N1, Pool, Resto).

% Genera una asignacion aleatoria valida: mezcla el pool al azar
% y arma parejas que pasen los filtros excluyentes mutuamente.
asignacion_aleatoria(Pool, Asignacion) :-
    random_permutation(Pool, Mezclado),
    armar_pares_validos(Mezclado, Asignacion).

% Recorre la lista y para cada persona busca la primera pareja
% disponible que pase los filtros mutuos. Si no encuentra pareja
% valida para alguien, lo saltea y sigue con el resto.
armar_pares_validos([], []).
armar_pares_validos([CI|Resto], [(CI, Pareja)|Pares]) :-
    member(Pareja, Resto),
    filtros_mutuos_ok(CI, Pareja), !,
    select(Pareja, Resto, RestoSinPareja),
    armar_pares_validos(RestoSinPareja, Pares).
armar_pares_validos([_|Resto], Pares) :-
    armar_pares_validos(Resto, Pares).


% Toma la lista de a dos y forma parejas.
armar_pares([], []).
armar_pares([A, B | Resto], [(A, B) | OtrosPares]) :-
    armar_pares(Resto, OtrosPares).


% --- FITNESS ---
% nos dice que tan bueno es un cromosoma, es decir una asignacion

%  suma de compatibilidad mutua de todos sus pares. Cuanto mayor, mejor.
fitness(Asignacion, F) :-
    fitness_acum(Asignacion, 0, F).

% Recorre los pares de la asignacion sumando la compatibilidad
% mutua de cada uno usando un acumulador.
fitness_acum([], F, F).
fitness_acum([(A, B) | Resto], Acum, F) :-
    compat_mutua(A, B, M),
    NuevoAcum is Acum + M,
    fitness_acum(Resto, NuevoAcum, F).


% EVOLUCION 

% Evoluciona la poblacion por N generaciones
evolucionar(0, Pob, Mejor) :- !, mejor_de(Pob, Mejor).
evolucionar(N, Pob, Mejor) :-
    N > 0,
    nueva_generacion(Pob, Nueva),
    N1 is N - 1,
    evolucionar(N1, Nueva, Mejor).

%Genera una nueva poblacion del mismo tamaño. El mejor individuo de la generacion actual pasa 
% directo y el resto se genera combinando y mutando individuos seleccionados.
nueva_generacion(Pob, Nueva) :-
    length(Pob, Tam),
    mejor_de(Pob, Elite),           % elitismo: el mejor pasa directo
    Hijos is Tam - 1,
    generar_hijos(Hijos, Pob, ListaHijos),
    Nueva = [Elite | ListaHijos].

% Genera N hijos nuevos. Cada hijo se obtiene seleccionando
% dos individuos por torneo, cruzandolos y mutando el resultado.
generar_hijos(0, _, []) :- !.
generar_hijos(N, Pob, [Hijo | Resto]) :-
    N > 0,
    seleccion(Pob, P1),
    seleccion(Pob, P2),
    cruzar(P1, P2, Crudo),
    mutar(Crudo, Hijo),
    N1 is N - 1,
    generar_hijos(N1, Pob, Resto).


% SELECCION POR TORNEO ---

% Elige dos individuos al azar y devuelve el de mayor fitness.
seleccion(Pob, Ganador) :-
    random_member(A, Pob),
    random_member(B, Pob),
    fitness(A, FA),
    fitness(B, FB),
    ( FA >= FB -> Ganador = A ; Ganador = B ).


% CRUCE 

% Toma la primera mitad de P1 y completa con los pares de P2 que no repitan a nadie
cruzar(P1, P2, Hijo) :-
    length(P1, Largo),
    Mitad is Largo // 2,
    primeros_n(Mitad, P1, Frente),
    personas_en(Frente, YaUsadas),
    completar_pares(P2, YaUsadas, Resto),
    append(Frente, Resto, Hijo).

% Saca todas las personas que ya estan en una lista de pares
personas_en([], []).
personas_en([(A, B) | Resto], [A, B | Personas]) :-
    personas_en(Resto, Personas).

% Recorre P2 y agrega los pares donde ninguno de los dos esta ya en YaUsadas
completar_pares([], _, []).
completar_pares([(A, B) | Resto], YaUsadas, Pares) :-
    ( \+ member(A, YaUsadas), \+ member(B, YaUsadas)
    -> Pares = [(A, B) | OtrosPares],
       completar_pares(Resto, [A, B | YaUsadas], OtrosPares)
    ;  completar_pares(Resto, YaUsadas, Pares)
    ).


% MUTACION

% Con probabilidad ag_mutacion, intercambia dos personas
% entre dos pares distintos al azar.
mutar(Ind, Mut) :-
    ag_mutacion(Prob),
    random(R),
    ( R < Prob -> mutar_swap(Ind, Mut) ; Mut = Ind ).


% Elige dos pares al azar e intercambia un integrante de cada uno.
mutar_swap(Ind, Mut) :-
    length(Ind, Largo),
    ( Largo >= 2
    -> Max is Largo - 1,
       random_between(0, Max, I),
       random_between(0, Max, J),
       ( I =:= J          % si caen iguales, no mutamos
       -> Mut = Ind
       ;  nth0(I, Ind, (A1, B1)),
          nth0(J, Ind, (A2, B2)),
          ( filtros_mutuos_ok(A1, B2), filtros_mutuos_ok(A2, B1)
          -> reemplazar(Ind, I, (A1, B2), Tmp),
             reemplazar(Tmp, J, (A2, B1), Mut)
          ;  Mut = Ind
          )
       )
    ;  Mut = Ind
    ).


% AUXILIARES

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


% REPORTES

reportar_excluidos([]).
reportar_excluidos([CI | Resto]) :-
    perfil_nombre(CI, Nombre),
    format("~w no tiene candidatos validos, queda fuera del sistema.~n", [Nombre]),
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