:- include('chatbot.pl').
:- include('option.pl').
:- include('flow.pl').
:- include('user.pl').
:- include('chatHistory.pl').

% Constructor TDA system
% system/4
% Dominio: name (string), initialChatbotCodeLink (int), chatbots (list of chatbot), system

% Constructor de TDA system
system(Name, InitialChatbotCodeLink, Chatbots, System) :-
    % Verifica que los IDs de los chatbots son únicos.
    uniqueChatbotIds(Chatbots),
    % Inicializa la lista de usuarios como vacía.
    Users = [],
    % Construye el sistema con su nombre, enlace de código de chatbot inicial, chatbots y la lista de usuarios vacía.
    System = [Name, InitialChatbotCodeLink, Chatbots, Users].

% uniqueChatbotIds/1 verifica que cada ID de chatbot sea único en la lista de chatbots.
uniqueChatbotIds([]).
uniqueChatbotIds([Chatbot|Rest]) :-
    % Asume que el primer elemento de cada chatbot es su ID.
    Chatbot = [ChatbotID|_],
    % Verifica que el ChatbotID no está en el resto de la lista de chatbots utilizando isNotInList.
    isNotInList(ChatbotID, Rest),
    % Recursivamente verifica el resto de la lista.
    uniqueChatbotIds(Rest).

% systemAddChatbot/3   
% Modificador para añadir chatbots a un sistema asegurándose de que no haya duplicados.
systemAddChatbot(System, Chatbot, NewSystem) :-
    % Descomponer System para obtener los componentes actuales.
    System = [SystemName, InitialChatbotCodeLink, Chatbots],
    
    % Obtener el ID del chatbot a añadir.
    Chatbot = [ChatbotID|_],

    % Verificar que el ID del chatbot no está ya en la lista de chatbots del sistema.
    isNotInList(ChatbotID, Chatbots),
    
    % Añadir el chatbot al final de la lista de chatbots.
    append(Chatbots, [Chatbot], NewChatbots),
    
    % Crear el nuevo sistema con la lista de chatbots actualizada.
    NewSystem = [SystemName, InitialChatbotCodeLink, NewChatbots].

% systemAddUser/3
% Modificador para añadir usuarios a un sistema asegurándose de que no haya duplicados.
systemAddUser(System, Username, NewSystem) :-
    % Descomponer System para obtener los componentes actuales.
    System = [SystemName, InitialChatbotCodeLink, Chatbots, Users],

    % Verificar que el nombre de usuario no está ya en la lista de usuarios del sistema.
    isNotInList([Username, _], Users),
    
    % Crear el nuevo usuario utilizando el constructor de TDA user.
    user(Username, [], NewUser),  % Asegúrate de que el chatHistory se inicializa como una lista vacía.

    % Añadir el usuario al final de la lista de usuarios.
    append(Users, [NewUser], NewUsers),
    
    % Crear el nuevo sistema con la lista de usuarios actualizada.
    NewSystem = [SystemName, InitialChatbotCodeLink, Chatbots, NewUsers].

% Función member implementada, caso base.
% Verifica si un elemento está en la cabeza de la lista.
isInList(Elemento, [Elemento|_]).

% Función member implementada, caso recursivo.
% Verifica si un elemento está en el resto de la lista.
isInList(Elemento, [_|Resto]):- 
    isInList(Elemento, Resto).

% Función member implementada con negación.
% Verifica y devuelve true cuando un elemento NO está en la lista.
isNotInList(Elemento, List):- 
    \+ isInList(Elemento, List).

% systemLogin/3
% Predicado para iniciar sesión de un usuario en el sistema.
systemLogin(System, Username, NewSystem) :-
    % Descomponer System para obtener los componentes actuales.
    System = [SystemName, InitialChatbotCodeLink, Chatbots, Users],

    % Verificar que el usuario existe y su estado de sesión es 'notLogged'.
    isInList([Username, _, notLogged], Users),

    % Verificar que ningún otro usuario está logueado.
    \+ anyUserLogged(Users),
    
    % Actualizar el estado de sesión del usuario a 'logged'.
    updateUserStatus(Users, Username, logged, UpdatedUsers),
    
    % Crear el nuevo sistema con la lista de usuarios actualizada.
    NewSystem = [SystemName, InitialChatbotCodeLink, Chatbots, UpdatedUsers].

% anyUserLogged/1
% Verifica si algún usuario en la lista de usuarios está logueado.
anyUserLogged(Users) :-
    isInList([_, _, logged], Users).

% updateUserStatus/4
% Actualiza el estado de sesión de un usuario en la lista de usuarios.
updateUserStatus([], _, _, []) :- fail.
updateUserStatus([[Username, ChatHistory, notLogged]|Rest], Username, logged, [[Username, ChatHistory, logged]|Rest]).
updateUserStatus([User|Users], Username, NewStatus, [User|UpdatedUsers]) :-
    updateUserStatus(Users, Username, NewStatus, UpdatedUsers).


% systemLogout/3
% Predicado para cerrar la sesión de un usuario en el sistema.
systemLogout(System, Username, NewSystem) :-
    % Descomponer System para obtener los componentes actuales.
    System = [SystemName, InitialChatbotCodeLink, Chatbots, Users],

    % Verificar que el usuario está logueado.
    isInList([Username, _, logged], Users),

    % Actualizar el estado de sesión del usuario a 'notLogged'.
    updateUserStatus(Users, Username, notLogged, UpdatedUsers),

    % Crear el nuevo sistema con la lista de usuarios actualizada.
    NewSystem = [SystemName, InitialChatbotCodeLink, Chatbots, UpdatedUsers].

% updateUserStatusOut/4
% Actualiza el estado de sesión de un usuario en la lista de usuarios.
updateUserStatusOut([], _, _, []) :- fail. % Falla si la lista está vacía o el usuario no se encuentra.
updateUserStatusOut([[Username, ChatHistory, logged]|Rest], Username, notLogged, [[Username, ChatHistory, notLogged]|Rest]).
updateUserStatusOut([User|Users], Username, NewStatus, [User|UpdatedUsers]) :-
    updateUserStatusOut(Users, Username, NewStatus, UpdatedUsers).
