:- dynamic(perfil_caracteristicas/2).
:- dynamic(perfil_preferencia/2).
:- dynamic(perfil_nombre/2).

% --- 48217954 - Camila ---
perfil_nombre(48217954, camila).
perfil_caracteristicas(48217954, [
    edad(29),
    altura(175),
    departamento(montevideo),
    sexo(femenino),
    fuma(no),
    toma(si),
    ojos(verde),
    pelo(castano_oscuro),
    carrera(derecho),
    signo(sagitario),
    deporte(hockey),
    cita_ideal(fiesta)
]).
perfil_preferencia(48217954, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [escorpio, capricornio]),
    pref_rango(edad, 27, 35),
    pref_rango(altura, 175, 190),
    pref(departamento, montevideo),
    pref(ojos, verde),
    pref(carrera, derecho),
    pref(deporte, hockey),
    pref(cita_ideal, fiesta)
]).

% --- 49103682 - Lucia ---
perfil_nombre(49103682, lucia).
perfil_caracteristicas(49103682, [
    edad(28),
    altura(161),
    departamento(montevideo),
    sexo(femenino),
    fuma(si),
    toma(si),
    ojos(verde),
    pelo(pelirrojo),
    carrera(derecho),
    signo(sagitario),
    deporte(handball),
    cita_ideal(shopping)
]).
perfil_preferencia(49103682, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, si),
    pref(busca_toma, si),
    pref(excluye_signo, [virgo]),
    pref_rango(edad, 26, 32),
    pref(carrera, derecho)
]).

% --- 49765231 - Valentina ---
perfil_nombre(49765231, valentina).
perfil_caracteristicas(49765231, [
    edad(27),
    altura(162),
    departamento(montevideo),
    sexo(femenino),
    fuma(no),
    toma(no),
    ojos(verde),
    pelo(castano_oscuro),
    carrera(humanidades),
    signo(virgo),
    deporte(voleyball),
    cita_ideal(cine)
]).
perfil_preferencia(49765231, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, no),
    pref(busca_toma, no),
    pref(excluye_signo, [aries, leo]),
    pref_rango(edad, 25, 32),
    pref_rango(altura, 170, 185),
    pref(departamento, montevideo),
    pref(ojos, marron_oscuro),
    pref(pelo, morocho),
    pref(carrera, humanidades),
    pref(signo, virgo),
    pref(cita_ideal, cine)
]).

% --- 50384276 - Florencia ---
perfil_nombre(50384276, florencia).
perfil_caracteristicas(50384276, [
    edad(26),
    altura(173),
    departamento(rocha),
    sexo(femenino),
    fuma(si),
    toma(si),
    ojos(marron_oscuro),
    pelo(morocho),
    carrera(humanidades),
    signo(escorpio),
    deporte(otro),
    cita_ideal(aventura)
]).
perfil_preferencia(50384276, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, si),
    pref(busca_toma, si),
    pref(excluye_signo, []),
    pref_rango(edad, 24, 30),
    pref(deporte, otro),
    pref(cita_ideal, aventura)
]).

% --- 50921458 - Martina ---
perfil_nombre(50921458, martina).
perfil_caracteristicas(50921458, [
    edad(26),
    altura(158),
    departamento(montevideo),
    sexo(femenino),
    fuma(no),
    toma(si),
    ojos(marron_oscuro),
    pelo(morocho),
    carrera(humanidades),
    signo(cancer),
    deporte(otro),
    cita_ideal(merienda)
]).
perfil_preferencia(50921458, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [])
]).

% --- 51407832 - Agustina ---
perfil_nombre(51407832, agustina).
perfil_caracteristicas(51407832, [
    edad(25),
    altura(175),
    departamento(florida),
    sexo(femenino),
    fuma(no),
    toma(si),
    ojos(marron_oscuro),
    pelo(castano_oscuro),
    carrera(ingenieria),
    signo(virgo),
    deporte(basketball),
    cita_ideal(tomar_algo)
]).
perfil_preferencia(51407832, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [piscis, cancer]),
    pref_rango(edad, 24, 30),
    pref_rango(altura, 178, 190),
    pref(departamento, florida),
    pref(ojos, marron_oscuro),
    pref(carrera, ingenieria),
    pref(deporte, basketball),
    pref(cita_ideal, tomar_algo)
]).

