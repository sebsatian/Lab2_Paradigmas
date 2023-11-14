%----------------------- SCRIPT DADO EN ENUNCIADO -----------------------%
option(1, "1) Viajar", 12, 1, ["viajar", "turistear", "conocer"], OP1),
option(2, "2) Estudiar", 2, 1, ["estudiar", "aprender", "perfeccionarme"], OP2),
flow(1, "flujo1", [OP1], F10),
flowAddOption(F10, OP2, F11),
% flowAddOption(F10, OP1, F12), %si esto se descomenta, debe dar false, porque es opción con id duplicada.
chatbot(0, "Inicial", "Bienvenido\n¿Qué te gustaría hacer?", 1, [F11], CB0), %solo añade una ocurrencia de F11
%Chatbot1
option(1, "1) New York, USA", 1, 2, ["USA", "Estados Unidos", "New York"], OP3),
option(2, "2) París, Francia", 1, 1, ["Paris", "Eiffel"], OP4),
option(3, "3) Torres del Paine, Chile", 1, 1, ["Chile", "Torres", "Paine", "Torres Paine", "Torres del Paine"], OP5),
option(4, "4) Volver", 0, 1, ["Regresar", "Salir", "Volver"], OP6),
%Opciones segundo flujo Chatbot1
option(1, "1) Central Park", 1, 2, ["Central", "Park", "Central Park"], OP7),
option(2, "2) Museos", 1, 2, ["Museo"], OP8),
option(3, "3) Ningún otro atractivo", 1, 3, ["Museo"], OP9),
option(4, "4) Cambiar destino", 1, 1, ["Cambiar", "Volver", "Salir"], OP10),
option(1, "1) Solo", 1, 3, ["Solo"], OP11),
option(2, "2) En pareja", 1, 3, ["Pareja"], OP12),
option(3, "3) En familia", 1, 3, ["Familia"], OP13),
option(4, "4) Agregar más atractivos", 1, 2, ["Volver", "Atractivos"], OP14),
option(5, "5) En realidad quiero otro destino", 1, 1, ["Cambiar destino"], OP15),
flow(1, "Flujo 1 Chatbot1\n¿Dónde te Gustaría ir?", [OP3, OP4, OP5, OP6], F20),
flow(2, "Flujo 2 Chatbot1\n¿Qué atractivos te gustaría visitar?", [OP7, OP8, OP9, OP10], F21),
flow(3, "Flujo 3 Chatbot1\n¿Vas solo o acompañado?", [OP11, OP12, OP13, OP14, OP15], F22),
chatbot(1, "Agencia Viajes",  "Bienvenido\n¿Dónde quieres viajar?", 1, [F20, F21, F22], CB1),
%Chatbot2
option(1, "1) Carrera Técnica", 2, 1, ["Técnica"], OP16),
option(2, "2) Postgrado", 2, 1, ["Doctorado", "Magister", "Postgrado"], OP17),
option(3, "3) Volver", 0, 1, ["Volver", "Salir", "Regresar"], OP18),
flow(1, "Flujo 1 Chatbot2\n¿Qué te gustaría estudiar?", [OP16, OP17, OP18], F30),
chatbot(2, "Orientador Académico",  "Bienvenido\n¿Qué te gustaría estudiar?", 1, [F30], CB2),
system("Chatbots Paradigmas", 0, [CB0], S0),
% systemAddChatbot(S0, CB0, S1), %si esto se descomenta, debe dar false, porque es chatbot id duplicado.
systemAddChatbot(S0, CB1, S01),
systemAddChatbot(S01, CB2, S02),
systemAddUser(S02, "user1", S2),
systemAddUser(S2, "user2", S3),
% systemAddUser(S3, "user2", S4), %si esto se descomenta, debe dar false, porque es username duplicado
systemAddUser(S3, "user3", S5),
% systemLogin(S5, "user8", S6), %si esto se descomenta, debe dar false ;user8 no existe.
systemLogin(S5, "user1", S7),
% systemLogin(S7, "user2", S8), %si esto se descomenta, debe dar false, ya hay usuario con login
systemLogout(S7, S9),
systemLogin(S9, "user2", S10).
% NO SE INCLUYEN systemTalkRec, systemSynthesis ni systemSimulate, ya que no lograron ser implementados.

%----------------------- SCRIPT DE PRUEBA CREADO POR MI -----------------------%

