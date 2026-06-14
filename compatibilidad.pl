% Modulo de calculo de compatibilidad

% Verdadero si la caracteristica del otro perfil cumple la preferencia. 
% Si coincide, devuelve el nombre del atributo.
%
%   pref(Atributo, Valor): comparacion por igualdad
%   pref_rango(Atributo, Min, Max):

coincide(pref(Atributo, Valor), Caracteristicas, Atributo) :-
    Buscado =.. [Atributo, Valor],
    member(Buscado, Caracteristicas).

coincide(pref_rango(Atributo, Min, Max), Caracteristicas, Atributo) :-
    Buscado =.. [Atributo, ValorOtro],
    member(Buscado, Caracteristicas),
    ValorOtro >= Min,
    ValorOtro =< Max.

% FILTROS EXCLUYENTES

% Antes de calcular el puntaje, el perfil tiene que pasar los 5 filtros. 
% Si alguno falla, no es compatible y no entra al calculo.

% pasa_filtros(CI_usuario, CI_otro)
% Verdadero si CI_otro pasa los 5 filtros del CI_usuario.

pasa_filtros(CI_usuario, CI_otro) :-
    perfil_preferencia(CI_usuario, Preferencias),
    perfil_caracteristicas(CI_otro, Caracteristicas),
    pasa_filtro_sexo(Preferencias, Caracteristicas),
    pasa_filtro_fuma(Preferencias, Caracteristicas),
    pasa_filtro_toma(Preferencias, Caracteristicas),
    pasa_filtro_estado_civil(Preferencias, Caracteristicas),
    pasa_filtro_signo(Preferencias, Caracteristicas).

pasa_filtro_sexo(Preferencias, Caracteristicas) :-
    member(pref(busca_sexo, SexoBuscado), Preferencias),
    member(sexo(SexoOtro), Caracteristicas),
    SexoBuscado == SexoOtro, !.

pasa_filtro_fuma(Preferencias, Caracteristicas) :-
    member(pref(busca_fuma, FumaBuscado), Preferencias),
    member(fuma(FumaOtro), Caracteristicas),
    FumaBuscado == FumaOtro, !.

pasa_filtro_toma(Preferencias, Caracteristicas) :-
    member(pref(busca_toma, TomaBuscado), Preferencias),
    member(toma(TomaOtro), Caracteristicas),
    TomaBuscado == TomaOtro, !.

pasa_filtro_estado_civil(Preferencias, Caracteristicas) :-
    member(pref(busca_estado_civil, EstadoBuscado), Preferencias),
    member(estado_civil(EstadoOtro), Caracteristicas),
    EstadoBuscado == EstadoOtro, !.

% el signo del otro NO debe estar en la lista de excluidos
pasa_filtro_signo(Preferencias, Caracteristicas) :-
    member(pref(excluye_signo, ListaExcluidos), Preferencias),
    member(signo(SignoOtro), Caracteristicas),
    \+ member(SignoOtro, ListaExcluidos).

% Calcula el puntaje que CI_otro obtiene segun las preferencias de CI_usuario. 
% Primero pasa los 5 filtros; si falla alguno no es compatible. 
% Si los pasa, suma los puntos atributo por atributo.

compatible(CI_usuario, CI_otro, Puntaje) :-
    pasa_filtros(CI_usuario, CI_otro),
    perfil_preferencia(CI_usuario, Preferencias),
    perfil_caracteristicas(CI_otro, Caracteristicas),
    sumar_puntaje(Preferencias, Caracteristicas, 0, Puntaje). % el acumulado arranca en 0 y va sumando el puntaje de cada atributo que coincide.

% Recorre las preferencias de a una, usamos recursion con acumulador.
% Si la preferencia coincide, suma el peso de ese atributo; si no coincide, deja el acumulado igual.

sumar_puntaje([], _, Total, Total). % cuando ya no quedan preferencias en la lista terminó