% --- 51638294 - Carolina ---
perfil_nombre(51638294, carolina).
perfil_caracteristicas(51638294, [
    edad(25),
    altura(168),
    departamento(paysandu),
    sexo(femenino),
    fuma(no),
    toma(no),
    ojos(marron_claro),
    pelo(castano_claro),
    carrera(derecho),
    signo(capricornio),
    deporte(rugby),
    cita_ideal(cena)
]).
perfil_preferencia(51638294, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, no),
    pref(busca_toma, no),
    pref(excluye_signo, [aries]),
    pref_rango(edad, 24, 30),
    pref(departamento, paysandu),
    pref(carrera, derecho),
    pref(deporte, rugby)
]).

% --- 52015673 - Julieta ---
perfil_nombre(52015673, julieta).
perfil_caracteristicas(52015673, [
    edad(25),
    altura(160),
    departamento(montevideo),
    sexo(femenino),
    fuma(si),
    toma(si),
    ojos(marron_oscuro),
    pelo(morocho),
    carrera(derecho),
    signo(escorpio),
    deporte(hockey),
    cita_ideal(fiesta)
]).
perfil_preferencia(52015673, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, si),
    pref(busca_toma, si),
    pref(excluye_signo, []),
    pref_rango(edad, 25, 32),
    pref(departamento, montevideo),
    pref(deporte, hockey),
    pref(cita_ideal, fiesta)
]).

% --- 52489157 - Paula ---
perfil_nombre(52489157, paula).
perfil_caracteristicas(52489157, [
    edad(24),
    altura(170),
    departamento(maldonado),
    sexo(femenino),
    fuma(no),
    toma(si),
    ojos(verde),
    pelo(pelirrojo),
    carrera(comunicacion),
    signo(piscis),
    deporte(hockey),
    cita_ideal(paseo_parque)
]).
perfil_preferencia(52489157, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [escorpio]),
    pref_rango(edad, 23, 28),
    pref(cita_ideal, paseo_parque)
]).

% --- 52854329 - Maria ---
perfil_nombre(52854329, maria).
perfil_caracteristicas(52854329, [
    edad(24),
    altura(172),
    departamento(montevideo),
    sexo(femenino),
    fuma(no),
    toma(si),
    ojos(verde),
    pelo(morocho),
    carrera(ingenieria),
    signo(leo),
    deporte(voleyball),
    cita_ideal(tomar_algo)
]).
perfil_preferencia(52854329, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [virgo, capricornio]),
    pref_rango(edad, 23, 28),
    pref_rango(altura, 175, 188),
    pref(departamento, montevideo),
    pref(ojos, verde),
    pref(carrera, ingenieria),
    pref(signo, leo),
    pref(deporte, voleyball),
    pref(cita_ideal, tomar_algo)
]).

% --- 53127486 - Romina ---
perfil_nombre(53127486, romina).
perfil_caracteristicas(53127486, [
    edad(23),
    altura(167),
    departamento(montevideo),
    sexo(femenino),
    fuma(si),
    toma(si),
    ojos(verde),
    pelo(morocho),
    carrera(comunicacion),
    signo(libra),
    deporte(futbol),
    cita_ideal(fiesta)
]).
perfil_preferencia(53127486, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, si),
    pref(busca_toma, si),
    pref(excluye_signo, []),
    pref_rango(edad, 22, 27),
    pref(departamento, montevideo),
    pref(deporte, futbol),
    pref(cita_ideal, fiesta)
]).

