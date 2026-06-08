
:- consult('perfiles.pl').
:- consult('logica.pl').


:- dynamic(like/2).   
:- dynamic(match/2).   

% Registra que CI1 le dio like a CI2.
% Si CI2 ya le habia dado like a CI1, se crea match automatico.

% No se puede dar like si la cedula no existe (error).
% No se puede dar like a uno mismo.
% No se puede dar like dos veces a la misma persona.
% El match se crea automaticamente si hay like mutuo.

% Caso 1: alguna cedula no existe. Error
dar_like(CI1, _) :-
    \+ existe_perfil(CI1),
    % \+ negacion
    !,
    %! que si ya pasa eso, no siga probando otra alternativa.
    format('ERROR: el perfil ~w no existe.~n', [CI1]),
    fail.

dar_like(_, CI2) :-
    \+ existe_perfil(CI2),
    !,
    format('ERROR: el perfil ~w no existe.~n', [CI2]),
    fail.

% Caso 2: like a uno mismo. No permitido
dar_like(CI, CI) :-
    !,
    write('ERROR: no se puede dar like a uno mismo.'), nl,
    fail.

% Caso 3: ya le habia dado like. Ignorar silenciosamente
dar_like(CI1, CI2) :-
    like(CI1, CI2),
    !.

% Caso 4: like nuevo y valido. Registrar y verificar match.
dar_like(CI1, CI2) :-
    assertz(like(CI1, CI2)),
    verificar_match(CI1, CI2).

% Si hay like mutuo y aun no son match, crear el match.
% Si no, no hace nada
verificar_match(CI1, CI2) :-
    like(CI2, CI1),
    \+ son_match(CI1, CI2),
    !,
    assertz(match(CI1, CI2)).
    %agrego un hecho a la base de datos. es decir, crea el match.
verificar_match(_, _). 

% True si CI1 y CI2 tienen match, sin importar el orden.
son_match(CI1, CI2) :-
    match(CI1, CI2).
son_match(CI1, CI2) :-
    match(CI2, CI1).

% Devuelve la lista de todas las cedulas que tienen match con CI.
matches_de(CI, Lista) :-
    findall(Otro, son_match(CI, Otro), Lista).
    %finall(que queres guardar, condicion, resultado final q devuelve el findall.)

% Devuelve la lista de cedulas a las que CI le dio like.
likes_dados_por(CI, Lista) :-
    findall(Otro, like(CI, Otro), Lista).

% Devuelve la lista de cedulas que le dieron like a CI.
likes_recibidos_por(CI, Lista) :-
    findall(Otro, like(Otro, CI), Lista).

% Borra el like de CI1 a CI2.
% Si habia match entre ellos, tambien lo borra
quitar_like(CI1, CI2) :-
    retractall(like(CI1, CI2)),
    retractall(match(CI1, CI2)),
    retractall(match(CI2, CI1)). 