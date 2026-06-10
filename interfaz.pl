%% Este archivo se usa para crear las ventanas para interactuar con el programa

%%Libreria que se usa para crear las ventanas
:- use_module(library(pce)).

:- dynamic signos_excluidos_temporal/2.
:- dynamic compatibles_temporal/2.
:- dynamic likear_temporal/2.
:- dynamic matches_temporal/2.
:- dynamic descartado/2.

%---------------------------------------------------------------------------------------------------------------------------------------------------------
%INICIO
%----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%Esta regla se usa para incializar el programa
iniciar:-
  ventana_login.
%


%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%LOGIN
%----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ventana_login:-
  
  %Inicializamos la ventana de login
  new(Ventana, dialog('UM Match - Login')), %Creo la ventana y su nombre
  send(Ventana, size, size(700,400 )), %Le cambio el tamano
  
  %Ubicamos el titulo en el medio
  new(Espacio1, label(espacio1, '')),
  send(Espacio1, size, size(1, 100)),
  send(Ventana, append, Espacio1),

  new(Espacio2, label(espacio2, '')),
  send(Espacio2, size, size(1, 100)),
  send(Ventana, append, Espacio2),

  %Formateamos el titulo
  new(Titulo, label(titulo, 'Bienvenido a UM Match')), %Creo el titulo
  send(Titulo, font, font(verdana, bold, 30)), %Especifica letra y tamano
  send(Titulo, colour, colour(@default, 49, 65, 122)), %Especifica color
  send(Titulo, alignment, 'center'),
  send(Ventana, append, Titulo), %Lo pone en la ventana
  
  
  %Creamos el texto para pedir la cedula
  new(LabelCI, label(label_ci, 'Cedula')), %Crea el texto 
  send(LabelCI, font, font(verdana, bold, 18)), %Especifica letra y tamano
  send(LabelCI, colour, colour(@default, 143, 179, 226)), %Especifica color
  send(Ventana, append, LabelCI), %Lo pone en la ventana

  %Creamos el campo
  new(CampoCI, text_item(ci)), %Crea el campo para escribir la cedula
  send(CampoCI, show_label, @off), %Como cedula ya aparece como texto, no tiene texto incluido
  send(CampoCI, length, 20), %Especificamos el tamano del cuadro de texto
  send(CampoCI, value_font, font(verdana, roman, 18)), %Especificamos la letra y el tamano
  send(Ventana, append, CampoCI), %Lo ponemos en la ventana

  %Creamos un boton y especificamos su funcionamiento
  new(BotonIngresar, button('Ingresar', message(@prolog, procesar_login, Ventana, CampoCI))), %Crea el boton y le dice q hacer cuando se toca
  send(BotonIngresar, font, font(verdana, bold, 20)), %Especifica letra y tamano
  send(BotonIngresar, colour, colour(@default, 49, 65, 122)), %Especifica color
  send(Ventana, append, BotonIngresar), %Lo pone en la ventana

  new(BotonCerrar, button('Cerrar', message(Ventana, destroy))),
  send(BotonCerrar, font, font(verdana, bold, 14)),
  send(BotonCerrar, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, BotonCerrar),

  %Abrir la ventana
  send(Ventana, open).

%

%Volver al login desde otra ventana
volver_desde_preferencias(Ventana, CI, registro) :-
  borrar_perfil_incompleto(CI),
  send(Ventana, destroy),
  ventana_login.

%

volver_login(Ventana):-
  send(Ventana, destroy),
  ventana_login.
%


%----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%Procesar la cedula de login
%----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
procesar_login(Ventana, CampoCI) :-
  get(CampoCI, selection, TextoCI), %Leo lo q hay en el cuadro que pide la cedula
  atom_number(TextoCI, CI), %Convierto el texto a numero

  (existe_perfil(CI)->%Si el perfil existe
  send(Ventana, destroy), %Cierro ese menu
  ventana_menu(CI) %Abro el menu principal para ese usuario
  
  ;%Si el perfil no existe
  send(Ventana, destroy), %Cierro ese menu
  ventana_no_registrado(CI)). %Lo llevo al menu para que se registre.
%


%-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%CEDULA NO REGISTRADA
%-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ventana_no_registrado(CI) :-
  
  % Inicializamos la ventana
  new(Ventana, dialog('UM Match - Cedula no registrada')),
  send(Ventana, size, size(800, 500)),

  % Formateamos el titulo
  new(Titulo, label(titulo, 'Cedula no registrada')),
  send(Titulo, font, font(verdana, bold, 30)),
  send(Titulo, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, Titulo),

  % Espacio visual
  new(Espacio1, label(espacio1, '')),
  send(Espacio1, size, size(1, 70)),
  send(Ventana, append, Espacio1),

   % Mensaje principal
  new(Mensaje, label(mensaje, 'La cedula ingresada no esta registrada.')),
  send(Mensaje, font, font(verdana, roman, 18)),
  send(Mensaje, colour, colour(@default, 60, 60, 60)),
  send(Ventana, append, Mensaje),

  % Espacio visual
  new(Espacio2, label(espacio2, '')),
  send(Espacio2, size, size(1, 50)),
  send(Ventana, append, Espacio2),

   % Mostramos la cedula ingresada
  new(TextoCI, label(texto_ci, 'Cedula ingresada:')),
  send(TextoCI, font, font(verdana, bold, 18)),
  send(TextoCI, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, TextoCI),

  new(LabelCI, label(label_ci, CI)),
  send(LabelCI, font, font(verdana, roman, 18)),
  send(LabelCI, colour, colour(@default, 60, 60, 60)),
  send(Ventana, append, LabelCI),

  % Espacio visual
  new(Espacio3, label(espacio3, '')),
  send(Espacio3, size, size(1, 50)),
  send(Ventana, append, Espacio3),

  % Pregunta
  new(Pregunta, label(pregunta, 'Desea registrarse?')),
  send(Pregunta, font, font(verdana, bold, 18)),
  send(Pregunta, colour, colour(@default, 60, 60, 60)),
  send(Ventana, append, Pregunta),

  % Espacio visual
  new(Espacio4, label(espacio4, '')),
  send(Espacio4, size, size(1, 40)),
  send(Ventana, append, Espacio4),


  % Boton registrarse
  new(BotonRegistrarse, button('Registrarme',message(@prolog, abrir_registro, Ventana, CI))),
  send(BotonRegistrarse, font, font(verdana, bold, 20)),
  send(BotonRegistrarse, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, BotonRegistrarse),

  % Boton volver al login
  new(BotonVolver, button('Volver', message(@prolog, volver_login, Ventana))),
  send(BotonVolver, font, font(verdana, bold, 20)),
  send(BotonVolver, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, BotonVolver),

  % Abrimos la ventana
  send(Ventana, open).
%


%---------------------------------------------------------------------------------------------------------------------------------------------------------------
%REGISTRAR USUARIO NUEVO
%---------------------------------------------------------------------------------------------------------------------------------------------------------------
%funcion para abrir el menu de registro cuando se apreta el boton
abrir_registro(Ventana, CI) :-
  send(Ventana, destroy),
  ventana_registro(CI).
%

%Funcion auxiliares para menus desplegables
crear_menu_opciones(Atributo, Menu) :-
  new(Menu, menu(Atributo, cycle)),
  send(Menu, show_label, @off),
  send(Menu, value_font, font(verdana, roman, 13)),
  listar_opciones(Atributo, Opciones),
  cargar_opciones(Menu, Opciones).
%

%Caso base
cargar_opciones(_, []).

%Caso recursivo
cargar_opciones(Menu, [Opcion | Resto]) :-
  send(Menu, append, Opcion),
  cargar_opciones(Menu, Resto).
%