% --- 53498712 - Belen ---
perfil_nombre(53498712, belen).
perfil_caracteristicas(53498712, [
    edad(23),
    altura(166),
    departamento(canelones),
    sexo(femenino),
    fuma(no),
    toma(si),
    ojos(marron_claro),
    pelo(morocho),
    carrera(economia),
    signo(tauro),
    deporte(futbol),
    cita_ideal(cena)
]).
perfil_preferencia(53498712, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [geminis]),
    pref_rango(edad, 22, 28),
    pref_rango(altura, 175, 185),
    pref(departamento, canelones),
    pref(pelo, morocho),
    pref(carrera, economia),
    pref(deporte, futbol),
    pref(cita_ideal, cena)
]).

% --- 53762045 - Sofia ---
perfil_nombre(53762045, sofia).
perfil_caracteristicas(53762045, [
    edad(23),
    altura(165),
    departamento(montevideo),
    sexo(femenino),
    fuma(no),
    toma(si),
    ojos(azul),
    pelo(rubio),
    carrera(ingenieria),
    signo(geminis),
    deporte(basketball),
    cita_ideal(cena)
]).
perfil_preferencia(53762045, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [tauro]),
    pref_rango(edad, 22, 28),
    pref(carrera, ingenieria),
    pref(deporte, basketball)
]).

% --- 54089127 - Catalina ---
perfil_nombre(54089127, catalina).
perfil_caracteristicas(54089127, [
    edad(23),
    altura(163),
    departamento(canelones),
    sexo(femenino),
    fuma(no),
    toma(no),
    ojos(marron_claro),
    pelo(castano_oscuro),
    carrera(derecho),
    signo(libra),
    deporte(hockey),
    cita_ideal(cena)
]).
perfil_preferencia(54089127, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, no),
    pref(busca_toma, no),
    pref(excluye_signo, [])
]).

% --- 54356218 - Joaquina ---
perfil_nombre(54356218, joaquina).
perfil_caracteristicas(54356218, [
    edad(22),
    altura(168),
    departamento(montevideo),
    sexo(femenino),
    fuma(no),
    toma(si),
    ojos(verde),
    pelo(castano_claro),
    carrera(ingenieria),
    signo(leo),
    deporte(futbol),
    cita_ideal(cine)
]).
perfil_preferencia(54356218, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [escorpio]),
    pref_rango(edad, 22, 26),
    pref_rango(altura, 175, 185),
    pref(departamento, montevideo),
    pref(ojos, verde),
    pref(pelo, castano_claro),
    pref(carrera, ingenieria),
    pref(signo, leo),
    pref(deporte, futbol),
    pref(cita_ideal, cine)
]).

% --- 54781903 - Delfina ---
perfil_nombre(54781903, delfina).
perfil_caracteristicas(54781903, [
    edad(22),
    altura(167),
    departamento(montevideo),
    sexo(femenino),
    fuma(si),
    toma(si),
    ojos(azul),
    pelo(rubio),
    carrera(comunicacion),
    signo(geminis),
    deporte(voleyball),
    cita_ideal(shopping)
]).
perfil_preferencia(54781903, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, si),
    pref(busca_toma, si),
    pref(excluye_signo, []),
    pref_rango(edad, 21, 26),
    pref(ojos, azul),
    pref(carrera, comunicacion),
    pref(cita_ideal, shopping)
]).

% --- 55012846 - Antonella ---
perfil_nombre(55012846, antonella).
perfil_caracteristicas(55012846, [
    edad(22),
    altura(165),
    departamento(maldonado),
    sexo(femenino),
    fuma(no),
    toma(si),
    ojos(azul),
    pelo(rubio),
    carrera(comunicacion),
    signo(leo),
    deporte(voleyball),
    cita_ideal(paseo_parque)
]).
perfil_preferencia(55012846, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, []),
    pref(cita_ideal, paseo_parque)
]).

