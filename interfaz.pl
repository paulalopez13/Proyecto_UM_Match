%% Este archivo se usa para crear las ventanas para interactuar con el programa

%%Libreria que se usa para crear las ventanas
:- use_module(library(pce)).

:- dynamic signos_excluidos_temporal/2.


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

  %Abrir la ventana
  send(Ventana, open).

%

%Volver al login desde otra ventana
volver_login(Ventana) :-
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
  send(Ventana, size, size(700, 1000)),

  %Titulo 
  new(Titulo, label(titulo, 'Registro de perfil')),
  send(Titulo, font, font(verdana, bold, 28)),
  send(Titulo, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, Titulo),


  %Cedula de usuario q se esta registrando
  new(TextoCI, label(texto_ci, 'Cedula:')),
  send(TextoCI, font, font(verdana, roman, 11)),
  send(TextoCI, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, TextoCI),
  
  new(LabelCI, label(label_ci, CI)),
  send(LabelCI, font, font(verdana, roman, 11)),
  send(LabelCI, colour, colour(@default, 60, 60, 60)),
  send(Ventana, append, LabelCI),

  %Ingreso de nombre
  new(LabelNombre, label(label_nombre, 'Nombre')),
  send(LabelNombre, font, font(verdana, roman, 11)),
  send(LabelNombre, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelNombre),

  new(CampoNombre, text_item(nombre)),
  send(CampoNombre, show_label, @off),
  send(CampoNombre, length, 20),
  send(CampoNombre, value_font, font(verdana, roman, 11)),
  send(Ventana, append, CampoNombre),

  %Sexo
  new(LabelSexo, label(label_sexo, 'Sexo')),
  send(LabelSexo, font, font(verdana, roman, 11)),
  send(LabelSexo, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelSexo),

  crear_menu_opciones(sexo, MenuSexo),
  send(Ventana, append, MenuSexo),

  % Edad
  new(LabelEdad, label(label_edad, 'Edad')),
  send(LabelEdad, font, font(verdana, roman, 11)),
  send(LabelEdad, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelEdad),

  new(CampoEdad, text_item(edad)),
  send(CampoEdad, show_label, @off),
  send(CampoEdad, length, 20),
  send(CampoEdad, value_font, font(verdana, roman, 11)),
  send(Ventana, append, CampoEdad),

 % Altura
  new(LabelAltura, label(label_altura, 'Altura')),
  send(LabelAltura, font, font(verdana, roman, 11)),
  send(LabelAltura, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelAltura),

  new(CampoAltura, text_item(altura)),
  send(CampoAltura, show_label, @off),
  send(CampoAltura, length, 20),
  send(CampoAltura, value_font, font(verdana, roman, 11)),
  send(Ventana, append, CampoAltura),

  % Fuma
  new(LabelFuma, label(label_fuma, 'Fuma')),
  send(LabelFuma, font, font(verdana, roman, 11)),
  send(LabelFuma, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelFuma),

  crear_menu_opciones(fuma, MenuFuma),
  send(Ventana, append, MenuFuma),

  % Toma
  new(LabelToma, label(label_toma, 'Toma')),
  send(LabelToma, font, font(verdana, roman, 11)),
  send(LabelToma, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelToma),

  crear_menu_opciones(toma, MenuToma),
  send(Ventana, append, MenuToma),


  % Departamento
  new(LabelDepartamento, label(label_departamento, 'Departamento')),
  send(LabelDepartamento, font, font(verdana, roman, 11)),
  send(LabelDepartamento, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelDepartamento),

  crear_menu_opciones(departamento, MenuDepartamento),
  send(Ventana, append, MenuDepartamento),

  % Ojos
  new(LabelOjos, label(label_ojos, 'Ojos')),
  send(LabelOjos, font, font(verdana, roman, 11)),
  send(LabelOjos, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelOjos),

  crear_menu_opciones(ojos, MenuOjos),
  send(Ventana, append, MenuOjos),

  % Pelo
  new(LabelPelo, label(label_pelo, 'Pelo')),
  send(LabelPelo, font, font(verdana, roman, 11)),
  send(LabelPelo, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelPelo),

  crear_menu_opciones(pelo, MenuPelo),
  send(Ventana, append, MenuPelo),

  % Carrera
  new(LabelCarrera, label(label_carrera, 'Carrera')),
  send(LabelCarrera, font, font(verdana, roman, 11)),
  send(LabelCarrera, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelCarrera),

  crear_menu_opciones(carrera, MenuCarrera),
  send(Ventana, append, MenuCarrera),

  % Signo
  new(LabelSigno, label(label_signo, 'Signo')),
  send(LabelSigno, font, font(verdana, roman, 11)),
  send(LabelSigno, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelSigno),

  crear_menu_opciones(signo, MenuSigno),
  send(Ventana, append, MenuSigno),

  % Deporte
  new(LabelDeporte, label(label_deporte, 'Deporte')),
  send(LabelDeporte, font, font(verdana, roman, 11)),
  send(LabelDeporte, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelDeporte),

  crear_menu_opciones(deporte, MenuDeporte),
  send(Ventana, append, MenuDeporte),

  % Cita ideal
  new(LabelCitaIdeal, label(label_cita_ideal, 'Cita ideal')),
  send(LabelCitaIdeal, font, font(verdana, roman, 11)),
  send(LabelCitaIdeal, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelCitaIdeal),

  crear_menu_opciones(cita_ideal, MenuCitaIdeal),
  send(Ventana, append, MenuCitaIdeal),
  
  % Espacio visual
  new(Espacio2, label(espacio2, '')),
  send(Espacio2, size, size(1, 25)),
  send(Ventana, append, Espacio2),

  % Boton guardar perfil
  new(BotonGuardar, button('Guardar perfil', message(@prolog, procesar_registro,Ventana, CI, CampoNombre, CampoEdad, MenuSexo, CampoAltura, MenuDepartamento, MenuOjos, MenuPelo, MenuCarrera, MenuSigno, MenuDeporte, MenuCitaIdeal, MenuFuma, MenuToma))),
  send(BotonGuardar, font, font(verdana, bold, 20)),
  send(BotonGuardar, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonGuardar, point(470, 820)),

  % Boton volver
  new(BotonVolver, button('Volver', message(@prolog, volver_login, Ventana))),
  send(BotonVolver, font, font(verdana, bold, 20)),
  send(BotonVolver, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonVolver, point(580, 890)),

  % Abrimos la ventana
  send(Ventana, open).
