%% Este archivo se usa para crear las ventanas para interactuar con el programa

%%Libreria que se usa para crear las ventanas
:- use_module(library(pce)).


%------------------------------------------------------------------------------------
%INICIO
%--------------------------------------------------------------------------------------

%Esta regla se usa para incializar el programa
iniciar:-
  ventana_login.

%------------------------------------------------------------------------
%LOGIN
%--------------------------------------------------------------------------

ventana_login:-
  
  %Inicializamos la ventana de login
  new(Ventana, dialog('UM Match - Login')), %Creo la ventana y su nombre
  send(Ventana, size, size(800, 600)), %Le cambio el tamano
  
  %Formateamos el titulo
  new(Titulo, label(titulo, 'Bienvenido a UM Match')), %Creo el titulo
  send(Titulo, font, font(verdana, bold, 30)), %Especifica letra y tamano
  send(Titulo, colour, colour(@default, 49, 65, 122)), %Especifica color
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


%Si estamos en otra Ventana, usamos esta para volver al login.
volver_login(Ventana) :-
  send(Ventana, destroy),
  ventana_login.
 

%------------------------------------------------------------------------------------------------------------
%Procesar la cedula de login
%------------------------------------------------------------------------------------------------------------

procesar_login(Ventana, CampoCI) :-
  get(CampoCI, selection, TextoCI), %Leo lo q hay en el cuadro que pide la cedula
  atom_number(TextoCI, CI), %Convierto el texto a numero

  (existe_perfil(CI), %Si el perfil existe
  send(Ventana, destroy), %Cierro ese menu
  ventana_menu(CI) %Abro el menu principal para ese usuario
  
  ;
  \+existe_perfil(CI), %Si el perfil no existe
  send(Ventana, destroy), %Cierro ese menu
  ventana_no_registrado(CI)). %Lo llevo al menu para que se registre.


%-------------------------------------------------------------------------------------------------------------
%CEDULA NO REGISTRADA
%-------------------------------------------------------------------------------------------------------------

ventana_no_registrado(CI) :-
  
  % Inicializamos la ventana
  new(Ventana, dialog('UM Match - Cedula no registrada')),
  send(Ventana, size, size(800, 600)),

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

%-----------------------------------------------------------------------------------------------
%REGISTRAR USUARIO NUEVO
%-----------------------------------------------------------------------------------------------








abrir_registro(Ventana, CI) :-
  send(Ventana, destroy),
  ventana_registro(CI).