% --- 55298471 - Renata ---
perfil_nombre(55298471, renata).
perfil_caracteristicas(55298471, [
    edad(22),
    altura(175),
    departamento(colonia),
    sexo(femenino),
    fuma(no),
    toma(si),
    ojos(azul),
    pelo(castano_claro),
    carrera(economia),
    signo(acuario),
    deporte(basketball),
    cita_ideal(aventura)
]).
perfil_preferencia(55298471, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [escorpio, capricornio]),
    pref_rango(edad, 21, 27),
    pref_rango(altura, 178, 190),
    pref(departamento, colonia),
    pref(carrera, economia),
    pref(deporte, basketball),
    pref(cita_ideal, aventura)
]).

% --- 55634892 - Pilar ---
perfil_nombre(55634892, pilar).
perfil_caracteristicas(55634892, [
    edad(21),
    altura(170),
    departamento(montevideo),
    sexo(femenino),
    fuma(no),
    toma(si),
    ojos(marron_claro),
    pelo(castano_oscuro),
    carrera(ingenieria),
    signo(sagitario),
    deporte(futbol),
    cita_ideal(cine)
]).
perfil_preferencia(55634892, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [virgo]),
    pref_rango(edad, 21, 26),
    pref(departamento, montevideo),
    pref(carrera, ingenieria),
    pref(deporte, futbol)
]).

% --- 55987325 - Mia ---
perfil_nombre(55987325, mia).
perfil_caracteristicas(55987325, [
    edad(21),
    altura(169),
    departamento(montevideo),
    sexo(femenino),
    fuma(no),
    toma(no),
    ojos(azul),
    pelo(castano_claro),
    carrera(economia),
    signo(piscis),
    deporte(handball),
    cita_ideal(merienda)
]).
perfil_preferencia(55987325, [
    pref(busca_sexo, masculino),
    pref(busca_fuma, no),
    pref(busca_toma, no),
    pref(excluye_signo, [aries]),
    pref_rango(edad, 21, 25),
    pref_rango(altura, 175, 188),
    pref(departamento, montevideo),
    pref(ojos, azul),
    pref(carrera, economia),
    pref(deporte, handball),
    pref(cita_ideal, merienda)
]).

% --- 48034521 - Federico ---
perfil_nombre(48034521, federico).
perfil_caracteristicas(48034521, [
    edad(29),
    altura(175),
    departamento(montevideo),
    sexo(masculino),
    fuma(no),
    toma(si),
    ojos(verde),
    pelo(castano_oscuro),
    carrera(derecho),
    signo(sagitario),
    deporte(hockey),
    cita_ideal(fiesta)
]).
perfil_preferencia(48034521, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [escorpio]),
    pref_rango(edad, 26, 32),
    pref_rango(altura, 165, 180),
    pref(departamento, montevideo),
    pref(carrera, derecho),
    pref(deporte, hockey),
    pref(cita_ideal, fiesta)
]).

% --- 48965387 - Diego ---
perfil_nombre(48965387, diego).
perfil_caracteristicas(48965387, [
    edad(28),
    altura(174),
    departamento(montevideo),
    sexo(masculino),
    fuma(si),
    toma(si),
    ojos(verde),
    pelo(pelirrojo),
    carrera(humanidades),
    signo(virgo),
    deporte(handball),
    cita_ideal(cine)
]).
perfil_preferencia(48965387, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, si),
    pref(busca_toma, si),
    pref(excluye_signo, []),
    pref_rango(edad, 25, 30),
    pref(carrera, humanidades),
    pref(cita_ideal, cine)
]).

% --- 49542168 - Martin ---
perfil_nombre(49542168, martin).
perfil_caracteristicas(49542168, [
    edad(27),
    altura(176),
    departamento(montevideo),
    sexo(masculino),
    fuma(no),
    toma(no),
    ojos(marron_oscuro),
    pelo(morocho),
    carrera(comunicacion),
    signo(cancer),
    deporte(otro),
    cita_ideal(merienda)
]).
perfil_preferencia(49542168, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, no),
    pref(busca_toma, no),
    pref(excluye_signo, [aries, leo]),
    pref_rango(edad, 25, 30),
    pref_rango(altura, 158, 172),
    pref(departamento, montevideo),
    pref(ojos, marron_oscuro),
    pref(carrera, humanidades),
    pref(signo, cancer),
    pref(deporte, otro),
    pref(cita_ideal, merienda)
]).