%


%-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%Procesar Registro
%----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
procesar_registro(Ventana, CI, CampoNombre, CampoEdad, MenuSexo, CampoAltura, MenuDepartamento, MenuOjos, MenuPelo, MenuCarrera, MenuSigno, MenuDeporte, MenuCitaIdeal, MenuFuma, MenuToma):-

  %1. sacamos los datos de los campos de texto
  get(CampoNombre, selection, Nombre),
  get(CampoEdad, selection, TextoEdad),
  get(CampoAltura, selection, TextoAltura),

  atom_number(TextoEdad, Edad),
  atom_number(TextoAltura, Altura),

  %2. sacamos los datos de los menus
  get(MenuSexo, selection, Sexo),
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
  ListaAtributos = [sexo(Sexo), fuma(Fuma), toma(Toma), signo(Signo), edad(Edad), altura(Altura), departamento(Departamento), ojos(Ojos), pelo(Pelo), carrera(Carrera), deporte(Deporte), cita_ideal(CitaIdeal)],

  %4. Creamos y guardamos el perfil
  crear_perfil(CI, Nombre, ListaAtributos),
 
  %5 Nos vamos al Menu principal
  send(Ventana, destroy),
  ventana_definir_preferencias(CI).
%


%-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%Definicion Inicial de Preferencias
%----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ventana_definir_preferencias(CI):-
  
  new(Ventana, dialog('UM Match - Preferencias')),
  send(Ventana, size, size(700, 1000)),

  new(Titulo, label(titulo, 'Definicion de Preferencias')),
  send(Titulo, font, font(verdana, bold, 26)),
  send(Titulo, colour, colour(@default, 49, 65, 122)),
  send(Ventana, append, Titulo),

  % Edad minima
  new(LabelEdadMin, label(label_pref_edad_min, 'Edad minima')),
  send(LabelEdadMin, font, font(verdana, roman, 11)),
  send(LabelEdadMin, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelEdadMin),

  new(CampoEdadMin, text_item(edad_min)),
  send(CampoEdadMin, show_label, @off),
  send(CampoEdadMin, length, 10),
  send(CampoEdadMin, value_font, font(verdana, roman, 11)),
  send(Ventana, append, CampoEdadMin),

  % Edad maxima
  new(LabelEdadMax, label(label_pref_edad_max, 'Edad maxima')),
  send(LabelEdadMax, font, font(verdana, roman, 11)),
  send(LabelEdadMax, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelEdadMax),

  new(CampoEdadMax, text_item(edad_max)),
  send(CampoEdadMax, show_label, @off),
  send(CampoEdadMax, length, 10),
  send(CampoEdadMax, value_font, font(verdana, roman, 11)),
  send(Ventana, append, CampoEdadMax),

  % Sexo
  new(LabelSexo, label(label_pref_sexo, 'Sexo buscado')),
  send(LabelSexo, font, font(verdana, roman, 11)),
  send(LabelSexo, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelSexo),

  crear_menu_opciones(sexo, MenuSexo),
  send(Ventana, append, MenuSexo),

  % Altura minima
  new(LabelAlturaMin, label(label_pref_altura_min, 'Altura minima')),
  send(LabelAlturaMin, font, font(verdana, roman, 11)),
  send(LabelAlturaMin, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelAlturaMin),

  new(CampoAlturaMin, text_item(altura_min)),
  send(CampoAlturaMin, show_label, @off),
  send(CampoAlturaMin, length, 10),
  send(CampoAlturaMin, value_font, font(verdana, roman, 11)),
  send(Ventana, append, CampoAlturaMin),

  % Altura maxima
  new(LabelAlturaMax, label(label_pref_altura_max, 'Altura maxima')),
  send(LabelAlturaMax, font, font(verdana, roman, 11)),
  send(LabelAlturaMax, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelAlturaMax),

  new(CampoAlturaMax, text_item(altura_max)),
  send(CampoAlturaMax, show_label, @off),
  send(CampoAlturaMax, length, 10),
  send(CampoAlturaMax, value_font, font(verdana, roman, 11)),
  send(Ventana, append, CampoAlturaMax),

  % Departamento
  new(LabelDepartamento, label(label_pref_departamento, 'Departamento')),
  send(LabelDepartamento, font, font(verdana, roman, 11)),
  send(LabelDepartamento, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelDepartamento),

  crear_menu_opciones(departamento, MenuDepartamento),
  send(Ventana, append, MenuDepartamento),

  % Ojos
  new(LabelOjos, label(label_pref_ojos, 'Ojos')),
  send(LabelOjos, font, font(verdana, roman, 11)),
  send(LabelOjos, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelOjos),

  crear_menu_opciones(ojos, MenuOjos),
  send(Ventana, append, MenuOjos),

  % Pelo
  new(LabelPelo, label(label_pref_pelo, 'Pelo')),
  send(LabelPelo, font, font(verdana, roman, 11)),
  send(LabelPelo, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelPelo),

  crear_menu_opciones(pelo, MenuPelo),
  send(Ventana, append, MenuPelo),

  % Carrera
  new(LabelCarrera, label(label_pref_carrera, 'Carrera')),
  send(LabelCarrera, font, font(verdana, roman, 11)),
  send(LabelCarrera, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelCarrera),

  crear_menu_opciones(carrera, MenuCarrera),
  send(Ventana, append, MenuCarrera),

  % Signo
  new(LabelSigno, label(label_pref_signo, 'Signo')),
  send(LabelSigno, font, font(verdana, roman, 11)),
  send(LabelSigno, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelSigno),

  crear_menu_opciones(signo, MenuSigno),
  send(Ventana, append, MenuSigno),

  % Deporte
  new(LabelDeporte, label(label_pref_deporte, 'Deporte')),
  send(LabelDeporte, font, font(verdana, roman, 11)),
  send(LabelDeporte, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelDeporte),

  crear_menu_opciones(deporte, MenuDeporte),
  send(Ventana, append, MenuDeporte),

  % Cita ideal
  new(LabelCitaIdeal, label(label_pref_cita_ideal, 'Cita ideal')),
  send(LabelCitaIdeal, font, font(verdana, roman, 11)),
  send(LabelCitaIdeal, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelCitaIdeal),

  crear_menu_opciones(cita_ideal, MenuCitaIdeal),
  send(Ventana, append, MenuCitaIdeal),

  % Fuma
  new(LabelFuma, label(label_pref_fuma, 'Fuma')),
  send(LabelFuma, font, font(verdana, roman, 11)),
  send(LabelFuma, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelFuma),

  crear_menu_opciones(fuma, MenuFuma),
  send(Ventana, append, MenuFuma),

  % Toma
  new(LabelToma, label(label_pref_toma, 'Toma')),
  send(LabelToma, font, font(verdana, roman, 11)),
  send(LabelToma, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelToma),

  crear_menu_opciones(toma, MenuToma),
  send(Ventana, append, MenuToma),

  %Signos excluidos
  new(BotonExcluirSignos, button('Signos no deseados', message(@prolog, ventana_excluir_signos,CI))),
  send(BotonExcluirSignos, font, font(verdana, bold, 16)),
  send(BotonExcluirSignos, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonExcluirSignos, point(445, 760)),


  %Guardar
   % Boton guardar preferencias
  new(BotonGuardar, button('Guardar preferencias', message(@prolog, procesar_preferencias, Ventana, CI, CampoEdadMin, CampoEdadMax, MenuSexo, CampoAlturaMin, CampoAlturaMax, MenuDepartamento, MenuOjos, MenuPelo, MenuCarrera, MenuSigno, MenuDeporte, MenuCitaIdeal, MenuFuma, MenuToma))),
  send(BotonGuardar, font, font(verdana, bold, 18)),
  send(BotonGuardar, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonGuardar, point(395, 870)),

  % Boton volver
  new(BotonVolver, button('Volver', message(@prolog, volver_login, Ventana))),
  send(BotonVolver, font, font(verdana, bold, 18)),
  send(BotonVolver, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonVolver, point(595, 920)),

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
  send(LabelAries, font, font(verdana, roman, 12)),
  send(LabelAries, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelAries),

  new(MenuAries, menu(aries, cycle)),
  send(MenuAries, show_label, @off),
  send(MenuAries, append, no),
  send(MenuAries, append, si),
  send(MenuAries, selection, no),
  send(Ventana, append, MenuAries),

  % Tauro
  new(LabelTauro, label(label_tauro, 'Tauro')),
  send(LabelTauro, font, font(verdana, roman, 12)),
  send(LabelTauro, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelTauro),

  new(MenuTauro, menu(tauro, cycle)),
  send(MenuTauro, show_label, @off),
  send(MenuTauro, append, no),
  send(MenuTauro, append, si),
  send(MenuTauro, selection, no),
  send(Ventana, append, MenuTauro),

  % Geminis
  new(LabelGeminis, label(label_geminis, 'Geminis')),
  send(LabelGeminis, font, font(verdana, roman, 12)),
  send(LabelGeminis, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelGeminis),

  new(MenuGeminis, menu(geminis, cycle)),
  send(MenuGeminis, show_label, @off),
  send(MenuGeminis, append, no),
  send(MenuGeminis, append, si),
  send(MenuGeminis, selection, no),
  send(Ventana, append, MenuGeminis),

  % Cancer
  new(LabelCancer, label(label_cancer, 'Cancer')),
  send(LabelCancer, font, font(verdana, roman, 12)),
  send(LabelCancer, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelCancer),

  new(MenuCancer, menu(cancer, cycle)),
  send(MenuCancer, show_label, @off),
  send(MenuCancer, append, no),
  send(MenuCancer, append, si),
  send(MenuCancer, selection, no),
  send(Ventana, append, MenuCancer),

  % Leo
  new(LabelLeo, label(label_leo, 'Leo')),
  send(LabelLeo, font, font(verdana, roman, 12)),
  send(LabelLeo, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelLeo),

  new(MenuLeo, menu(leo, cycle)),
  send(MenuLeo, show_label, @off),
  send(MenuLeo, append, no),
  send(MenuLeo, append, si),
  send(MenuLeo, selection, no),
  send(Ventana, append, MenuLeo),

  % Virgo
  new(LabelVirgo, label(label_virgo, 'Virgo')),
  send(LabelVirgo, font, font(verdana, roman, 12)),
  send(LabelVirgo, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelVirgo),

  new(MenuVirgo, menu(virgo, cycle)),
  send(MenuVirgo, show_label, @off),
  send(MenuVirgo, append, no),
  send(MenuVirgo, append, si),
  send(MenuVirgo, selection, no),
  send(Ventana, append, MenuVirgo),

  % Libra
  new(LabelLibra, label(label_libra, 'Libra')),
  send(LabelLibra, font, font(verdana, roman, 12)),
  send(LabelLibra, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelLibra),

  new(MenuLibra, menu(libra, cycle)),
  send(MenuLibra, show_label, @off),
  send(MenuLibra, append, no),
  send(MenuLibra, append, si),
  send(MenuLibra, selection, no),
  send(Ventana, append, MenuLibra),

  % Escorpio
  new(LabelEscorpio, label(label_escorpio, 'Escorpio')),
  send(LabelEscorpio, font, font(verdana, roman, 12)),
  send(LabelEscorpio, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelEscorpio),

  new(MenuEscorpio, menu(escorpio, cycle)),
  send(MenuEscorpio, show_label, @off),
  send(MenuEscorpio, append, no),
  send(MenuEscorpio, append, si),
  send(MenuEscorpio, selection, no),
  send(Ventana, append, MenuEscorpio),

  % Sagitario
  new(LabelSagitario, label(label_sagitario, 'Sagitario')),
  send(LabelSagitario, font, font(verdana, roman, 12)),
  send(LabelSagitario, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelSagitario),

  new(MenuSagitario, menu(sagitario, cycle)),
  send(MenuSagitario, show_label, @off),
  send(MenuSagitario, append, no),
  send(MenuSagitario, append, si),
  send(MenuSagitario, selection, no),
  send(Ventana, append, MenuSagitario),

  % Capricornio
  new(LabelCapricornio, label(label_capricornio, 'Capricornio')),
  send(LabelCapricornio, font, font(verdana, roman, 12)),
  send(LabelCapricornio, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelCapricornio),

  new(MenuCapricornio, menu(capricornio, cycle)),
  send(MenuCapricornio, show_label, @off),
  send(MenuCapricornio, append, no),
  send(MenuCapricornio, append, si),
  send(MenuCapricornio, selection, no),
  send(Ventana, append, MenuCapricornio),

  % Acuario
  new(LabelAcuario, label(label_acuario, 'Acuario')),
  send(LabelAcuario, font, font(verdana, roman, 12)),
  send(LabelAcuario, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelAcuario),

  new(MenuAcuario, menu(acuario, cycle)),
  send(MenuAcuario, show_label, @off),
  send(MenuAcuario, append, no),
  send(MenuAcuario, append, si),
  send(MenuAcuario, selection, no),
  send(Ventana, append, MenuAcuario),

  % Piscis
  new(LabelPiscis, label(label_piscis, 'Piscis')),
  send(LabelPiscis, font, font(verdana, roman, 12)),
  send(LabelPiscis, colour, colour(@default, 143, 179, 226)),
  send(Ventana, append, LabelPiscis),

  new(MenuPiscis, menu(piscis, cycle)),
  send(MenuPiscis, show_label, @off),
  send(MenuPiscis, append, no),
  send(MenuPiscis, append, si),
  send(MenuPiscis, selection, no),
  send(Ventana, append, MenuPiscis),

  % Boton guardar
  new(BotonGuardar, button('Guardar', message(@prolog, procesar_signos_excluidos, Ventana, CI, MenuAries, MenuTauro, MenuGeminis, MenuCancer, MenuLeo, MenuVirgo,  MenuLibra, MenuEscorpio, MenuSagitario, MenuCapricornio, MenuAcuario, MenuPiscis))),
  send(BotonGuardar, font, font(verdana, bold, 18)),
  send(BotonGuardar, colour, colour(@default, 49, 65, 122)),
  send(Ventana, display, BotonGuardar, point(480, 920)),

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
procesar_preferencias(Ventana, CI, CampoEdadMin, CampoEdadMax, MenuSexo, CampoAlturaMin, CampoAlturaMax, MenuDepartamento, MenuOjos, MenuPelo, MenuCarrera, MenuSigno, MenuDeporte, MenuCitaIdeal, MenuFuma, MenuToma):-
  
