%Ventana
ventana_registro(CI) :-
  new(Ventana, dialog('UM Match - Registro')),
  send(Ventana, size, size(700, 900)),

  %Titulo 
  new(Titulo, label(titulo, 'Registro de perfil')),
  send(Titulo, font, font(verdana, bold, 28)),
  send(Titulo, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, Titulo),

  % Cedula
  new(TextoCI, label(texto_ci, 'Cedula')),
  send(TextoCI, font, font(verdana, bold, 13)),
  send(TextoCI, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, TextoCI, point(80, 100)),
  
  new(LabelCI, label(label_ci, CI)),
  send(LabelCI, font, font(verdana, roman, 13)),
  send(LabelCI, colour, colour(@default, 60, 60, 60)),
  send(Ventana, display, LabelCI, point(80, 125)),

  % Nombre
  new(LabelNombre, label(label_nombre, 'Nombre')),
  send(LabelNombre, font, font(verdana, bold, 13)),
  send(LabelNombre, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelNombre, point(80, 175)),

  new(CampoNombre, text_item(nombre)),
  send(CampoNombre, show_label, @off),
  send(CampoNombre, length, 15),
  send(CampoNombre, value_font, font(verdana, roman, 13)),
  send(Ventana, display, CampoNombre, point(80, 200)),

  % Sexo
  new(LabelSexo, label(label_sexo, 'Sexo')),
  send(LabelSexo, font, font(verdana, bold, 13)),
  send(LabelSexo, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelSexo, point(80, 275)),

  crear_menu_opciones(sexo, MenuSexo),
  send(Ventana, display, MenuSexo, point(80, 300)),

  % Estado Civil
  new(LabelEstadoCivil, label(label_estado_civil, 'Estado civil')),
  send(LabelEstadoCivil, font, font(verdana, bold, 13)),
  send(LabelEstadoCivil, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelEstadoCivil, point(80, 375)),

  crear_menu_opciones(estado_civil, MenuEstadoCivil),
  send(Ventana, display, MenuEstadoCivil, point(80, 400)),

  % Edad
  new(LabelEdad, label(label_edad, 'Edad')),
  send(LabelEdad, font, font(verdana, bold, 13)),
  send(LabelEdad, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelEdad, point(80, 475)),

  new(CampoEdad, text_item(edad)),
  send(CampoEdad, show_label, @off),
  send(CampoEdad, length, 15),
  send(CampoEdad, value_font, font(verdana, roman, 13)),
  send(Ventana, display, CampoEdad, point(80, 500)),

  % Altura
  new(LabelAltura, label(label_altura, 'Altura')),
  send(LabelAltura, font, font(verdana, bold, 13)),
  send(LabelAltura, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelAltura, point(80, 575)),

  new(CampoAltura, text_item(altura)),
  send(CampoAltura, show_label, @off),
  send(CampoAltura, length, 15),
  send(CampoAltura, value_font, font(verdana, roman, 13)),
  send(Ventana, display, CampoAltura, point(80, 600)),

  % Fuma
  new(LabelFuma, label(label_fuma, 'Fuma')),
  send(LabelFuma, font, font(verdana, bold, 13)),
  send(LabelFuma, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelFuma, point(80, 675)),

  crear_menu_opciones(fuma, MenuFuma),
  send(Ventana, display, MenuFuma, point(80, 700)),

  % Toma
  new(LabelToma, label(label_toma, 'Toma')),
  send(LabelToma, font, font(verdana, bold, 13)),
  send(LabelToma, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelToma, point(80, 775)),

  crear_menu_opciones(toma, MenuToma),
  send(Ventana, display, MenuToma, point(80, 800)),

  % Departamento
  new(LabelDepartamento, label(label_departamento, 'Departamento')),
  send(LabelDepartamento, font, font(verdana, bold, 13)),
  send(LabelDepartamento, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelDepartamento, point(400, 100)),

  crear_menu_opciones(departamento, MenuDepartamento),
  send(Ventana, display, MenuDepartamento, point(400, 125)),

  % Ojos
  new(LabelOjos, label(label_ojos, 'Ojos')),
  send(LabelOjos, font, font(verdana, bold, 13)),
  send(LabelOjos, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelOjos, point(400, 200)),

  crear_menu_opciones(ojos, MenuOjos),
  send(Ventana, display, MenuOjos, point(400, 225)),

  % Pelo
  new(LabelPelo, label(label_pelo, 'Pelo')),
  send(LabelPelo, font, font(verdana, bold, 13)),
  send(LabelPelo, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelPelo, point(400, 300)),

  crear_menu_opciones(pelo, MenuPelo),
  send(Ventana, display, MenuPelo, point(400, 325)),

  % Carrera
  new(LabelCarrera, label(label_carrera, 'Carrera')),
  send(LabelCarrera, font, font(verdana, bold, 13)),
  send(LabelCarrera, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelCarrera, point(400, 400)),

  crear_menu_opciones(carrera, MenuCarrera),
  send(Ventana, display, MenuCarrera, point(400, 425)),

  % Signo
  new(LabelSigno, label(label_signo, 'Signo')),
  send(LabelSigno, font, font(verdana, bold, 13)),
  send(LabelSigno, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelSigno, point(400, 500)),

  crear_menu_opciones(signo, MenuSigno),
  send(Ventana, display, MenuSigno, point(400, 525)),

  % Deporte
  new(LabelDeporte, label(label_deporte, 'Deporte')),
  send(LabelDeporte, font, font(verdana, bold, 13)),
  send(LabelDeporte, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelDeporte, point(400, 600)),

  crear_menu_opciones(deporte, MenuDeporte),
  send(Ventana, display, MenuDeporte, point(400, 625)),

  % Cita ideal
  new(LabelCitaIdeal, label(label_cita_ideal, 'Cita ideal')),
  send(LabelCitaIdeal, font, font(verdana, bold, 13)),
  send(LabelCitaIdeal, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelCitaIdeal, point(400, 700)),

  crear_menu_opciones(cita_ideal, MenuCitaIdeal),
  send(Ventana, display, MenuCitaIdeal, point(400, 725)),

  % Boton guardar perfil
  new(BotonGuardar, button('Guardar perfil', message(@prolog, procesar_registro, Ventana, CI, CampoNombre, CampoEdad, MenuSexo, MenuEstadoCivil, CampoAltura, MenuDepartamento, MenuOjos, MenuPelo, MenuCarrera, MenuSigno, MenuDeporte, MenuCitaIdeal, MenuFuma, MenuToma))),
  send(BotonGuardar, font, font(verdana, bold, 20)),
  send(BotonGuardar, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonGuardar, point(190, 830)),

  % Boton volver
  new(BotonVolver, button('Volver', message(@prolog, volver_login, Ventana))),
  send(BotonVolver, font, font(verdana, bold, 20)),
  send(BotonVolver, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonVolver, point(430, 830)),

  send(Ventana, open).
%


%-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%Procesar Registro
%----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
procesar_registro(Ventana, CI, CampoNombre, CampoEdad, MenuSexo, MenuEstadoCivil, CampoAltura, MenuDepartamento, MenuOjos, MenuPelo, MenuCarrera, MenuSigno, MenuDeporte, MenuCitaIdeal, MenuFuma, MenuToma):-

  %1. sacamos los datos de los campos de texto
  get(CampoNombre, selection, Nombre),
  get(CampoEdad, selection, TextoEdad),
  get(CampoAltura, selection, TextoAltura),

  atom_number(TextoEdad, Edad),
  atom_number(TextoAltura, Altura),

  %2. sacamos los datos de los menus
  get(MenuSexo, selection, Sexo),
  get(MenuEstadoCivil, selection, EstadoCivil),
  get(MenuDepartamento, selection, Departamento),
  get(MenuOjos, selection, Ojos),
  get(MenuPelo, selection, Pelo),
  get(MenuCarrera, selection, Carrera),
  get(MenuSigno, selection, Signo),
  get(MenuDeporte, selection, Deporte),
  get(MenuCitaIdeal, selection, CitaIdeal),
  get(MenuFuma, selection, Fuma),
  get(MenuToma, selection, Toma),

  %3 Creamos la lista con las caracteristicas
  ListaAtributos = [sexo(Sexo), fuma(Fuma), toma(Toma), signo(Signo), estado_civil(EstadoCivil), edad(Edad), altura(Altura), departamento(Departamento), ojos(Ojos), pelo(Pelo), carrera(Carrera), deporte(Deporte), cita_ideal(CitaIdeal)],

  %4. Creamos y guardamos el perfil
  crear_perfil(CI, Nombre, ListaAtributos),
 
  %5 Nos vamos al Menu principal
  send(Ventana, destroy),
  ventana_definir_preferencias(CI, registro).
%