% --- 50217843 - Bruno ---
perfil_nombre(50217843, bruno).
perfil_caracteristicas(50217843, [
    edad(27),
    altura(184),
    departamento(rocha),
    sexo(masculino),
    fuma(si),
    toma(si),
    ojos(marron_oscuro),
    pelo(morocho),
    carrera(economia),
    signo(escorpio),
    deporte(otro),
    cita_ideal(aventura)
]).
perfil_preferencia(50217843, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, si),
    pref(busca_toma, si),
    pref(excluye_signo, [])
]).

% --- 50678912 - Andres ---
perfil_nombre(50678912, andres).
perfil_caracteristicas(50678912, [
    edad(26),
    altura(178),
    departamento(paysandu),
    sexo(masculino),
    fuma(no),
    toma(si),
    ojos(marron_claro),
    pelo(castano_claro),
    carrera(derecho),
    signo(capricornio),
    deporte(futbol),
    cita_ideal(tomar_algo)
]).
perfil_preferencia(50678912, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [aries]),
    pref_rango(edad, 23, 28),
    pref(departamento, paysandu),
    pref(carrera, derecho)
]).

% --- 51059234 - Nicolas ---
perfil_nombre(51059234, nicolas).
perfil_caracteristicas(51059234, [
    edad(26),
    altura(181),
    departamento(florida),
    sexo(masculino),
    fuma(no),
    toma(si),
    ojos(marron_oscuro),
    pelo(morocho),
    carrera(ingenieria),
    signo(virgo),
    deporte(rugby),
    cita_ideal(tomar_algo)
]).
perfil_preferencia(51059234, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [leo]),
    pref_rango(edad, 24, 30),
    pref(departamento, florida),
    pref(carrera, ingenieria),
    pref(deporte, rugby)
]).

% --- 51483276 - Sebastian ---
perfil_nombre(51483276, sebastian).
perfil_caracteristicas(51483276, [
    edad(26),
    altura(182),
    departamento(montevideo),
    sexo(masculino),
    fuma(si),
    toma(si),
    ojos(marron_oscuro),
    pelo(morocho),
    carrera(derecho),
    signo(escorpio),
    deporte(rugby),
    cita_ideal(cena)
]).
perfil_preferencia(51483276, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, si),
    pref(busca_toma, si),
    pref(excluye_signo, []),
    pref_rango(edad, 23, 28),
    pref_rango(altura, 158, 172),
    pref(departamento, montevideo),
    pref(ojos, marron_oscuro),
    pref(pelo, morocho),
    pref(carrera, derecho),
    pref(signo, escorpio),
    pref(deporte, hockey),
    pref(cita_ideal, cena)
]).

% --- 51876543 - Mateo ---
perfil_nombre(51876543, mateo).
perfil_caracteristicas(51876543, [
    edad(25),
    altura(185),
    departamento(maldonado),
    sexo(masculino),
    fuma(no),
    toma(si),
    ojos(verde),
    pelo(castano_claro),
    carrera(economia),
    signo(piscis),
    deporte(futbol),
    cita_ideal(paseo_parque)
]).
perfil_preferencia(51876543, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [escorpio]),
    pref_rango(edad, 22, 27),
    pref(carrera, economia),
    pref(cita_ideal, paseo_parque)
]).

% --- 52134987 - Tomas ---
perfil_nombre(52134987, tomas).
perfil_caracteristicas(52134987, [
    edad(25),
    altura(175),
    departamento(montevideo),
    sexo(masculino),
    fuma(no),
    toma(si),
    ojos(verde),
    pelo(castano_oscuro),
    carrera(ingenieria),
    signo(leo),
    deporte(futbol),
    cita_ideal(cine)
]).
perfil_preferencia(52134987, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [escorpio, capricornio]),
    pref_rango(edad, 21, 25),
    pref_rango(altura, 160, 175),
    pref(departamento, montevideo),
    pref(ojos, verde),
    pref(pelo, castano_claro),
    pref(carrera, ingenieria),
    pref(signo, leo),
    pref(deporte, futbol),
    pref(cita_ideal, cine)
]).

