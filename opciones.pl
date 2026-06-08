
% Sexo (2)
opcion_valida(sexo, masculino).
opcion_valida(sexo, femenino).

% Estados civiles (4)
opcion_valida(estado_civil, soltero).
opcion_valida(estado_civil, casado).    
opcion_valida(estado_civil, divorciado).
opcion_valida(estado_civil, viudo).

% Departamentos de Uruguay (19)
opcion_valida(departamento, artigas).
opcion_valida(departamento, canelones).
opcion_valida(departamento, cerro_largo).
opcion_valida(departamento, colonia).
opcion_valida(departamento, durazno).
opcion_valida(departamento, flores).
opcion_valida(departamento, florida).
opcion_valida(departamento, lavalleja).
opcion_valida(departamento, maldonado).
opcion_valida(departamento, montevideo).
opcion_valida(departamento, paysandu).
opcion_valida(departamento, rio_negro).
opcion_valida(departamento, rivera).
opcion_valida(departamento, rocha).
opcion_valida(departamento, salto).
opcion_valida(departamento, san_jose).
opcion_valida(departamento, soriano).
opcion_valida(departamento, tacuarembo).
opcion_valida(departamento, treinta_y_tres).

% Color de ojos (4)
opcion_valida(ojos, verde).
opcion_valida(ojos, azul).
opcion_valida(ojos, marron_claro).
opcion_valida(ojos, marron_oscuro).

% Color de pelo (6)
opcion_valida(pelo, rubio).
opcion_valida(pelo, castano_claro).
opcion_valida(pelo, castano_oscuro).
opcion_valida(pelo, morocho).
opcion_valida(pelo, pelirrojo).
opcion_valida(pelo, otro).

% Carreras (5)
opcion_valida(carrera, ingenieria).
opcion_valida(carrera, derecho).
opcion_valida(carrera, comunicacion).
opcion_valida(carrera, economia).
opcion_valida(carrera, humanidades).

% Signos zodiacales (12)
opcion_valida(signo, aries).
opcion_valida(signo, tauro).
opcion_valida(signo, geminis).
opcion_valida(signo, cancer).
opcion_valida(signo, leo).
opcion_valida(signo, virgo).
opcion_valida(signo, libra).
opcion_valida(signo, escorpio).
opcion_valida(signo, sagitario).
opcion_valida(signo, capricornio).
opcion_valida(signo, acuario).
opcion_valida(signo, piscis).

% Deportes (7)
opcion_valida(deporte, hockey).
opcion_valida(deporte, rugby).
opcion_valida(deporte, futbol).
opcion_valida(deporte, basketball).
opcion_valida(deporte, handball).
opcion_valida(deporte, voleyball).
opcion_valida(deporte, otro).

% Citas ideales (8)
opcion_valida(cita_ideal, cine).
opcion_valida(cita_ideal, cena).
opcion_valida(cita_ideal, merienda).
opcion_valida(cita_ideal, tomar_algo).
opcion_valida(cita_ideal, paseo_parque).
opcion_valida(cita_ideal, shopping).
opcion_valida(cita_ideal, aventura).
opcion_valida(cita_ideal, fiesta).

%Fuma (2)
opcion_valida(fuma, si).
opcion_valida(fuma, no).

%Toma (2)
opcion_valida(toma, si).
opcion_valida(toma, no).

% Total maximo posible: 4+4+4+3+2+2+1+1+1 = 22 puntos

peso(edad, 4).
peso(altura, 4).
peso(departamento, 4).
peso(cita_ideal, 3).
peso(carrera, 2).
peso(deporte, 2).
peso(ojos, 1).
peso(pelo, 1).
peso(signo, 1).

% listar_opciones: Devuelve la lista de todas las opciones validas para un atributo.
listar_opciones(Atributo, Lista) :-
    findall(Valor, opcion_valida(Atributo, Valor), Lista).

% es_valida: true si Valor es una opcion valida para Atributo.
es_valida(Atributo, Valor) :-
    opcion_valida(Atributo, Valor).

% CALCULO DE PUNTAJE MAXIMO Y UMBRAL POR PERSONA

% Cada usuario tiene su propio puntaje maximo y umbral, que
% dependen de las preferencias que el haya declarado.
% Ejemplo:
%   Si Joaquina declara los 9 atributos -> max = 22.
%   Si Bruno solo declara departamento (4) y deporte (2)
%   max = 6, umbral = 3.6.

% Dos perfiles son compatibles si el puntaje supera este porcentaje del puntaje maximo.
umbral_porcentaje(60).

%chequea q los atributos, sin ser busca sexo, tengan peso. 
atributo_de_preferencia(pref(Atributo, _), Atributo) :-
    Atributo \= busca_sexo,
    peso(Atributo, _). 
atributo_de_preferencia(pref_rango(Atributo, _, _), Atributo) :-
    peso(Atributo, _).

% puntaje_maximo_personal(+CI, -Max) 
% Suma los pesos de los atributos que el usuario CI declaro en sus preferencias. Ignora busca_sexo porque es filtro.
puntaje_maximo_personal(CI, Max) :-
    perfil_preferencia(CI, ListaPrefs),
    findall(P, (member(Pref, ListaPrefs), atributo_de_preferencia(Pref, Atributo), peso(Atributo, P)), Pesos),
    %findall(que guardar, como buscarlo, lista resultado)
    sum_list(Pesos, Max). 

% umbral_personal(+CI, -Umbral)
% Calcula el umbral minimo para que un perfil sea compatible con el usuario CI, segun el porcentaje del maximo personal.
umbral_personal(CI, Umbral) :-
    puntaje_maximo_personal(CI, Max),
    umbral_porcentaje(Porc),
    Umbral is (Max * Porc) / 100. 
    