%-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%Definicion Inicial de Preferencias
%----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ventana_definir_preferencias(CI, Origen):-
  
  new(Ventana, dialog('UM Match - Preferencias')),
  send(Ventana, size, size(850, 900)),

  %Nos fijamos si este usuario ya tiene preferencias o si es un nuevo usuario
  (perfil_preferencia(CI, ListaPreferencias)->
    true;
    ListaPreferencias = []),

  new(Titulo, label(titulo, 'Definicion de Preferencias')),
  send(Titulo, font, font(verdana, bold, 28)),
  send(Titulo, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, Titulo),

  % Edad minima
  new(LabelEdadMin, label(label_pref_edad_min, 'Edad minima')),
  send(LabelEdadMin, font, font(verdana, bold, 13)),
  send(LabelEdadMin, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelEdadMin, point(80, 100)),

  new(CampoEdadMin, text_item(edad_min)),
  send(CampoEdadMin, show_label, @off),
  send(CampoEdadMin, length, 10),
  send(CampoEdadMin, value_font, font(verdana, roman, 13)),
  cargar_valor_texto(CampoEdadMin, edad_min, ListaPreferencias), %Esto se usa para rellenar el campo de texto si el usuario esta redefiniendo preferencias  cargar_valor_texto(CampoEdadMin, edad_min, ListaPreferencias), %Esto se usa para rellenar el campo de texto si el usuario esta redefiniendo preferencias
  send(Ventana, display, CampoEdadMin, point(80, 125)),

  % Edad maxima
  new(LabelEdadMax, label(label_pref_edad_max, 'Edad maxima')),
  send(LabelEdadMax, font, font(verdana, bold, 13)),
  send(LabelEdadMax, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelEdadMax, point(80, 175)),

  new(CampoEdadMax, text_item(edad_max)),
  send(CampoEdadMax, show_label, @off),
  send(CampoEdadMax, length, 10),
  send(CampoEdadMax, value_font, font(verdana, roman, 13)),
  cargar_valor_texto(CampoEdadMax, edad_max, ListaPreferencias),
  send(Ventana, display, CampoEdadMax, point(80, 200)),

  % Sexo
  new(LabelSexo, label(label_pref_sexo, 'Sexo')),
  send(LabelSexo, font, font(verdana, bold, 13)),
  send(LabelSexo, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelSexo, point(80, 250)),

  crear_menu_opciones(sexo, MenuSexo),
  cargar_valor_menu(MenuSexo, sexo, ListaPreferencias), %Si el usuario ya tiene preferencia, se carga el valor de su preferencia en el menu
  send(Ventana, display, MenuSexo, point(80, 275)),

  % Estado Civil
  new(LabelEstadoCivil, label(label_pref_estado_civil, 'Estado civil')),
  send(LabelEstadoCivil, font, font(verdana, bold, 13)),
  send(LabelEstadoCivil, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelEstadoCivil, point(80, 325)),

  crear_menu_opciones(estado_civil, MenuEstadoCivil),
  cargar_valor_menu(MenuEstadoCivil, estado_civil, ListaPreferencias),
  send(Ventana, display, MenuEstadoCivil, point(80, 350)),

  % Altura minima
  new(LabelAlturaMin, label(label_pref_altura_min, 'Altura minima')),
  send(LabelAlturaMin, font, font(verdana, bold, 13)),
  send(LabelAlturaMin, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelAlturaMin, point(80, 400)),

  new(CampoAlturaMin, text_item(altura_min)),
  send(CampoAlturaMin, show_label, @off),
  send(CampoAlturaMin, length, 10),
  send(CampoAlturaMin, value_font, font(verdana, roman, 13)),
  cargar_valor_texto(CampoAlturaMin, altura_min, ListaPreferencias),
  send(Ventana, display, CampoAlturaMin, point(80, 425)),

  % Altura maxima
  new(LabelAlturaMax, label(label_pref_altura_max, 'Altura maxima')),
  send(LabelAlturaMax, font, font(verdana, bold, 13)),
  send(LabelAlturaMax, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelAlturaMax, point(80, 475)),

  new(CampoAlturaMax, text_item(altura_max)),
  send(CampoAlturaMax, show_label, @off),
  send(CampoAlturaMax, length, 10),
  send(CampoAlturaMax, value_font, font(verdana, roman, 13)),
  cargar_valor_texto(CampoAlturaMax, altura_max, ListaPreferencias),
  send(Ventana, display, CampoAlturaMax, point(80, 500)),

  % Departamento
  new(LabelDepartamento, label(label_pref_departamento, 'Departamento')),
  send(LabelDepartamento, font, font(verdana, bold, 13)),
  send(LabelDepartamento, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelDepartamento, point(80, 550)),

  crear_menu_opciones(departamento, MenuDepartamento),
  cargar_valor_menu(MenuDepartamento, departamento, ListaPreferencias),
  send(Ventana, display, MenuDepartamento, point(80, 575)),

  % Ojos
  new(LabelOjos, label(label_pref_ojos, 'Ojos')),
  send(LabelOjos, font, font(verdana, bold, 13)),
  send(LabelOjos, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelOjos, point(80, 625)),

  crear_menu_opciones(ojos, MenuOjos),
  cargar_valor_menu(MenuOjos, ojos, ListaPreferencias),
  send(Ventana, display, MenuOjos, point(80, 650)),

  % Pelo
  new(LabelPelo, label(label_pref_pelo, 'Pelo')),
  send(LabelPelo, font, font(verdana, bold, 13)),
  send(LabelPelo, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelPelo, point(450, 100)),

  crear_menu_opciones(pelo, MenuPelo),
  cargar_valor_menu(MenuPelo, pelo, ListaPreferencias),
  send(Ventana, display, MenuPelo, point(450, 125)),

  % Carrera
  new(LabelCarrera, label(label_pref_carrera, 'Carrera')),
  send(LabelCarrera, font, font(verdana, bold, 13)),
  send(LabelCarrera, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelCarrera, point(450, 175)),

  crear_menu_opciones(carrera, MenuCarrera),
  cargar_valor_menu(MenuCarrera, carrera, ListaPreferencias),
  send(Ventana, display, MenuCarrera, point(450, 200)),

  % Signo
  new(LabelSigno, label(label_pref_signo, 'Signo')),
  send(LabelSigno, font, font(verdana, bold, 13)),
  send(LabelSigno, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelSigno, point(450, 250)),

  crear_menu_opciones(signo, MenuSigno),
  cargar_valor_menu(MenuSigno, signo, ListaPreferencias),
  send(Ventana, display, MenuSigno, point(450, 275)),

  % Deporte
  new(LabelDeporte, label(label_pref_deporte, 'Deporte')),
  send(LabelDeporte, font, font(verdana, bold, 13)),
  send(LabelDeporte, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelDeporte, point(450, 325)),

  crear_menu_opciones(deporte, MenuDeporte),
  cargar_valor_menu(MenuDeporte, deporte, ListaPreferencias),
  send(Ventana, display, MenuDeporte, point(450, 350)),

  % Cita ideal
  new(LabelCitaIdeal, label(label_pref_cita_ideal, 'Cita ideal')),
  send(LabelCitaIdeal, font, font(verdana, bold, 13)),
  send(LabelCitaIdeal, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelCitaIdeal, point(450, 400)),

  crear_menu_opciones(cita_ideal, MenuCitaIdeal),
  cargar_valor_menu(MenuCitaIdeal, cita_ideal, ListaPreferencias),
  send(Ventana, display, MenuCitaIdeal, point(450, 425)),

  % Fuma
  new(LabelFuma, label(label_pref_fuma, 'Fuma')),
  send(LabelFuma, font, font(verdana, bold, 13)),
  send(LabelFuma, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelFuma, point(450, 475)),

  crear_menu_opciones(fuma, MenuFuma),
  cargar_valor_menu(MenuFuma, fuma, ListaPreferencias),
  send(Ventana, display, MenuFuma, point(450, 500)),

  % Toma
  new(LabelToma, label(label_pref_toma, 'Toma')),
  send(LabelToma, font, font(verdana, bold, 13)),
  send(LabelToma, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelToma, point(450, 550)),

  crear_menu_opciones(toma, MenuToma),
  cargar_valor_menu(MenuToma, toma, ListaPreferencias),
  send(Ventana, display, MenuToma, point(450, 575)),

  % Signos excluidos
  new(LabelSignosExcluidos, label(label_signos_excluidos, 'Signos no deseados')),
  send(LabelSignosExcluidos, font, font(verdana, bold, 13)),
  send(LabelSignosExcluidos, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelSignosExcluidos, point(450, 625)),

  new(BotonExcluirSignos, button('Elegir signos', message(@prolog, ventana_excluir_signos, CI))),
  send(BotonExcluirSignos, font, font(verdana, bold, 14)),
  send(BotonExcluirSignos, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonExcluirSignos, point(450, 650)),


  %Boton guardar preferencias
  new(BotonGuardar, button('Guardar preferencias', message(@prolog, procesar_preferencias, Ventana, CI, CampoEdadMin, CampoEdadMax, MenuSexo, MenuEstadoCivil, CampoAlturaMin, CampoAlturaMax, MenuDepartamento, MenuOjos, MenuPelo, MenuCarrera, MenuSigno, MenuDeporte, MenuCitaIdeal, MenuFuma, MenuToma))),
  send(BotonGuardar, font, font(verdana, bold, 18)),
  send(BotonGuardar, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonGuardar, point(350, 800)),

  % Boton volver
  new(BotonVolver, button('Volver', message(@prolog, volver_desde_preferencias, Ventana, CI, Origen))),
  send(BotonVolver, font, font(verdana, bold, 18)),
  send(BotonVolver, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonVolver, point(230, 800)),

  send(Ventana, open).
%
  
