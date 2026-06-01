% OPCIONES VALIDAS PARA CADA ATRIBUTO
% Formato: opcion_valida(Atributo, Valor).

% --- Sexo (2) ---
opcion_valida(sexo, masculino).
opcion_valida(sexo, femenino).

% --- Departamentos de Uruguay (19) ---
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

% --- Color de ojos (4) ---
opcion_valida(ojos, verde).
opcion_valida(ojos, azul).
opcion_valida(ojos, marron_claro).
opcion_valida(ojos, marron_oscuro).

% --- Color de pelo (6) ---
opcion_valida(pelo, rubio).
opcion_valida(pelo, castano_claro).
opcion_valida(pelo, castano_oscuro).
opcion_valida(pelo, morocho).
opcion_valida(pelo, pelirrojo).
opcion_valida(pelo, otro).

% --- Carreras (5) ---
opcion_valida(carrera, ingenieria).
opcion_valida(carrera, derecho).
opcion_valida(carrera, comunicacion).
opcion_valida(carrera, economia).
opcion_valida(carrera, humanidades).

% --- Signos zodiacales (12) ---
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

% --- Deportes (7) ---
opcion_valida(deporte, hockey).
opcion_valida(deporte, rugby).
opcion_valida(deporte, futbol).
opcion_valida(deporte, basketball).
opcion_valida(deporte, handball).
opcion_valida(deporte, voleyball).
opcion_valida(deporte, otro).

% --- Citas ideales (8) ---
opcion_valida(cita_ideal, cine).
opcion_valida(cita_ideal, cena).
opcion_valida(cita_ideal, merienda).
opcion_valida(cita_ideal, tomar_algo).
opcion_valida(cita_ideal, paseo_parque).
opcion_valida(cita_ideal, shopping).
opcion_valida(cita_ideal, aventura).
opcion_valida(cita_ideal, fiesta).


% PESOS DEL ALGORITMO DE COMPATIBILIDAD

% Total maximo posible: 4+4+4+3+2+2+1+1+1 = 22 puntos
% NOTA: sexo NO tiene peso porque es un FILTRO, no suma puntos.
% Si dos perfiles no pasan el filtro de sexo, no se evaluan.

peso(edad, 4).
peso(altura, 4).
peso(departamento, 4).
peso(cita_ideal, 3).
peso(carrera, 2).
peso(deporte, 2).
peso(ojos, 1).
peso(pelo, 1).
peso(signo, 1).


% UMBRAL DE COMPATIBILIDAD

% Dos perfiles son compatibles si el puntaje supera este porcentaje del puntaje maximo.
umbral_porcentaje(60).

% PREDICADOS AUXILIARES

% listar_opciones: Devuelve la lista de todas las opciones validas para un atributo.
listar_opciones(Atributo, Lista) :-
    findall(Valor, opcion_valida(Atributo, Valor), Lista).

% es_valida: true si Valor es una opcion valida para Atributo.
es_valida(Atributo, Valor) :-
    opcion_valida(Atributo, Valor).

% puntaje_maximo(-N) 
% Suma de todos los pesos. Lo calcula automaticamente.
% Si cambian los pesos, este predicado se actualiza solo.
puntaje_maximo(N) :-
    findall(P, peso(_, P), Pesos),
    sum_list(Pesos, N).

% umbral_puntaje(-N)
% Calcula el puntaje minimo para que dos perfiles sean compatibles segun el umbral_porcentaje definido arriba.
umbral_puntaje(N) :-
    puntaje_maximo(Max),
    umbral_porcentaje(Porc),
    N is (Max * Porc) / 100.
