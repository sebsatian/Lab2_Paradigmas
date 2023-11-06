:- include('option.pl').
:- include('flow.pl').  

% Constructor TDA chatbot
% chatbot/5
% Dominio: int ChatbotID, string Name, string WelcomeMessage, int StartFlowId, list Flows

% Constructor de TDA chatbot
chatbot(ChatbotID, Name, WelcomeMessage, StartFlowId, Flows, Chatbot):- 
    % Verifica que los IDs de los flujos son únicos.
    uniqueFlowIds(Flows),
    % Construye el chatbot con su ID, nombre, mensaje de bienvenida, ID de flujo inicial y flujos.
    Chatbot = [ChatbotID, Name, WelcomeMessage, StartFlowId, Flows].

% uniqueFlowIds/1 verifica que cada ID de flujo sea único en la lista de flujos.
uniqueFlowIds([]).
uniqueFlowIds([Flow|Rest]) :-
    % Asume que el primer elemento de cada flujo es su ID.
    Flow = [FlowID|_],
    % Verifica que el FlowID no está en el resto de la lista de flujos.
    isNotInList(FlowID, Rest),
    % Recursivamente verifica el resto de la lista.
    uniqueFlowIds(Rest).

% chatbotAddFlow/3
% Predicado modificador para añadir flujos a un chatbot asegurándose de que no haya duplicados.
chatbotAddFlow(Chatbot, Flow, NewChatbot) :-
    % Descomponer Chatbot para obtener los componentes actuales.
    Chatbot = [ChatbotID, Name, WelcomeMessage, StartFlowId, Flows],
    
    % Obtener el ID del flujo a añadir.
    Flow = [FlowID|_],

    % Verificar que el ID del flujo no está ya en la lista de flujos del chatbot utilizando isInList.
    \+ isInList([FlowID|_], Flows),
    
    % Añadir el flujo al final de la lista de flujos de manera recursiva.
    addFlowToEnd(Flows, Flow, NewFlows),
    
    % Crear el nuevo chatbot con la lista de flujos actualizada.
    NewChatbot = [ChatbotID, Name, WelcomeMessage, StartFlowId, NewFlows].

% addFlowToEnd/3
% Añade un flujo al final de la lista de flujos de manera recursiva.
addFlowToEnd(Flows, Flow, [Flow]) :- 
    % Caso base: si no hay mas flujos, simplemente se devuelve la lista con el flujo añadido.
    Flows = [].

% Caso recursivo: se añade la cabeza a la nueva lista y se continúa con el resto.
addFlowToEnd([Head|Tail], Flow, [Head|NewTail]) :-
    addFlowToEnd(Tail, Flow, NewTail).