%Sub Ventana para excluir signo
ventana_excluir_signos(CI):-
    
  new(Ventana, dialog('UM Match - Signos no deseados')),
  send(Ventana, size, size(600, 1000)),

  new(Titulo, label(titulo, 'Signos no deseados')),
  send(Titulo, font, font(verdana, bold, 28)),
  send(Titulo, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, Titulo),

  new(Explicacion, label(explicacion, 'Marca SI si queres excluir ese signo')),
  send(Explicacion, font, font(verdana, roman, 13)),
  send(Explicacion, colour, colour(@default, 60, 60, 60)),
  send(Ventana, append, Explicacion),

  % Aries
  new(LabelAries, label(label_aries, 'Aries')),
  send(LabelAries, font, font(verdana, bold, 13)),
  send(LabelAries, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelAries, point(100, 150)),

  new(MenuAries, menu(aries, cycle)),
  send(MenuAries, show_label, @off),
  send(MenuAries, append, no),
  send(MenuAries, append, si),
  send(MenuAries, selection, no),
  send(Ventana, display, MenuAries, point(100, 175)),

  % Tauro
  new(LabelTauro, label(label_tauro, 'Tauro')),
  send(LabelTauro, font, font(verdana, bold, 13)),
  send(LabelTauro, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelTauro, point(100, 250)),

  new(MenuTauro, menu(tauro, cycle)),
  send(MenuTauro, show_label, @off),
  send(MenuTauro, append, no),
  send(MenuTauro, append, si),
  send(MenuTauro, selection, no),
  send(Ventana, display, MenuTauro, point(100, 275)),

  % Geminis
  new(LabelGeminis, label(label_geminis, 'Geminis')),
  send(LabelGeminis, font, font(verdana, bold, 13)),
  send(LabelGeminis, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelGeminis, point(100, 350)),

  new(MenuGeminis, menu(geminis, cycle)),
  send(MenuGeminis, show_label, @off),
  send(MenuGeminis, append, no),
  send(MenuGeminis, append, si),
  send(MenuGeminis, selection, no),
  send(Ventana, display, MenuGeminis, point(100, 375)),

  % Cancer
  new(LabelCancer, label(label_cancer, 'Cancer')),
  send(LabelCancer, font, font(verdana, bold, 13)),
  send(LabelCancer, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelCancer, point(100, 450)),

  new(MenuCancer, menu(cancer, cycle)),
  send(MenuCancer, show_label, @off),
  send(MenuCancer, append, no),
  send(MenuCancer, append, si),
  send(MenuCancer, selection, no),
  send(Ventana, display, MenuCancer, point(100, 475)),

  % Leo
  new(LabelLeo, label(label_leo, 'Leo')),
  send(LabelLeo, font, font(verdana, bold, 13)),
  send(LabelLeo, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelLeo, point(100, 550)),

  new(MenuLeo, menu(leo, cycle)),
  send(MenuLeo, show_label, @off),
  send(MenuLeo, append, no),
  send(MenuLeo, append, si),
  send(MenuLeo, selection, no),
  send(Ventana, display, MenuLeo, point(100, 575)),

  % Virgo
  new(LabelVirgo, label(label_virgo, 'Virgo')),
  send(LabelVirgo, font, font(verdana, bold, 13)),
  send(LabelVirgo, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelVirgo, point(100, 650)),

  new(MenuVirgo, menu(virgo, cycle)),
  send(MenuVirgo, show_label, @off),
  send(MenuVirgo, append, no),
  send(MenuVirgo, append, si),
  send(MenuVirgo, selection, no),
  send(Ventana, display, MenuVirgo, point(100, 675)),

  % Libra
  new(LabelLibra, label(label_libra, 'Libra')),
  send(LabelLibra, font, font(verdana, bold, 13)),
  send(LabelLibra, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelLibra, point(350, 150)),

  new(MenuLibra, menu(libra, cycle)),
  send(MenuLibra, show_label, @off),
  send(MenuLibra, append, no),
  send(MenuLibra, append, si),
  send(MenuLibra, selection, no),
  send(Ventana, display, MenuLibra, point(350, 175)),

  % Escorpio
  new(LabelEscorpio, label(label_escorpio, 'Escorpio')),
  send(LabelEscorpio, font, font(verdana, bold, 13)),
  send(LabelEscorpio, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelEscorpio, point(350, 250)),

  new(MenuEscorpio, menu(escorpio, cycle)),
  send(MenuEscorpio, show_label, @off),
  send(MenuEscorpio, append, no),
  send(MenuEscorpio, append, si),
  send(MenuEscorpio, selection, no),
  send(Ventana, display, MenuEscorpio, point(350, 275)),

  % Sagitario
  new(LabelSagitario, label(label_sagitario, 'Sagitario')),
  send(LabelSagitario, font, font(verdana, bold, 13)),
  send(LabelSagitario, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelSagitario, point(350, 350)),

  new(MenuSagitario, menu(sagitario, cycle)),
  send(MenuSagitario, show_label, @off),
  send(MenuSagitario, append, no),
  send(MenuSagitario, append, si),
  send(MenuSagitario, selection, no),
  send(Ventana, display, MenuSagitario, point(350, 375)),

  % Capricornio
  new(LabelCapricornio, label(label_capricornio, 'Capricornio')),
  send(LabelCapricornio, font, font(verdana, bold, 13)),
  send(LabelCapricornio, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelCapricornio, point(350, 450)),

  new(MenuCapricornio, menu(capricornio, cycle)),
  send(MenuCapricornio, show_label, @off),
  send(MenuCapricornio, append, no),
  send(MenuCapricornio, append, si),
  send(MenuCapricornio, selection, no),
  send(Ventana, display, MenuCapricornio, point(350, 475)),

  % Acuario
  new(LabelAcuario, label(label_acuario, 'Acuario')),
  send(LabelAcuario, font, font(verdana, bold, 13)),
  send(LabelAcuario, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelAcuario, point(350, 550)),

  new(MenuAcuario, menu(acuario, cycle)),
  send(MenuAcuario, show_label, @off),
  send(MenuAcuario, append, no),
  send(MenuAcuario, append, si),
  send(MenuAcuario, selection, no),
  send(Ventana, display, MenuAcuario, point(350, 575)),

  % Piscis
  new(LabelPiscis, label(label_piscis, 'Piscis')),
  send(LabelPiscis, font, font(verdana, bold, 13)),
  send(LabelPiscis, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelPiscis, point(350, 650)),

  new(MenuPiscis, menu(piscis, cycle)),
  send(MenuPiscis, show_label, @off),
  send(MenuPiscis, append, no),
  send(MenuPiscis, append, si),
  send(MenuPiscis, selection, no),
  send(Ventana, display, MenuPiscis, point(350, 675)),

  % Boton guardar
  new(BotonGuardar, button('Guardar', message(@prolog, procesar_signos, Ventana, CI, MenuAries, MenuTauro, MenuGeminis, MenuCancer, MenuLeo, MenuVirgo, MenuLibra, MenuEscorpio, MenuSagitario, MenuCapricornio, MenuAcuario, MenuPiscis))),
  send(BotonGuardar, font, font(verdana, bold, 18)),
  send(BotonGuardar, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonGuardar, point(245, 850)),

  send(Ventana, open).
%

%Funcion auxiliar para procesar signos excluidos
armar_signos_excluidos([], []).

armar_signos_excluidos([Signo-si | Resto], [Signo | ListaFinal]) :-
  armar_signos_excluidos(Resto, ListaFinal).

armar_signos_excluidos([_Signo-no | Resto], ListaFinal) :-
  armar_signos_excluidos(Resto, ListaFinal).
%

%Procesar signos excluidos
procesar_signos(Ventana,CI, MenuAries, MenuTauro, MenuGeminis, MenuCancer, MenuLeo, MenuVirgo, MenuLibra, MenuEscorpio, MenuSagitario, MenuCapricornio, MenuAcuario, MenuPiscis):-

  get(MenuAries, selection, Aries),
  get(MenuTauro, selection, Tauro),
  get(MenuGeminis, selection, Geminis),
  get(MenuCancer, selection, Cancer),
  get(MenuLeo, selection, Leo),
  get(MenuVirgo, selection, Virgo),
  get(MenuLibra, selection, Libra),
  get(MenuEscorpio, selection, Escorpio),
  get(MenuSagitario, selection, Sagitario),
  get(MenuCapricornio, selection, Capricornio),
  get(MenuAcuario, selection, Acuario),
  get(MenuPiscis, selection, Piscis),

  armar_signos_excluidos([aries-Aries, tauro-Tauro, geminis-Geminis, cancer-Cancer, leo-Leo, virgo-Virgo, libra-Libra, escorpio-Escorpio, sagitario-Sagitario, capricornio-Capricornio, acuario-Acuario, piscis-Piscis], ListaSignosExcluidos),

  retractall(signos_excluidos_temporal(CI, _)),
  assertz(signos_excluidos_temporal(CI, ListaSignosExcluidos)),

  send(Ventana, destroy).
%

%Procesar preferencias
procesar_preferencias(Ventana, CI, CampoEdadMin, CampoEdadMax, MenuSexo, MenuEstadoCivil, CampoAlturaMin, CampoAlturaMax, MenuDepartamento, MenuOjos, MenuPelo, MenuCarrera, MenuSigno, MenuDeporte, MenuCitaIdeal, MenuFuma, MenuToma):-
  
  get(CampoEdadMin, selection, TextoEdadMin),
  get(CampoEdadMax, selection, TextoEdadMax),
  get(CampoAlturaMin, selection, TextoAlturaMin),
  get(CampoAlturaMax, selection, TextoAlturaMax),

  atom_number(TextoEdadMin, EdadMin),
  atom_number(TextoEdadMax, EdadMax),
  atom_number(TextoAlturaMin, AlturaMin),
  atom_number(TextoAlturaMax, AlturaMax),

  get(MenuSexo, selection, Sexo),
  get(MenuEstadoCivil, selection, EstadoCivil),
  get(MenuDepartamento, selection, Departamento),
  get(MenuOjos, selection, Ojos),
  get(MenuPelo, selection, Pelo),
  get(MenuCarrera, selection, Carrera),
  get(MenuSigno, selection, Signo),
  get(MenuDeporte, selection, Deporte),
  get(MenuCitaIdeal, selection, CitaIdeal),
  get(MenuFuma, selection, Fuma),
  get(MenuToma, selection, Toma),

  (signos_excluidos_temporal(CI, ListaSignosExcluidos)->true;
    ListaSignosExcluidos = []),

  ListaPreferencias = [ pref(busca_sexo, Sexo), pref(busca_fuma, Fuma), pref(busca_toma, Toma), pref(busca_estado_civil, EstadoCivil), pref(excluye_signo, ListaSignosExcluidos), pref_rango(edad, EdadMin, EdadMax), pref_rango(altura, AlturaMin, AlturaMax), pref(departamento, Departamento), pref(ojos, Ojos), pref(pelo, Pelo), pref(carrera, Carrera), pref(signo, Signo), pref(deporte, Deporte), pref(cita_ideal, CitaIdeal)],

  actualizar_preferencias(CI, ListaPreferencias),

  %Borramos los signos para q quede vacia la lista para el proximo usuario
  retractall(signos_excluidos_temporal(CI, _)),

  send(Ventana, destroy),
  ventana_menu(CI).
