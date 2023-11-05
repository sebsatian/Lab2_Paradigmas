% Definiciones de ejemplo para opciones
option(1, "Opción 1", 0, 0, ["palabra clave 1", "palabra clave 2"], O1).
option(2, "Opción 2", 0, 0, ["palabra clave 3", "palabra clave 4"], O2).
option(3, "Opción 3", 0, 0, ["palabra clave 5", "palabra clave 6"], O3).

% Definiciones de ejemplo para flujos
flow(1, "Flujo 1: mensaje de prueba", [O1], F1).
flow(2, "Flujo 2: otro mensaje de prueba", [O2], F2).
flow(3, "Flujo 3: mensaje adicional de prueba", [O3], F3).

% Prueba para añadir opciones únicas a un flujo
test_add_unique_option_to_flow :-
    flowAddOption(F1, O2, NewF1),  % Intenta añadir O2 al flujo F1
    writeln(NewF1).

% Prueba para evitar añadir opciones duplicadas a un flujo
test_prevent_duplicate_option_in_flow :-
    flowAddOption(F1, O1, NewF1),  % Intenta añadir O1 (ya presente) al flujo F1
    writeln(NewF1).

% Prueba para añadir un flujo nuevo y único a un chatbot
test_chatbot_add_unique_flow :-
    chatbot(1001, "Asistente", "Bienvenido, ¿En qué te puedo ayudar?", 1, [F1], Chatbot),
    chatbotAddFlow(Chatbot, F2, NewChatbot),
    writeln(NewChatbot).

% Prueba para evitar añadir un flujo duplicado a un chatbot
test_chatbot_prevent_duplicate_flow :-
    chatbot(1001, "Asistente", "Bienvenido, ¿En qué te puedo ayudar?", 1, [F1], Chatbot),
    chatbotAddFlow(Chatbot, F1, NewChatbot), % Intenta añadir F1 (ya presente) al chatbot
    writeln(NewChatbot).

% Ejecutar todas las pruebas
run_tests :-
    test_add_unique_option_to_flow,
    test_prevent_duplicate_option_in_flow,
    test_chatbot_creation_with_unique_flows,
    test_chatbot_add_unique_flow,
    test_chatbot_prevent_duplicate_flow.

% Comando para ejecutar las pruebas
?- run_tests.