sumar_puntaje([Pref|Resto], Caracteristicas, Acumulado, Total) :-
    (   coincide(Pref, Caracteristicas, Atributo),
        peso(Atributo, Peso)
    ->  NuevoAcumulado is Acumulado + Peso
    ;   NuevoAcumulado is Acumulado
    ),
    sumar_puntaje(Resto, Caracteristicas, NuevoAcumulado, Total).

puntaje_de(CI1, CI2, Puntaje) :-
    compatible(CI1, CI2, Puntaje).

% Verdadero si pasa los 5 filtros Y el puntaje alcanza o supera el umbral personalizado del usuario.
es_compatible(CI1, CI2) :-
    compatible(CI1, CI2, Puntaje),
    umbral_personal(CI1, Umbral),
    Puntaje >= Umbral.

% Devuelve la lista de atributos en los que CI2 cumple las preferencias de CI1 (para explicabilidad en la interfaz).
por_que_compatible(CI1, CI2, Atributos) :-
    pasa_filtros(CI1, CI2),
    perfil_preferencia(CI1, Preferencias),
    perfil_caracteristicas(CI2, Caracteristicas),
    coincidencias(Preferencias, Caracteristicas, Atributos).

%Funciones auxiliares
%Coincidencia de filtros
coincide(pref(busca_sexo, Valor), Caracteristicas, sexo) :-
    member(sexo(Valor), Caracteristicas).

coincide(pref(busca_fuma, Valor), Caracteristicas, fuma) :-
    member(fuma(Valor), Caracteristicas).

coincide(pref(busca_toma, Valor), Caracteristicas, toma) :-
    member(toma(Valor), Caracteristicas).

coincide(pref(busca_estado_civil, Valor), Caracteristicas, estado_civil) :-
    member(estado_civil(Valor), Caracteristicas).

coincide(pref(excluye_signo, ListaExcluidos), Caracteristicas, signo) :-
    member(signo(SignoOtro), Caracteristicas),
    \+ member(SignoOtro, ListaExcluidos).

%Coincidencia de caracteristicas normales
coincide(pref(Atributo, Valor), Caracteristicas, Atributo) :-
    Buscado =.. [Atributo, Valor],
    member(Buscado, Caracteristicas).

%Coincidencai de rango
coincide(pref_rango(Atributo, Min, Max), Caracteristicas, Atributo) :-
    Buscado =.. [Atributo, ValorOtro],
    member(Buscado, Caracteristicas),
    ValorOtro >= Min,
    ValorOtro =< Max.

% Recorre las preferencias y arma la lista de las que coinciden.
coincidencias([], _, []).
coincidencias([Pref|Resto], Caracteristicas, [Atributo|Otros]) :-
    coincide(Pref, Caracteristicas, Atributo),
    !,
    coincidencias(Resto, Caracteristicas, Otros).
coincidencias([_|Resto], Caracteristicas, Otros) :-
    coincidencias(Resto, Caracteristicas, Otros).

% Devuelve TODOS los perfiles compatibles con CI_usuario
% (todos los que pasan los filtros y superan el umbral), excluyendo a si mismo.
compatibles_de(CI_usuario, Compatibles) :-
    findall(CI_otro,
            (   perfil_caracteristicas(CI_otro, _),
                CI_otro \= CI_usuario,
                es_compatible(CI_usuario, CI_otro)
            ),
            Compatibles).

% Verdadero si CI2 es compatible con CI1 y CI1 tambien es compatible con CI2.
% Es decir, ambos cumplen las preferencias del otro.
es_compatible_mutuo(CI1, CI2) :-
    es_compatible(CI1, CI2),
    es_compatible(CI2, CI1).

% Devuelve todos los perfiles que son compatibles mutuamente con CI_usuario, excluyendose a si mismo.
compatibles_mutuos_de(CI_usuario, CompatiblesMutuos) :-
    findall(CI_otro,
            (   perfil_caracteristicas(CI_otro, _),
                CI_otro \= CI_usuario,
                es_compatible_mutuo(CI_usuario, CI_otro)
            ),
            CompatiblesMutuos).