%


%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%Menu Principal
%---------------------------------------------------------------------------------------------------------------------------------------------------------
ventana_menu(CI) :-

  new(Ventana, dialog('UM Match - Menu principal')),
  send(Ventana, size, size(700, 700)),

  % Titulo
  new(Titulo, label(titulo, 'Menu principal')),
  send(Titulo, font, font(verdana, bold, 30)),
  send(Titulo, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, Titulo),

  % Cedula del usuario
  new(LabelCI, label(label_ci, 'Usuario')),
  send(LabelCI, font, font(verdana, bold, 16)),
  send(LabelCI, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelCI, point(30, 110)),

  new(TextoCI, label(texto_ci, CI)),
  send(TextoCI, font, font(verdana, roman, 16)),
  send(TextoCI, colour, colour(@default, 60, 60, 60)),
  send(Ventana, display, TextoCI, point(150, 110)),

  %Nombre del Usuario
  perfil_nombre(CI, Nombre),

  new(LabelNombre, label(label_nombre, 'Nombre')),
  send(LabelNombre, font, font(verdana, bold, 16)),
  send(LabelNombre, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelNombre, point(30, 145)),

  new(TextoNombre, label(texto_nombre, Nombre)),
  send(TextoNombre, font, font(verdana, roman, 16)),
  send(TextoNombre, colour, colour(@default, 60, 60, 60)),
  send(Ventana, display, TextoNombre, point(150, 145)),

  % Boton ver compatibles
  new(BotonCompatibles, button('Ver compatibles', message(@prolog, abrir_compatibles, Ventana, CI))),
  send(BotonCompatibles, font, font(verdana, bold, 18)),
  send(BotonCompatibles, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonCompatibles, point(30, 210)),

  % Boton likear perfiles
  new(BotonLikear, button('Likear perfiles', message(@prolog, abrir_likear, Ventana, CI))),
  send(BotonLikear, font, font(verdana, bold, 18)),
  send(BotonLikear, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonLikear, point(30, 285)),

  % Boton ver matches
  new(BotonMatches, button('Ver matches', message(@prolog, abrir_matches, Ventana, CI))),
  send(BotonMatches, font, font(verdana, bold, 18)),
  send(BotonMatches, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonMatches, point(30, 360)),

  % Boton algoritmo genetico
  new(BotonGenetico, button('Algoritmo Genetico', message(@prolog, abrir_algoritmo_genetico, Ventana, CI))),
  send(BotonGenetico, font, font(verdana, bold, 18)),
  send(BotonGenetico, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonGenetico, point(30, 435)),

  % Boton redefinir preferencias
  new(BotonPreferencias, button('Redefinir preferencias', message(@prolog, abrir_preferencias, Ventana, CI))),
  send(BotonPreferencias, font, font(verdana, bold, 18)),
  send(BotonPreferencias, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonPreferencias, point(30, 510)),

  % Boton volver
  new(BotonVolver, button('Volver al login', message(@prolog, volver_login, Ventana))),
  send(BotonVolver, font, font(verdana, bold, 18)),
  send(BotonVolver, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonVolver, point(30, 605)),



  send(Ventana, open).
%

%Para volver al menu principal desde redefinir preferencias
volver_desde_preferencias(Ventana, CI, menu) :-
  send(Ventana, destroy),
  ventana_menu(CI).
%

%Para volver al menu del resto de las ventanas
volver_menu(Ventana, CI) :-
  send(Ventana, destroy),
  ventana_menu(CI).
%

%Funcion auxiliar para borrar el usuario que estaba creando
borrar_perfil_incompleto(CI) :-
  retractall(perfil_nombre(CI, _)),
  retractall(perfil_caracteristicas(CI, _)),
  retractall(perfil_preferencia(CI, _)),
  retractall(signos_excluidos_temporal(CI, _)).
%


%-------------------------------------------------------------------------------------------------------------------------------------------------------------------
%Ver compatibles
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
abrir_compatibles(Ventana, CI) :-
  send(Ventana, destroy),
  ventana_compatibles(CI).
%

ventana_compatibles(CI) :-
  compatibles_mutuos_de(CI, Compatibles),
  retractall(compatibles_temporal(CI, _)),
  assertz(compatibles_temporal(CI, Compatibles)),
  mostrar_compatible_por_posicion(CI, 1).
%

mostrar_compatible_por_posicion(CI, _) :-
  compatibles_temporal(CI, []),
  ventana_no_mas_compatibles(CI),
  !.

mostrar_compatible_por_posicion(CI, Posicion) :-
  compatibles_temporal(CI, Compatibles),
  nth1(Posicion, Compatibles, CICompatible),
  perfil_nombre(CICompatible, Nombre),
  perfil_caracteristicas(CICompatible, Caracteristicas),
  estado_perfil(CI, CICompatible, Estado),
  ventana_perfil_compatible(CI, Posicion, CICompatible, Nombre, Caracteristicas, Estado).
%

ventana_perfil_compatible(CI, Posicion, CICompatible, Nombre, Caracteristicas, Estado) :-
  compatibles_temporal(CI, Compatibles),
  length(Compatibles, Total),

  new(Ventana, dialog('UM Match - Compatibles')),
  send(Ventana, size, size(800, 850)),

  new(Titulo, label(titulo, 'Perfil compatible')),
  send(Titulo, font, font(verdana, bold, 28)),
  send(Titulo, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, Titulo),

  % Nombre
  mostrar_texto(Ventana, 'Nombre', Nombre, 80, 90),

  % Cedula
  mostrar_texto(Ventana, 'Cedula', CICompatible, 450, 90),

  % Caracteristicas en dos columnas
  mostrar_caracteristica(Ventana, Caracteristicas, sexo, 'Sexo', 80, 170),
  mostrar_caracteristica(Ventana, Caracteristicas, estado_civil, 'Estado civil', 80, 245),
  mostrar_caracteristica(Ventana, Caracteristicas, edad, 'Edad', 80, 320),
  mostrar_caracteristica(Ventana, Caracteristicas, altura, 'Altura', 80, 395),
  mostrar_caracteristica(Ventana, Caracteristicas, departamento, 'Departamento', 80, 470),
  mostrar_caracteristica(Ventana, Caracteristicas, ojos, 'Ojos', 80, 545),

  mostrar_caracteristica(Ventana, Caracteristicas, pelo, 'Pelo', 450, 170),
  mostrar_caracteristica(Ventana, Caracteristicas, carrera, 'Carrera', 450, 245),
  mostrar_caracteristica(Ventana, Caracteristicas, signo, 'Signo', 450, 320),
  mostrar_caracteristica(Ventana, Caracteristicas, deporte, 'Deporte', 450, 395),
  mostrar_caracteristica(Ventana, Caracteristicas, cita_ideal, 'Cita ideal', 450, 470),
  mostrar_caracteristica(Ventana, Caracteristicas, fuma, 'Fuma', 450, 545),
  mostrar_caracteristica(Ventana, Caracteristicas, toma, 'Toma', 450, 620),

  % Coincidencias con mis preferencias
  mostrar_coincidencias(Ventana, CI, CICompatible, 80, 660),

  % Estado
  new(LabelEstado, label(label_estado, 'Estado')),
  send(LabelEstado, font, font(verdana, bold, 16)),
  send(LabelEstado, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelEstado, point(80, 720)),

  new(TextoEstado, label(texto_estado, Estado)),
  send(TextoEstado, font, font(verdana, roman, 16)),
  send(TextoEstado, colour, colour(@default, 60, 60, 60)),
  send(Ventana, display, TextoEstado, point(180, 720)),

  % Numero de perfil actual
  atomic_list_concat([Posicion, '/', Total], TextoPosicion),

  new(LabelPosicion, label(label_posicion, TextoPosicion)),
  send(LabelPosicion, font, font(verdana, bold, 16)),
  send(LabelPosicion, colour, colour(@default, 60, 60, 60)),
  send(Ventana, display, LabelPosicion, point(700, 720)),

  % Boton anterior
  new(BotonAnterior, button('Anterior', message(@prolog, compatible_anterior, Ventana, CI, Posicion))),
  send(BotonAnterior, font, font(verdana, bold, 18)),
  send(BotonAnterior, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonAnterior, point(100, 780)),

  % Boton siguiente
  new(BotonSiguiente, button('Siguiente', message(@prolog, compatible_siguiente, Ventana, CI, Posicion))),
  send(BotonSiguiente, font, font(verdana, bold, 18)),
  send(BotonSiguiente, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonSiguiente, point(330, 780)),

  % Boton salir
  new(BotonSalir, button('Salir', message(@prolog, salir_compatibles, Ventana, CI))),
  send(BotonSalir, font, font(verdana, bold, 18)),
  send(BotonSalir, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonSalir, point(570, 780)),

  send(Ventana, open).
