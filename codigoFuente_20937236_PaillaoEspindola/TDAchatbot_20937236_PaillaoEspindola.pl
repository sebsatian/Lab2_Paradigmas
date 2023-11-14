
% --------------------------- chatbot/6 ---------------------------
% chatbot/6
% Dominio: ChatbotID (int), Name (string), WelcomeMessage (string), StartFlowId (int), Flows (list), Chatbot (list)

% Constructor de TDA chatbot
chatbot(ChatbotID, Name, WelcomeMessage, StartFlowId, Flows, Chatbot):- 

    % Filtra los flujos para mantener solo aquellos con IDs únicos.
    findUniqueFlows(Flows, UniqueFlows),

    % Construye el chatbot con su ID, nombre, mensaje de bienvenida, ID de flujo inicial y flujos únicos.
    Chatbot = [ChatbotID, Name, WelcomeMessage, StartFlowId, UniqueFlows].

% findUniqueFlows/2 encuentra flujos únicos en una lista de flujos.
findUniqueFlows(Flows, UniqueFlows) :-
    findUniqueFlowsHelper(Flows, [], UniqueFlows).

% findUniqueFlowsHelper/3 es un ayudante recursivo para filtrar flujos únicos.
findUniqueFlowsHelper([], Acc, Acc).

findUniqueFlowsHelper([[ID|RestFlow]|T], Acc, UniqueFlows) :-
    ( member([ID|_], Acc) ->

        % Si el ID ya está, no agregar
        findUniqueFlowsHelper(T, Acc, UniqueFlows);  

        % Si no está, agregar
        findUniqueFlowsHelper(T, [[ID|RestFlow]|Acc], UniqueFlows)).  

% --------------------------- chatbotAddFlow/3 ---------------------------

% chatbotAddFlow/3
% Dominio: Chatbot (list), Flow (list), NewChatbot (list).
% Predicado modificador para añadir flujos a un chatbot asegurándose de que no haya duplicados.

chatbotAddFlow(Chatbot, Flow, NewChatbot) :-
    % Descompone Chatbot para obtener los componentes actuales.

    % Obtiene el ID del chatbot.
    Chatbot = [ChatbotID, Name, WelcomeMessage, StartFlowId, Flows],
    
    % Obtiene el ID del flujo a añadir.
    Flow = [FlowID|_],

    % Verifica que el ID del flujo no está ya en la lista de flujos del chatbot utilizando member.
    \+ member([FlowID|_], Flows),
    
    % Añade el flujo al final de la lista de flujos de manera recursiva.
    addFlowToEnd(Flows, Flow, NewFlows),
    
    % Crea el nuevo chatbot con la lista de flujos actualizada.
    NewChatbot = [ChatbotID, Name, WelcomeMessage, StartFlowId, NewFlows].

% addFlowToEnd/3
% Añade un flujo al final de la lista de flujos de manera recursiva.

% Caso base, cuando la lista de flujos está vacía, simplemente devuelve la lista con el flujo añadido.
addFlowToEnd(Flows, Flow, [Flow]) :- 
    Flows = [].

% Caso recursivo, se añade la cabeza a la nueva lista y se continúa con el resto.
addFlowToEnd([Head|Tail], Flow, [Head|NewTail]) :-
    addFlowToEnd(Tail, Flow, NewTail).