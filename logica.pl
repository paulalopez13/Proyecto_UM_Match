% OPERACIONES BÁSICAS SOBRE LOS PERFILES
:- dynamic perfil_nombre/2.
:- dynamic perfil_caracteristicas/2.
:- dynamic perfil_preferencia/2.

% Checkeo la existencia de un perfil
existe_perfil(CI) :-
    perfil_nombre(CI, _). % si encuentra un perfil con esa CI, entonces true

obtener_nombre(CI, Nombre) :-
    perfil_nombre(CI, Nombre).

% Busca en la lista de características del perfil CI el término cuyo nombre es Atributo y devuelve su contenido en Valor.
obtener_caracteristica(CI, Atributo, Valor) :-
    perfil_caracteristicas(CI, Lista),
    Termino =.. [Atributo, Valor], % construye un término con el nombre del atributo y el valor a buscar
    member(Termino, Lista). % recorre la lista de características del perfil para encontrar el término construido

% Remplazar recursivo
%caso base: si el elemento a remplazar_elemento es el primero de la lista
remplazar_elemento(Viejo, Nuevo, [Viejo|Resto], [Nuevo|Resto]).

%caso recursivo: si el elemento a remplazar_elemento no es el primero de la lista
remplazar_elemento(Viejo, Nuevo, [Otro|Resto], [Otro|RestoNuevo]) :-
    remplazar_elemento(Viejo, Nuevo, Resto, RestoNuevo). % Resto es una lista en si

% Los hechos son inmutables, por eso hay que eliminar el viejo y agregar el nuevo.
actualizar_caracteristica(CI, Atributo, NuevoValor) :-
    perfil_caracteristicas(CI, ListaVieja),
    TerminoViejo =.. [Atributo, _], % es una variable anonima, porque no importa el valor que tenia el atributo en el perfil
    TerminoNuevo =.. [Atributo, NuevoValor], % construyo un término con el nombre del atributo y el nuevo valor a asignar
    remplazar_elemento(TerminoViejo, TerminoNuevo, ListaVieja, ListaNueva),
    retract(perfil_caracteristicas(CI, ListaVieja)),
    assert(perfil_caracteristicas(CI, ListaNueva)).

% Crear un nuevo perfil
crear_perfil(CI, Nombre, ListaAtributos) :-
    \+ existe_perfil(CI),                       % si NO existe ya un perfil con ese CI
    assert(perfil_nombre(CI, Nombre)),          % guardo el nombre
    assert(perfil_caracteristicas(CI, ListaAtributos)), % guardo las características
    assert(perfil_preferencia(CI, [])).         % arranco con preferencias vacías pq las agrego en agregar_preferencias

% Devuelve la lista de preferencias del perfil CI.
obtener_preferencia(CI, Lista) :-
    perfil_preferencia(CI, Lista).

% Actualiza la lista entera de preferencias.
actualizar_preferencias(CI, NuevaLista) :-
    retract(perfil_preferencia(CI, _)),     % saco la lista vieja, "_" porque no me importa su valor
    assert(perfil_preferencia(CI, NuevaLista)). % guardo la lista nueva entera

% Agrega una preferencia a la lista que ya hay del perfil CI.
agregar_preferencia(CI, Preferencia) :-
    perfil_preferencia(CI, ListaVieja),          
    ListaNueva = [Preferencia | ListaVieja],     % armo la nueva sumando el elemento adelante
    retract(perfil_preferencia(CI, ListaVieja)), 
    assert(perfil_preferencia(CI, ListaNueva)).  

% Quitar un termino Recursivo
%caso base: si el elemento a quitar es el primero de la lista
quitar(Elemento, [Elemento|Resto], Resto). % elemento es un término

%caso recursivo: si el elemento a quitar no es el primero de la lista
quitar(Elemento, [Otro|Resto], [Otro|RestoNuevo]) :-
    quitar(Elemento, Resto, RestoNuevo).

% Quita una preferencia especifica.
quitar_preferencia(CI, Atributo) :-
    perfil_preferencia(CI, ListaVieja),
    quitar(pref(Atributo, _), ListaVieja, ListaNueva), %pref(Atributo, _) no importa el valor que tenia pq lo quiero eliminar
    retract(perfil_preferencia(CI, ListaVieja)),
    assert(perfil_preferencia(CI, ListaNueva)).

% Cambia el valor de UNA preferencia.
actualizar_preferencia(CI, Atributo, NuevoValor) :-
    perfil_preferencia(CI, ListaVieja),
    quitar(pref(Atributo, _), ListaVieja, ListaSinVieja),       % saco la preferencia vieja
    ListaNueva = [pref(Atributo, NuevoValor) | ListaSinVieja],  % agrego la nueva adelante
    retract(perfil_preferencia(CI, ListaVieja)),
    assert(perfil_preferencia(CI, ListaNueva)).

% Cambia el rango de UNA preferencia.
actualizar_rango(CI, Atributo, Min, Max) :-
    perfil_preferencia(CI, ListaVieja),
    quitar(pref_rango(Atributo, _, _), ListaVieja, ListaSinVieja),
    ListaNueva = [pref_rango(Atributo, Min, Max) | ListaSinVieja],
    retract(perfil_preferencia(CI, ListaVieja)),
    assert(perfil_preferencia(CI, ListaNueva)).

% Listar todos los perfiles
listar_perfiles(ListaCIs) :-
    findall(CI, perfil_nombre(CI, _), ListaCIs). % findall busca todos los CI que tengan un perfil_nombre y los devuelve en una lista