%

estado_perfil(CI, CICompatible, 'Likeado') :-
  like(CI, CICompatible),
  !.

estado_perfil(CI, CICompatible, 'Descartado') :-
  descartado(CI, CICompatible),
  !.

estado_perfil(_, _, 'Por likear').


compatible_siguiente(Ventana, CI, Posicion) :-
  send(Ventana, destroy),
  compatibles_temporal(CI, Compatibles),
  length(Compatibles, Total),
  (Posicion>=Total-> 
    NuevaPosicion = 1;
    NuevaPosicion is Posicion+1),
  mostrar_compatible_por_posicion(CI, NuevaPosicion).


%

compatible_anterior(Ventana, CI, Posicion) :-
  send(Ventana, destroy),
  compatibles_temporal(CI, Compatibles),
  length(Compatibles, Total),
  
  (Posicion =< 1 ->
      NuevaPosicion = Total;
      NuevaPosicion is Posicion - 1
  ),
  mostrar_compatible_por_posicion(CI, NuevaPosicion).
%

salir_compatibles(Ventana, CI) :-
  retractall(compatibles_temporal(CI, _)),
  send(Ventana, destroy),
  ventana_menu(CI).
%

ventana_no_mas_compatibles(CI) :-
  new(Ventana, dialog('UM Match - Compatibles')),
  send(Ventana, size, size(700, 500)),

  new(Titulo, label(titulo, 'Compatibles')),
  send(Titulo, font, font(verdana, bold, 28)),
  send(Titulo, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, Titulo),

  new(Mensaje, label(mensaje, 'No hay perfiles compatibles para mostrar.')),
  send(Mensaje, font, font(verdana, roman, 16)),
  send(Mensaje, colour, colour(@default, 60, 60, 60)),
  send(Ventana, display, Mensaje, point(110, 180)),

  new(BotonVolver, button('Volver al menu', message(@prolog, salir_compatibles, Ventana, CI))),
  send(BotonVolver, font, font(verdana, bold, 18)),
  send(BotonVolver, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonVolver, point(250, 320)),

  send(Ventana, open).
%

% Muestra un dato simple como texto: titulo + valor.
mostrar_texto(Ventana, TextoLabel, Valor, X, Y) :-
  new(Label, label(label_texto, TextoLabel)),
  send(Label, font, font(verdana, bold, 15)),
  send(Label, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, Label, point(X, Y)),

  YValor is Y + 25,

  new(Texto, label(valor_texto, Valor)),
  send(Texto, font, font(verdana, roman, 15)),
  send(Texto, colour, colour(@default, 60, 60, 60)),
  send(Ventana, display, Texto, point(X, YValor)).
%

% Muestra una caracteristica si existe.
mostrar_caracteristica(Ventana, Caracteristicas, Atributo, TextoLabel, X, Y) :-
  Termino =.. [Atributo, Valor],
  member(Termino, Caracteristicas),
  !,
  mostrar_texto(Ventana, TextoLabel, Valor, X, Y).
%

% Si la caracteristica no existe, no muestra nada y no rompe.
mostrar_caracteristica(_, _, _, _, _, _).
%

% Muestra las coincidencias con las preferencias del usuario.
mostrar_coincidencias(Ventana, CI, CICompatible, X, Y) :-
  por_que_compatible(CI, CICompatible, Coincidencias),
  texto_coincidencias(Coincidencias, TextoCoincidencias),

  new(LabelCoincidencias, label(label_coincidencias, 'Coincidencias')),
  send(LabelCoincidencias, font, font(verdana, bold, 16)),
  send(LabelCoincidencias, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelCoincidencias, point(X, Y)),

  YTexto is Y + 25,

  new(Texto, label(texto_coincidencias, TextoCoincidencias)),
  send(Texto, font, font(verdana, roman, 13)),
  send(Texto, colour, colour(@default, 60, 60, 60)),
  send(Ventana, display, Texto, point(X, YTexto)).
%

texto_coincidencias([], 'Ninguna').

texto_coincidencias(Coincidencias, Texto) :-
  Coincidencias \= [],
  atomic_list_concat(Coincidencias, ', ', Texto).
%

%----------------------------------------------------------------------------------------------------------------------------------------------------
%Likear perfiles
%----------------------------------------------------------------------------------------------------------------------------------------------------
% Abre la ventana de likear desde el menu principal.
abrir_likear(VentanaMenu, CI) :-
  send(VentanaMenu, destroy),
  iniciar_likear(CI).
%

% Calcula la lista de perfiles compatibles mutuos que todavia no fueron vistos.
iniciar_likear(CI) :-
  compatibles_mutuos_de(CI, Compatibles),
  filtrar_perfiles_pendientes(CI, Compatibles, Pendientes),
  retractall(likear_temporal(CI, _)),
  assertz(likear_temporal(CI, Pendientes)),
  mostrar_likear_por_posicion(CI, 1).
%

% Si no hay perfiles pendientes
mostrar_likear_por_posicion(CI, _) :-
  likear_temporal(CI, []),
  ventana_sin_mas_perfiles(CI),
  !.
%

% Si la posicion se pasa del total, vuelve al primero
mostrar_likear_por_posicion(CI, Posicion) :-
  likear_temporal(CI, Pendientes),
  length(Pendientes, Total),
  Total > 0,
  (
    Posicion > Total ->
      PosicionFinal = 1
    ;
      PosicionFinal = Posicion
  ),
  nth1(PosicionFinal, Pendientes, CICompatible),
  perfil_nombre(CICompatible, Nombre),
  perfil_caracteristicas(CICompatible, Caracteristicas),
  ventana_perfil_likear(CI, PosicionFinal, CICompatible, Nombre, Caracteristicas).
%

% Ventana que muestra un perfil compatible para likear.
ventana_perfil_likear(CI, Posicion, CICompatible, Nombre, Caracteristicas) :-
  likear_temporal(CI, Pendientes),
  length(Pendientes, Total),

  new(Ventana, dialog('UM Match - Likear perfiles')),
  send(Ventana, size, size(800, 900)),

  new(Titulo, label(titulo, 'Perfil compatible')),
  send(Titulo, font, font(verdana, bold, 28)),
  send(Titulo, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, Titulo),

  % Nombre
  mostrar_texto(Ventana, 'Nombre', Nombre, 80, 90),

  % Cedula
  mostrar_texto(Ventana, 'Cedula', CICompatible, 450, 90),

  % Caracteristicas en dos columnas
  mostrar_caracteristica(Ventana, Caracteristicas, sexo, 'Sexo', 80, 170),
  mostrar_caracteristica(Ventana, Caracteristicas, estado_civil, 'Estado civil', 80, 245),
  mostrar_caracteristica(Ventana, Caracteristicas, edad, 'Edad', 80, 320),
  mostrar_caracteristica(Ventana, Caracteristicas, altura, 'Altura', 80, 395),
  mostrar_caracteristica(Ventana, Caracteristicas, departamento, 'Departamento', 80, 470),
  mostrar_caracteristica(Ventana, Caracteristicas, ojos, 'Ojos', 80, 545),

  mostrar_caracteristica(Ventana, Caracteristicas, pelo, 'Pelo', 450, 170),
  mostrar_caracteristica(Ventana, Caracteristicas, carrera, 'Carrera', 450, 245),
  mostrar_caracteristica(Ventana, Caracteristicas, signo, 'Signo', 450, 320),
  mostrar_caracteristica(Ventana, Caracteristicas, deporte, 'Deporte', 450, 395),
  mostrar_caracteristica(Ventana, Caracteristicas, cita_ideal, 'Cita ideal', 450, 470),
  mostrar_caracteristica(Ventana, Caracteristicas, fuma, 'Fuma', 450, 545),
  mostrar_caracteristica(Ventana, Caracteristicas, toma, 'Toma', 450, 620),

  % Coincidencias con mis preferencias
  mostrar_coincidencias(Ventana, CI, CICompatible, 80, 685),

  % Numero de perfil actual, ejemplo 1/5
  atomic_list_concat([Posicion, '/', Total], TextoPosicion),

  new(LabelPosicion, label(label_posicion, TextoPosicion)),
  send(LabelPosicion, font, font(verdana, bold, 16)),
  send(LabelPosicion, colour, colour(@default, 60, 60, 60)),
  send(Ventana, display, LabelPosicion, point(700, 730)),

  % Boton Volver
  new(BotonVolver, button('Volver', message(@prolog, salir_likear, Ventana, CI))),
  send(BotonVolver, font, font(verdana, bold, 18)),
  send(BotonVolver, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonVolver, point(120, 800)),

  % Boton Likear
  new(BotonLikear, button('Likear', message(@prolog, accion_likear, Ventana, CI, Posicion))),
  send(BotonLikear, font, font(verdana, bold, 18)),
  send(BotonLikear, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonLikear, point(330, 800)),

  % Boton Pasar
  new(BotonSiguiente, button('Pasar', message(@prolog, accion_siguiente, Ventana, CI, Posicion))),
  send(BotonSiguiente, font, font(verdana, bold, 18)),
  send(BotonSiguiente, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonSiguiente, point(530, 800)),

  send(Ventana, open).
