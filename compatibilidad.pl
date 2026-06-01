% Modulo de calculo de compatibilidad 

:- consult(perfiles).
:- consult(compatibilidad).
:- consult(opciones).


% coincide(+Preferencia, +Caracteristicas, -NombreAtributo)
%
% Verdadero si la caracteristica del otro perfil cumple la
% preferencia. si coincide, devuelve el nombre del atributo
%
%   pref(Atributo, Valor):
%   (comparacion por igualdad -> atributos categoricos)
%
%   pref_rango(Atributo, Min, Max):
%   (atributos numericos: edad, altura)


coincide(pref(Atributo, Valor), Caracteristicas, Atributo) :-
    Buscado =.. [Atributo, Valor], % construye dinamicamente 
    member(Buscado, Caracteristicas). % miro la lista de caracteristicas hasta haya algo con el nombre del atributo

coincide(pref_rango(Atributo, Min, Max), Caracteristicas, Atributo) :-
    Buscado =.. [Atributo, ValorOtro], 
    member(Buscado, Caracteristicas),
    ValorOtro >= Min,
    ValorOtro =< Max.

% compatible(+CI_usuario, +CI_otro, -Puntaje)
%
% Calcula el puntaje que CI_otro obtiene segun las
% preferencias de CI_usuario, sumando atributo por atributo

compatible(CI_usuario, CI_otro, Puntaje) :-
    perfil_preferencia(CI_usuario, Preferencias),
    perfil_caracteristicas(CI_otro, Caracteristicas),
    sumar_puntaje(Preferencias, Caracteristicas, 0, Puntaje).

% sumar_puntaje(+Preferencias, +Caracteristicas, +Acumulado, -Total)
% Recorre las preferencias de a una, usamos recursion con acumulador
% Si la preferencia coincide, suma el peso de ese atributo;
% si no coincide, deja el acumulado igual.

sumar_puntaje([], _, Total, Total). % cuando ya no quedan preferencias termino 
% el acumulado pasa a ser el total y lo que queda en caracteristicas, no me importa 

sumar_puntaje([Pref|Resto], Caracteristicas, Acumulado, Total) :-
    (   coincide(Pref, Caracteristicas, Atributo),
        peso(Atributo, Peso)
    ->  NuevoAcumulado is Acumulado + Peso
    ;   NuevoAcumulado is Acumulado
    ),
    sumar_puntaje(Resto, Caracteristicas, NuevoAcumulado, Total).


% puntaje_de(+CI1, +CI2, -Puntaje)
% Abreviatura de compatible/3 (mismo resultado).

puntaje_de(CI1, CI2, Puntaje) :-
    compatible(CI1, CI2, Puntaje).


% es_compatible(+CI1, +CI2)
% Verdadero si el puntaje alcanza o supera el umbral.
% umbral/1 esta definido en opciones.pl (ej: umbral(13.2)).
% ------------------------------------------------------------
es_compatible(CI1, CI2) :-
    compatible(CI1, CI2, Puntaje),
    umbral_puntaje(Umbral), 
    Puntaje >= Umbral.


% ------------------------------------------------------------
% por_que_compatible(+CI1, +CI2, -ListaAtributos)
%
% Devuelve la lista de atributos en los que CI2 cumple las
% preferencias de CI1

por_que_compatible(CI1, CI2, Atributos) :-
    perfil_preferencia(CI1, Preferencias),
    perfil_caracteristicas(CI2, Caracteristicas),
    coincidencias(Preferencias, Caracteristicas, Atributos).

% coincidencias(+Preferencias, +Caracteristicas, -Atributos)
% Recorre las preferencias y arma la lista de las que coinciden.
coincidencias([], _, []).
coincidencias([Pref|Resto], Caracteristicas, [Atributo|Otros]) :-
    coincide(Pref, Caracteristicas, Atributo),
    !,
    coincidencias(Resto, Caracteristicas, Otros).
coincidencias([_|Resto], Caracteristicas, Otros) :-
    coincidencias(Resto, Caracteristicas, Otros).


% ------------------------------------------------------------
% compatibles_de(+CI_usuario, -ListaCompatibles)
%
% Devuelve TODOS los perfiles compatibles con CI_usuario
% (todos los que superan el umbral), excluyendo a si mismo.
% Aca se enganchara mas adelante el pre-filtro por sexo.
% ------------------------------------------------------------
compatibles_de(CI_usuario, Compatibles) :-
    perfil_preferencia(CI_usuario, Preferencias),
    member(pref(busca_sexo, SexoBuscado), Preferencias),  % extraigo qué sexo busca el usuario
    findall(CI_otro,
            (   perfil_caracteristicas(CI_otro, CaractOtro),
                CI_otro \= CI_usuario,
                member(sexo(SexoBuscado), CaractOtro),    % el otro tiene ese sexo
                es_compatible(CI_usuario, CI_otro)
            ),
            Compatibles).