% --- 52567321 - Lucas ---
perfil_nombre(52567321, lucas).
perfil_caracteristicas(52567321, [
    edad(25),
    altura(182),
    departamento(salto),
    sexo(masculino),
    fuma(no),
    toma(si),
    ojos(verde),
    pelo(rubio),
    carrera(ingenieria),
    signo(aries),
    deporte(rugby),
    cita_ideal(cena)
]).
perfil_preferencia(52567321, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, []),
    pref_rango(edad, 22, 28),
    pref(departamento, salto),
    pref(deporte, rugby)
]).

% --- 52934187 - Gonzalo ---
perfil_nombre(52934187, gonzalo).
perfil_caracteristicas(52934187, [
    edad(24),
    altura(177),
    departamento(montevideo),
    sexo(masculino),
    fuma(si),
    toma(si),
    ojos(verde),
    pelo(morocho),
    carrera(comunicacion),
    signo(libra),
    deporte(voleyball),
    cita_ideal(shopping)
]).
perfil_preferencia(52934187, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, si),
    pref(busca_toma, si),
    pref(excluye_signo, []),
    pref_rango(edad, 21, 27),
    pref_rango(altura, 160, 175),
    pref(departamento, montevideo),
    pref(ojos, verde),
    pref(carrera, comunicacion),
    pref(deporte, voleyball),
    pref(cita_ideal, shopping)
]).

% --- 53241876 - Joaquin ---
perfil_nombre(53241876, joaquin).
perfil_caracteristicas(53241876, [
    edad(24),
    altura(178),
    departamento(canelones),
    sexo(masculino),
    fuma(no),
    toma(si),
    ojos(marron_claro),
    pelo(castano_oscuro),
    carrera(derecho),
    signo(libra),
    deporte(futbol),
    cita_ideal(fiesta)
]).
perfil_preferencia(53241876, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [virgo]),
    pref_rango(edad, 21, 26),
    pref(departamento, canelones),
    pref(carrera, derecho),
    pref(cita_ideal, fiesta)
]).

% --- 53589234 - Ignacio ---
perfil_nombre(53589234, ignacio).
perfil_caracteristicas(53589234, [
    edad(24),
    altura(178),
    departamento(montevideo),
    sexo(masculino),
    fuma(no),
    toma(si),
    ojos(azul),
    pelo(rubio),
    carrera(ingenieria),
    signo(geminis),
    deporte(basketball),
    cita_ideal(cena)
]).
perfil_preferencia(53589234, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [])
]).

% --- 53891674 - Felipe ---
perfil_nombre(53891674, felipe).
perfil_caracteristicas(53891674, [
    edad(23),
    altura(180),
    departamento(maldonado),
    sexo(masculino),
    fuma(si),
    toma(si),
    ojos(azul),
    pelo(rubio),
    carrera(comunicacion),
    signo(leo),
    deporte(basketball),
    cita_ideal(paseo_parque)
]).
perfil_preferencia(53891674, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, si),
    pref(busca_toma, si),
    pref(excluye_signo, []),
    pref_rango(edad, 21, 26),
    pref(departamento, maldonado),
    pref(deporte, basketball)
]).

% --- 54156782 - Santiago ---
perfil_nombre(54156782, santiago).
perfil_caracteristicas(54156782, [
    edad(23),
    altura(180),
    departamento(montevideo),
    sexo(masculino),
    fuma(no),
    toma(si),
    ojos(azul),
    pelo(rubio),
    carrera(economia),
    signo(geminis),
    deporte(basketball),
    cita_ideal(tomar_algo)
]).
perfil_preferencia(54156782, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [tauro]),
    pref_rango(edad, 21, 26),
    pref_rango(altura, 160, 175),
    pref(departamento, montevideo),
    pref(ojos, azul),
    pref(carrera, economia),
    pref(deporte, basketball),
    pref(cita_ideal, tomar_algo)
]).