%

% Boton Likear: guarda el like, saca el perfil de la lista temporal y muestra el siguiente.
accion_likear(Ventana, CI, Posicion) :-
  likear_temporal(CI, Pendientes),
  nth1(Posicion, Pendientes, CICompatible),

  dar_like(CI, CICompatible),

  sacar_de_lista(CICompatible, Pendientes, NuevosPendientes),
  retractall(likear_temporal(CI, _)),
  assertz(likear_temporal(CI, NuevosPendientes)),

  send(Ventana, destroy),
  mostrar_likear_por_posicion(CI, Posicion).
%

% Boton Pasar: descarta el perfil, lo saca de la lista temporal y muestra el siguiente.
accion_siguiente(Ventana, CI, Posicion) :-
  likear_temporal(CI, Pendientes),
  nth1(Posicion, Pendientes, CICompatible),

  assertz(descartado(CI, CICompatible)),

  sacar_de_lista(CICompatible, Pendientes, NuevosPendientes),
  retractall(likear_temporal(CI, _)),
  assertz(likear_temporal(CI, NuevosPendientes)),

  send(Ventana, destroy),
  mostrar_likear_por_posicion(CI, Posicion).
%

% Saca un elemento de una lista
sacar_de_lista(_, [], []).

sacar_de_lista(Elemento, [Elemento | Resto], Resto) :-
  !.

sacar_de_lista(Elemento, [Cabeza | Resto], [Cabeza | Resultado]) :-
  sacar_de_lista(Elemento, Resto, Resultado).
%

% Salir desde likear perfiles
salir_likear(Ventana, CI) :-
  retractall(likear_temporal(CI, _)),
  send(Ventana, destroy),
  ventana_menu(CI).
%

% Ventana final cuando no quedan mas perfiles.
ventana_sin_mas_perfiles(CI) :-
  retractall(likear_temporal(CI, _)),

  new(Ventana, dialog('UM Match - Likear perfiles')),
  send(Ventana, size, size(700, 500)),

  new(Titulo, label(titulo, 'Likear perfiles')),
  send(Titulo, font, font(verdana, bold, 28)),
  send(Titulo, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, Titulo),

  new(Mensaje, label(mensaje, 'No hay mas perfiles compatibles para mostrar.')),
  send(Mensaje, font, font(verdana, roman, 16)),
  send(Mensaje, colour, colour(@default, 60, 60, 60)),
  send(Ventana, display, Mensaje, point(80, 180)),

  new(BotonVolver, button('Volver', message(@prolog, volver_menu, Ventana, CI))),
  send(BotonVolver, font, font(verdana, bold, 18)),
  send(BotonVolver, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonVolver, point(80, 330)),

  send(Ventana, open).
%

% Filtra perfiles que ya fueron likeados o descartados.
filtrar_perfiles_pendientes(_, [], []).

filtrar_perfiles_pendientes(CI, [Otro | Resto], Resultado) :-
  like(CI, Otro),
  !,
  filtrar_perfiles_pendientes(CI, Resto, Resultado).

filtrar_perfiles_pendientes(CI, [Otro | Resto], Resultado) :-
  descartado(CI, Otro),
  !,
  filtrar_perfiles_pendientes(CI, Resto, Resultado).

filtrar_perfiles_pendientes(CI, [Otro | Resto], [Otro | Resultado]) :-
  filtrar_perfiles_pendientes(CI, Resto, Resultado).
%

%----------------------------------------------------------------------------------------------------------------------------------------------------
%Ver Matches
%----------------------------------------------------------------------------------------------------------------------------------------------------

abrir_matches(Ventana, CI) :-
  ventana_matches(CI),
  send(Ventana, destroy).
%

ventana_matches(CI) :-
  matches_de(CI, Matches),
  (
    Matches = [] ->
      ventana_no_mas_matches(CI)
    ;
      retractall(matches_temporal(CI, _)),
      assertz(matches_temporal(CI, Matches)),
      mostrar_match_por_posicion(CI, 1)
  ).
%

mostrar_match_por_posicion(CI, _) :-
  matches_temporal(CI, []),
  ventana_no_mas_matches(CI),
  !.

mostrar_match_por_posicion(CI, Posicion) :-
  matches_temporal(CI, Matches),
  nth1(Posicion, Matches, CIMatch),
  perfil_nombre(CIMatch, Nombre),
  perfil_caracteristicas(CIMatch, Caracteristicas),
  ventana_perfil_match(CI, Posicion, CIMatch, Nombre, Caracteristicas).
%

ventana_perfil_match(CI, Posicion, CIMatch, Nombre, Caracteristicas) :-
  matches_temporal(CI, Matches),
  length(Matches, Total),

  new(Ventana, dialog('UM Match - Matches')),
  send(Ventana, size, size(800, 850)),

  new(Titulo, label(titulo, 'Perfil de match')),
  send(Titulo, font, font(verdana, bold, 28)),
  send(Titulo, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, Titulo),

  % Nombre
  mostrar_texto(Ventana, 'Nombre', Nombre, 80, 90),

  % Cedula
  mostrar_texto(Ventana, 'Cedula', CIMatch, 450, 90),

  % Caracteristicas en dos columnas
  mostrar_caracteristica(Ventana, Caracteristicas, sexo, 'Sexo', 80, 170),
  mostrar_caracteristica(Ventana, Caracteristicas, estado_civil, 'Estado civil', 80, 245),
  mostrar_caracteristica(Ventana, Caracteristicas, edad, 'Edad', 80, 320),
  mostrar_caracteristica(Ventana, Caracteristicas, altura, 'Altura', 80, 395),
  mostrar_caracteristica(Ventana, Caracteristicas, departamento, 'Departamento', 80, 470),
  mostrar_caracteristica(Ventana, Caracteristicas, ojos, 'Ojos', 80, 545),

  mostrar_caracteristica(Ventana, Caracteristicas, pelo, 'Pelo', 450, 170),
  mostrar_caracteristica(Ventana, Caracteristicas, carrera, 'Carrera', 450, 245),
  mostrar_caracteristica(Ventana, Caracteristicas, signo, 'Signo', 450, 320),
  mostrar_caracteristica(Ventana, Caracteristicas, deporte, 'Deporte', 450, 395),
  mostrar_caracteristica(Ventana, Caracteristicas, cita_ideal, 'Cita ideal', 450, 470),
  mostrar_caracteristica(Ventana, Caracteristicas, fuma, 'Fuma', 450, 545),
  mostrar_caracteristica(Ventana, Caracteristicas, toma, 'Toma', 450, 620),

  % Estado
  new(LabelEstado, label(label_estado, 'Estado')),
  send(LabelEstado, font, font(verdana, bold, 16)),
  send(LabelEstado, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelEstado, point(80, 685)),

  new(TextoEstado, label(texto_estado, 'Match')),
  send(TextoEstado, font, font(verdana, roman, 16)),
  send(TextoEstado, colour, colour(@default, 60, 60, 60)),
  send(Ventana, display, TextoEstado, point(180, 685)),

  % Numero de match actual
  atomic_list_concat([Posicion, '/', Total], TextoPosicion),

  new(LabelPosicion, label(label_posicion, TextoPosicion)),
  send(LabelPosicion, font, font(verdana, bold, 16)),
  send(LabelPosicion, colour, colour(@default, 60, 60, 60)),
  send(Ventana, display, LabelPosicion, point(700, 685)),

  % Boton anterior
  new(BotonAnterior, button('Anterior', message(@prolog, match_anterior, Ventana, CI, Posicion))),
  send(BotonAnterior, font, font(verdana, bold, 18)),
  send(BotonAnterior, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonAnterior, point(100, 750)),

  % Boton siguiente
  new(BotonSiguiente, button('Siguiente', message(@prolog, match_siguiente, Ventana, CI, Posicion))),
  send(BotonSiguiente, font, font(verdana, bold, 18)),
  send(BotonSiguiente, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonSiguiente, point(330, 750)),

  % Boton salir
  new(BotonSalir, button('Salir', message(@prolog, salir_matches, Ventana, CI))),
  send(BotonSalir, font, font(verdana, bold, 18)),
  send(BotonSalir, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonSalir, point(570, 750)),

  send(Ventana, open).
%

% Boton siguiente con ciclo
match_siguiente(Ventana, CI, Posicion) :-
  send(Ventana, destroy),
  matches_temporal(CI, Matches),
  length(Matches, Total),
  (
    Posicion >= Total ->
      NuevaPosicion = 1
    ;
      NuevaPosicion is Posicion + 1
  ),
  mostrar_match_por_posicion(CI, NuevaPosicion).
%

% Boton anterior con ciclo
match_anterior(Ventana, CI, Posicion) :-
  send(Ventana, destroy),
  matches_temporal(CI, Matches),
  length(Matches, Total),
  (
    Posicion =< 1 ->
      NuevaPosicion = Total
    ;
      NuevaPosicion is Posicion - 1
  ),
  mostrar_match_por_posicion(CI, NuevaPosicion).
%


salir_matches(Ventana, CI) :-
  retractall(matches_temporal(CI, _)),
  send(Ventana, destroy),
  ventana_menu(CI).
%