% Crear opciones
option(1, "1) Deportes extremos", 1, 1, ["extremos", "deportes", "adrenalina", "aventura"], OP1),
option(2, "2) Compra en línea", 2, 1, ["comprar", "en línea", "shop", "online"], OP2),
option(3, "1) Salto en bungee", 3, 1, ["salto", "bungee", "alto", "puente"], OP3),
option(4, "2) Skydiving", 3, 2, ["skydiving", "paracaidismo", "altitud", "paracaídas"], OP4),
option(5, "1) Tecnología", 4, 1, ["tecnología", "electronics", "gadget", "dispositivos"], OP5),
option(6, "2) Comida", 4, 2, ["comida", "alimentos", "restaurante", "comida rápida"], OP6),
option(7, "1) Cajón del Maipo", 5, 1, ["Cajón del Maipo", "naturaleza"], OP7),
option(8, "2) Reñaca", 5, 2, ["Reñaca", "playa", "arena"], OP8),
option(9, "1) Cajón del Maipo", 6, 1, ["Cajón del Maipo", "naturaleza"], OP9),
option(10, "2) Cerro Panul", 6, 2, ["Cerro Panul", "montaña", "vista"], OP10),
option(11, "1) Celulares Samsung", 7, 1, ["Samsung", "Android", "Galaxy"], OP11),
option(12, "2) Celulares Apple", 7, 2, ["Apple", "iPhone", "iOS"], OP12),
option(13, "1) McDonald's", 8, 1, ["McDonald's", "Hamburguesas", "coca cola", "papas fritas"], OP13),
option(14, "2) El Faraon", 8, 2, ["El Faraon", "papas fritas", "papas", "fritas"], OP14),

% Crear flujos
flow(1, "Flujo Principal Chatbot 1\nBienvenido\n¿Qué te gustaría hacer?", [OP1], F10),
flow(2, "Flujo Principal Chatbot 2\nBienvenido\n¿Dónde te gustaría viajar?", [OP3], F11),
flow(3, "Flujo Principal Chatbot 3\nBienvenido\n¿Qué buscas comprar?", [OP5, OP6], F12),

% Agregar opciones a los flujos
flowAddOption(F10, OP2, F13),
flowAddOption(F11, OP4, F14),
%flowAddOption(F12, OP6, F15), % False, ya que OP6 ya está en F12.

% Crear chatbots
chatbot(0, "Inicial", "Bienvenido\n¿Qué te gustaría hacer?", 1, [], CB0), % Se inicia sin flujos para agregarlos despues
chatbot(1, "Max Steel", "Bienvenido.\n¿Dónde te gustaría ir?", 2, [], CB1), % Se inicia sin flujos para agregarlos despues
chatbot(2, "Asesor de Compras", "Hola.\n¿Qué buscas comprar hoy?", 3, [F12, F12], CB2), % Agrega solo una ocurrencia de F12.

%Agregar flujos a los chatbots
chatbotAddFlow(CB0, F13, CB3),
chatbotAddFlow(CB1, F14, CB4),
%chatbotAddFlow(CB2, F12, CB5), % False, porque F12 ya está en CB2.

% Crear sistema
system("Chatbots Paradigmas", 0, [CB0], S0),

% Añadir chatbots al sistema
%systemAddChatbot(S0, CB0, S1), % False
systemAddChatbot(S0, CB1, S1), 
systemAddChatbot(S1, CB2, S2),

% Añadir usuarios al sistema
systemAddUser(S2, "user1", S3),
systemAddUser(S3, "user2", S5),
%systemAddUser(S4, "user2", S5),  % False, ya que user2 ya existe.
systemAddUser(S5, "user3", S6),

% Simulación de interacciones
systemLogin(S6, "user1", S7),
%systemLogin(S7, "user2", S8),  % Intenta iniciar sesión con "user2" cuando "user1" ya ha iniciado sesión, False

% Crear dos sistemas adicionales
system("Chatbots Paradigmas 2", 0, [CB0], S12),
system("Chatbots Paradigmas 3", 0, [CB0], S13),

% Añadir chatbots a los sistemas adicionales
systemAddChatbot(S12, CB1, S14),
systemAddChatbot(S14, CB2, S15),
systemAddChatbot(S13, CB1, S16),
systemAddChatbot(S16, CB2, S17),

% Añadir usuarios a los sistemas adicionales
systemAddUser(S15, "user1", S18),
systemAddUser(S18, "user2", S20),
%systemAddUser(S19, "user2", S20),  % False
systemAddUser(S20, "user3", S21),

% Simulación de interacciones adicionales
systemLogin(S21, "user1", S22),
%systemLogin(S22, "user2", S23),  % Intenta iniciar sesión con "user2" mientras "user1" ya ha iniciado sesión, False
systemLogout(S22, S24),
systemLogin(S24, "user2", S25),
systemLogout(S25, S26),

% Iniciar sesión con "user1"
systemLogin(S26, "user1", S27).