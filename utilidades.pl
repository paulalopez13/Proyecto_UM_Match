% - - - - - - - - - - - - - - - - - - - - - - - -
%  - - - - - - - - - - - - - - - - - - - - - - - -

  % QUITAR_ELEMENTO - Sacar un elemento en específico

% caso base: lista vacía
quitar_elemento(_, [], []).    % _ para avisarle a prolog que esa variable no la voy a usar a propósito

% caso 2: el elemento que quiero sacar es la cabeza
quitar_elemento(Elemento, [Elemento|T], T) :- !.

  % caso 3 (recursivo): la cabeza NO es el elemento
quitar_elemento(Elemento, [H|T], [H|Resultado]) :-
  quitar_elemento(Elemento, T, Resultado).


% - - - - - - - - - - - - - - - - - - - - - - - -
%  - - - - - - - - - - - - - - - - - - - - - - - -

  % TOP_N - agarrar los primeros N elementos de una lista

% caso base: agarré los que necesitaba
top_n(_, 0, []) :- !.

% caso 2: la lista se vació antes
top_n([], _, []).

% caso 3 (recursivo): agarro la cabeza, resto 1 a N, sigo con el resto
top_n([H|T], N, [H|Restante]) :-
  N > 0,
  N1 is N - 1,
  top_n(T, N1, Restante).


% - - - - - - - - - - - - - - - - - - - - - - - -
%  - - - - - - - - - - - - - - - - - - - - - - - -

%   EN_RANGO - muestra si un valor pertenece a un rango dado

en_rango(Valor, Min, Max) :- 
  Valor >= Min,
  Valor =< Max.


% - - - - - - - - - - - - - - - - - - - - - - - -
%  - - - - - - - - - - - - - - - - - - - - - - - -

  % MOSTRAR_LISTA_CON_SEPARADOR - imprime lista separada por caracter dado

% caso base: lista vacía
mostrar_lista_con_separador([], _).

% caso 2: único elemento lo imprimo solo
mostrar_lista_con_separador([X], _) :-
  write(X), nl.

% caso 3 (recursivo): lista con más de un elemento
mostrar_lista_con_separador([H|T], Separador) :- 
  write(H), write(Separador),
  mostrar_lista_con_separador([T], Separador).


% - - - - - - - - - - - - - - - - - - - - - - - -
%  - - - - - - - - - - - - - - - - - - - - - - - -

  % CAPITALIZAR - convierte la primera letra a mayúscula
capitalizar(Palabra, Capitalizado) :-
  atom_chars(Palabra, [Primera|Resto]),              % separo primera letra del resto
  upcase_atom(Primera, PrimeraMayus),                % paso primera letra a mayúscula
  atom_chars(Capitalizado, [PrimeraMayus|Resto]).    % junto todo de nuevo