ventana_no_mas_matches(CI) :-
  new(Ventana, dialog('UM Match - Matches')),
  send(Ventana, size, size(700, 500)),

  new(Titulo, label(titulo, 'Matches')),
  send(Titulo, font, font(verdana, bold, 28)),
  send(Titulo, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, Titulo),

  new(Mensaje, label(mensaje, 'No hay matches para mostrar.')),
  send(Mensaje, font, font(verdana, roman, 16)),
  send(Mensaje, colour, colour(@default, 60, 60, 60)),
  send(Ventana, display, Mensaje, point(180, 180)),

  new(BotonVolver, button('Volver al menu', message(@prolog, salir_matches, Ventana, CI))),
  send(BotonVolver, font, font(verdana, bold, 18)),
  send(BotonVolver, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonVolver, point(250, 320)),

  send(Ventana, open).
%


%------------------------------------------------------------------------------------------------------------------------------------------------------
%Algoritmo Genetico
%----------------------------------------------------------------------------------------------------------------------------------------------------------
abrir_algoritmo_genetico(Ventana, CI) :-
  ventana_algoritmo_genetico(CI),
  send(Ventana, destroy).
%

ventana_algoritmo_genetico(CI) :-
  (resultado_algoritmo_para_usuario(CI, CIResultado) ->
    ventana_perfil_algoritmo_genetico(CI, CIResultado);
    ventana_sin_resultado_algoritmo_genetico(CI)).
%

% Ejecuta el algoritmo genetico global y busca la pareja asignada al usuario.
resultado_algoritmo_para_usuario(CI, CIResultado) :-
  matching_global(Asignacion),
  pareja_del_usuario(CI, Asignacion, CIResultado).
%

% Caso donde el usuario aparece primero en el par.
pareja_del_usuario(CI, [(CI, Otro) | _], Otro) :-
  !.

% Caso donde el usuario aparece segundo en el par.
pareja_del_usuario(CI, [(Otro, CI) | _], Otro) :-
  !.

% Caso recursivo: sigo buscando en los otros pares.
pareja_del_usuario(CI, [_ | Resto], Resultado) :-
  pareja_del_usuario(CI, Resto, Resultado).
%

ventana_perfil_algoritmo_genetico(CI, CIResultado) :-
  perfil_nombre(CIResultado, Nombre),
  perfil_caracteristicas(CIResultado, Caracteristicas),

  new(Ventana, dialog('UM Match - Algoritmo Genetico')),
  send(Ventana, size, size(800, 900)),

  new(Titulo, label(titulo, 'Resultado del algoritmo genetico')),
  send(Titulo, font, font(verdana, bold, 28)),
  send(Titulo, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, Titulo),

  % Nombre
  mostrar_texto(Ventana, 'Nombre', Nombre, 80, 90),

  % Cedula
  mostrar_texto(Ventana, 'Cedula', CIResultado, 450, 90),

  % Caracteristicas en dos columnas
  mostrar_caracteristica(Ventana, Caracteristicas, sexo, 'Sexo', 80, 170),
  mostrar_caracteristica(Ventana, Caracteristicas, estado_civil, 'Estado civil', 80, 245),
  mostrar_caracteristica(Ventana, Caracteristicas, edad, 'Edad', 80, 320),
  mostrar_caracteristica(Ventana, Caracteristicas, altura, 'Altura', 80, 395),
  mostrar_caracteristica(Ventana, Caracteristicas, departamento, 'Departamento', 80, 470),
  mostrar_caracteristica(Ventana, Caracteristicas, ojos, 'Ojos', 80, 545),

  mostrar_caracteristica(Ventana, Caracteristicas, pelo, 'Pelo', 450, 170),
  mostrar_caracteristica(Ventana, Caracteristicas, carrera, 'Carrera', 450, 245),
  mostrar_caracteristica(Ventana, Caracteristicas, signo, 'Signo', 450, 320),
  mostrar_caracteristica(Ventana, Caracteristicas, deporte, 'Deporte', 450, 395),
  mostrar_caracteristica(Ventana, Caracteristicas, cita_ideal, 'Cita ideal', 450, 470),
  mostrar_caracteristica(Ventana, Caracteristicas, fuma, 'Fuma', 450, 545),
  mostrar_caracteristica(Ventana, Caracteristicas, toma, 'Toma', 450, 620),

  % Coincidencias con mis preferencias
  mostrar_coincidencias(Ventana, CI, CIResultado, 450, 685),

  new(LabelEstado, label(label_estado, 'Estado')),
  send(LabelEstado, font, font(verdana, bold, 16)),
  send(LabelEstado, colour, colour(@default, 143, 179, 226)),
  send(Ventana, display, LabelEstado, point(80, 730)),

  new(TextoEstado, label(texto_estado, 'Asignado por algoritmo genetico')),
  send(TextoEstado, font, font(verdana, roman, 16)),
  send(TextoEstado, colour, colour(@default, 60, 60, 60)),
  send(Ventana, display, TextoEstado, point(180, 730)),

  new(BotonVolver, button('Volver al menu', message(@prolog, volver_menu, Ventana, CI))),
  send(BotonVolver, font, font(verdana, bold, 18)),
  send(BotonVolver, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonVolver, point(300, 800)),

  send(Ventana, open).
%

ventana_sin_resultado_algoritmo_genetico(CI) :-
  new(Ventana, dialog('UM Match - Algoritmo Genetico')),
  send(Ventana, size, size(700, 500)),

  new(Titulo, label(titulo, 'Algoritmo Genetico')),
  send(Titulo, font, font(verdana, bold, 28)),
  send(Titulo, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, Titulo),

  new(Mensaje, label(mensaje, 'No se encontro un resultado para mostrar.')),
  send(Mensaje, font, font(verdana, roman, 16)),
  send(Mensaje, colour, colour(@default, 60, 60, 60)),
  send(Ventana, display, Mensaje, point(110, 180)),

  new(BotonVolver, button('Volver al menu', message(@prolog, volver_menu, Ventana, CI))),
  send(BotonVolver, font, font(verdana, bold, 18)),
  send(BotonVolver, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonVolver, point(250, 320)),

  send(Ventana, open).
%




%----------------------------------------------------------------------------------------------------------------------------------------------------
%Redefinir preferencias
%----------------------------------------------------------------------------------------------------------------------------------------------------
%Para redefinir preferencias usamos la misma ventana que para definir preferencias pero hacemos que cuando se inicializa, ya aparezcan las preferencias del usuario seleccionadas.

abrir_preferencias(Ventana, CI):-
  send(Ventana, destroy),
  ventana_definir_preferencias(CI, menu).
%

%Funcion auxiliar para acceder a las preferencias de la lista
obtener_preferencia(sexo, ListaPreferencias, Valor) :-
  member(pref(busca_sexo, Valor), ListaPreferencias).

obtener_preferencia(fuma, ListaPreferencias, Valor) :-
  member(pref(busca_fuma, Valor), ListaPreferencias).

obtener_preferencia(toma, ListaPreferencias, Valor) :-
  member(pref(busca_toma, Valor), ListaPreferencias).

obtener_preferencia(estado_civil, ListaPreferencias, Valor) :-
  member(pref(busca_estado_civil, Valor), ListaPreferencias).

obtener_preferencia(edad_min, ListaPreferencias, Valor) :-
  member(pref_rango(edad, Valor, _), ListaPreferencias).

obtener_preferencia(edad_max, ListaPreferencias, Valor) :-
  member(pref_rango(edad, _, Valor), ListaPreferencias).

obtener_preferencia(altura_min, ListaPreferencias, Valor) :-
  member(pref_rango(altura, Valor, _), ListaPreferencias).

obtener_preferencia(altura_max, ListaPreferencias, Valor) :-
  member(pref_rango(altura, _, Valor), ListaPreferencias).

obtener_preferencia(departamento, ListaPreferencias, Valor) :-
  member(pref(departamento, Valor), ListaPreferencias).

obtener_preferencia(ojos, ListaPreferencias, Valor) :-
  member(pref(ojos, Valor), ListaPreferencias).

obtener_preferencia(pelo, ListaPreferencias, Valor) :-
  member(pref(pelo, Valor), ListaPreferencias).

obtener_preferencia(carrera, ListaPreferencias, Valor) :-
  member(pref(carrera, Valor), ListaPreferencias).

obtener_preferencia(signo, ListaPreferencias, Valor) :-
  member(pref(signo, Valor), ListaPreferencias).

obtener_preferencia(deporte, ListaPreferencias, Valor) :-
  member(pref(deporte, Valor), ListaPreferencias).

obtener_preferencia(cita_ideal, ListaPreferencias, Valor) :-
  member(pref(cita_ideal, Valor), ListaPreferencias).
%

%Funcion para rellenar campos de texto
cargar_valor_texto(Campo, NombrePreferencia, ListaPreferencias) :-
  (obtener_preferencia(NombrePreferencia, ListaPreferencias, Valor)->
    atom_number(TextoValor, Valor),
    send(Campo, selection, TextoValor);
    true).

%

%Funcion para rellenar menus
cargar_valor_menu(Menu, NombrePreferencia, ListaPreferencias) :-
  (obtener_preferencia(NombrePreferencia, ListaPreferencias, Valor)->
    send(Menu, selection, Valor);
    true).
  %