% --- 54498321 - Manuel ---
perfil_nombre(54498321, manuel).
perfil_caracteristicas(54498321, [
    edad(23),
    altura(179),
    departamento(canelones),
    sexo(masculino),
    fuma(no),
    toma(no),
    ojos(marron_claro),
    pelo(morocho),
    carrera(humanidades),
    signo(tauro),
    deporte(futbol),
    cita_ideal(paseo_parque)
]).
perfil_preferencia(54498321, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, no),
    pref(busca_toma, no),
    pref(excluye_signo, []),
    pref_rango(edad, 21, 25),
    pref(carrera, humanidades),
    pref(cita_ideal, paseo_parque)
]).

% --- 54812765 - Agustin ---
perfil_nombre(54812765, agustin).
perfil_caracteristicas(54812765, [
    edad(23),
    altura(180),
    departamento(montevideo),
    sexo(masculino),
    fuma(no),
    toma(si),
    ojos(verde),
    pelo(castano_claro),
    carrera(ingenieria),
    signo(leo),
    deporte(futbol),
    cita_ideal(cine)
]).
perfil_preferencia(54812765, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [escorpio]),
    pref_rango(edad, 20, 25),
    pref_rango(altura, 160, 175),
    pref(departamento, montevideo),
    pref(ojos, verde),
    pref(carrera, ingenieria),
    pref(signo, leo),
    pref(deporte, futbol),
    pref(cita_ideal, cine)
]).

% --- 55187423 - Franco ---
perfil_nombre(55187423, franco).
perfil_caracteristicas(55187423, [
    edad(22),
    altura(181),
    departamento(colonia),
    sexo(masculino),
    fuma(si),
    toma(si),
    ojos(azul),
    pelo(castano_claro),
    carrera(comunicacion),
    signo(acuario),
    deporte(voleyball),
    cita_ideal(aventura)
]).
perfil_preferencia(55187423, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, si),
    pref(busca_toma, si),
    pref(excluye_signo, []),
    pref_rango(edad, 20, 25)
]).

% --- 55462178 - Pablo ---
perfil_nombre(55462178, pablo).
perfil_caracteristicas(55462178, [
    edad(22),
    altura(183),
    departamento(montevideo),
    sexo(masculino),
    fuma(no),
    toma(si),
    ojos(marron_claro),
    pelo(morocho),
    carrera(ingenieria),
    signo(sagitario),
    deporte(rugby),
    cita_ideal(tomar_algo)
]).
perfil_preferencia(55462178, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, no),
    pref(busca_toma, si),
    pref(excluye_signo, [piscis]),
    pref_rango(edad, 20, 25),
    pref(departamento, montevideo),
    pref(carrera, ingenieria),
    pref(deporte, rugby)
]).

% --- 55876234 - Benjamin ---
perfil_nombre(55876234, benjamin).
perfil_caracteristicas(55876234, [
    edad(22),
    altura(188),
    departamento(montevideo),
    sexo(masculino),
    fuma(no),
    toma(no),
    ojos(azul),
    pelo(castano_claro),
    carrera(ingenieria),
    signo(piscis),
    deporte(basketball),
    cita_ideal(merienda)
]).
perfil_preferencia(55876234, [
    pref(busca_sexo, femenino),
    pref(busca_fuma, no),
    pref(busca_toma, no),
    pref(excluye_signo, [aries]),
    pref_rango(edad, 20, 25),
    pref_rango(altura, 160, 175),
    pref(departamento, montevideo),
    pref(ojos, azul),
    pref(carrera, ingenieria),
    pref(deporte, basketball),
    pref(cita_ideal, merienda)
]).