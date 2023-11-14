
% ------------------------------------ system/4 ------------------------------------
% system/4
% Dominio: Name (string), InitialChatbotCodeLink (int), Chatbots (list), System (list).

% Constructor de TDA system
system(Name, InitialChatbotCodeLink, Chatbots, System) :-

    % Verifica que los IDs de los chatbots son únicos.
    uniqueChatbotIds(Chatbots),

    % Inicializa la lista de usuarios como vacía.
    Users = [],

    % Construye el sistema con su nombre, enlace de código de chatbot inicial, chatbots y la lista de usuarios vacía.
    System = [Name, InitialChatbotCodeLink, Chatbots, Users].

% uniqueChatbotIds/1 verifica que cada ID de chatbot sea único en la lista de chatbots.
% Caso base, cuando la lista de chatbots está vacía, todos los IDs son únicos.
uniqueChatbotIds([]).

uniqueChatbotIds([Chatbot|Rest]) :-

    % Asume que el primer elemento de cada chatbot es su ID.
    Chatbot = [ChatbotID|_],

    % Verifica que el ChatbotID no está en el resto de la lista de chatbots utilizando \+ member.
    \+ member(ChatbotID, Rest),
    
    % Recursivamente verifica el resto de la lista.     
    uniqueChatbotIds(Rest).

% ---------------------------------- systemAddChatbot/3 ----------------------------------
% systemAddChatbot/3   
% Dominio: System (list), Chatbot (list), NewSystem (list).
% Modificador para añadir chatbots a un sistema asegurándose de que no haya duplicados.

systemAddChatbot(System, Chatbot, NewSystem) :-

    % Descomponer System para obtener los componentes actuales.
    System = [SystemName, InitialChatbotCodeLink, Chatbots, Users],
    
    % Obtener el ID del chatbot a añadir.
    Chatbot = [ChatbotID|_],

    % Crear una lista con todos los IDs de los chatbots existentes.
    findall(ID, (member(CB, Chatbots), nth0(0, CB, ID)), IDs),

    % Verificar que el ID del chatbot no está ya en la lista de IDs.
    \+ member(ChatbotID, IDs),
    
    % Añadir el chatbot al final de la lista de chatbots.
    append(Chatbots, [Chatbot], NewChatbots),
    
    % Crear el nuevo sistema con la lista de chatbots actualizada.
    NewSystem = [SystemName, InitialChatbotCodeLink, NewChatbots, Users].

%- ------------------------------------ systemAddUser/3 ----------------------------------
% systemAddUser/3
% Dominio: System (list), Username (string), NewSystem (list).
% Modificador para añadir usuarios a un sistema asegurándose de que no haya duplicados.

systemAddUser(System, Username, NewSystem) :-
    % Descompone System para obtener los componentes actuales.
    System = [SystemName, InitialChatbotCodeLink, Chatbots, Users],

    % Si el usuario ya existe, el predicado fallará y retornará false.
    \+ userExists(Users, Username),

    % Utiliza el constructor de user para crear el nuevo TDA usuario.
    user(Username, NewUser),

    % Añade el nuevo usuario al final de la lista de usuarios.
    append(Users, [NewUser], NewUsers),

    % Crea el nuevo sistema con la lista de usuarios actualizada.
    NewSystem = [SystemName, InitialChatbotCodeLink, Chatbots, NewUsers].

% ------------------------------------ systemLogin/3 ----------------------------------
% systemLogin/3
% Domino: System (list), Username (string), NewSystem (list).
% Predicado para iniciar sesión.
% Actualiza el estado de sesión de un usuario a 'logged' en la lista de usuarios.
systemLogin(System, Username, NewSystem) :-

    % Descompone System para obtener los componentes actuales.
    System = [SystemName, InitialChatbotCodeLink, Chatbots, Users],

    % Verifica que el usuario existe y su estado de sesión es 'notLogged'.
    member([Username, _, notLogged], Users),

    % Verificar que ningún otro usuario está logueado.
    \+ anyUserLogged(Users),
    
    % Actualizar el estado de sesión del usuario a 'logged'.
    updateUserStatus(Users, Username, logged, UpdatedUsers),
    
    % Crear el nuevo sistema con la lista de usuarios actualizada.
    NewSystem = [SystemName, InitialChatbotCodeLink, Chatbots, UpdatedUsers].

% anyUserLogged/1

% Verifica si algún usuario en la lista de usuarios está logueado.
anyUserLogged(Users) :-
    member([_, _, logged], Users).

% updateUserStatus/4
% Actualiza el estado de sesión de un usuario en la lista de usuarios.

% Falla si la lista está vacía o el usuario no se encuentra.
updateUserStatus([], _, _, []) :- fail.

% Caso base, cuando el usuario es el primero en la lista.
updateUserStatus([[Username, ChatHistory, notLogged]|Rest], Username, logged, [[Username, ChatHistory, logged]|Rest]).

% Caso recursivo, cuando el usuario no es el primero en la lista.
updateUserStatus([User|Users], Username, NewStatus, [User|UpdatedUsers]) :-
    updateUserStatus(Users, Username, NewStatus, UpdatedUsers).

% ------------------------------------ systemLogout/3 ----------------------------------
% systemLogout/2
% Dominio: System (list), NewSystem (list).
% Predicado para cerrar la sesión del usuario actualmente loggeado en el sistema.
systemLogout(System, NewSystem) :-

    % Descomponer System para obtener los componentes actuales.
    System = [SystemName, InitialChatbotCodeLink, Chatbots, Users],
    
    % Encontrar el usuario que está logueado.
    member([Username, _, logged], Users),
    
    % Crear una nueva lista de usuarios con el usuario logueado ahora no logueado.
    updateUserStatusOut(Users, Username, notLogged, UpdatedUsers),
    
    % Crear el nuevo sistema con la lista de usuarios actualizada.
    NewSystem = [SystemName, InitialChatbotCodeLink, Chatbots, UpdatedUsers].

% updateUserStatusOut/4
% Actualiza el estado de sesión de un usuario a 'notLogged' en la lista de usuarios.
% Falla si la lista está vacía o el usuario no se encuentra.

% Falla si la lista está vacía o el usuario no se encuentra.
updateUserStatusOut([], _, _, []) :- fail. 

% Caso base, cuando el usuario 'logged' es el primero en la lista.
updateUserStatusOut([[Username, ChatHistory, logged]|Rest], Username, notLogged, [[Username, ChatHistory, notLogged]|Rest]).

% Caso recursivo, cuando el usuario no es el primero en la lista.
updateUserStatusOut([UserInfo|Users], Username, Status, [UserInfo|UpdatedUsers]) :-

    % Continúa buscando en el resto de la lista recursivamente hasta que el usuario sea el primero.
    updateUserStatusOut(Users, Username, Status, UpdatedUsers).



% ------------------------------------ systemTalkRec y systemSynthesis (comentados dado que no lograron cumplir su función) ----------------------------------
% Predicado para interacciones del usuario con el sistema.
%systemTalkRec(System, Message, NewSystem) :-
%    currentLoggedUser(System, Username, UserChatHistory),
%    get_time(Timestamp), 
%    processMessage(System, Username, UserChatHistory, Message, Timestamp, NewSystem).
%
% Encuentra al usuario actualmente logueado y su historial de chat.
%currentLoggedUser([_, _, _, Users], Username, ChatHistory) :-
%    member([Username, ChatHistory, logged], Users).
%
% Procesa el mensaje que el usuario ha enviado al sistema.
%processMessage(System, Username, UserChatHistory, Message, Timestamp, NewSystem) :-
%    (   Message == "hola" ->
%        saludo(System, Username, UserChatHistory, Message, Timestamp, NewSystem);
%        integer(Message) ->
%        selectorOpcion(System, Username, Message, NewSystem);
%        selectorKeyword(System, Username, Message, NewSystem)
%    ).
%
% Maneja el saludo "hola".
%saludo(System, Username, UserChatHistory, Message, Timestamp, NewSystem) :-
%    selectChatbotByID(System, 0, InitialChatbot),
%    updateCurrentChatbot(System, InitialChatbot, StartSystem),
%    addInteractionToChatHistory(UserChatHistory, Message, Timestamp, NewChatHistory),
%    updateUserChatHistory(StartSystem, Username, NewChatHistory, NewSystem).
%
% Actualiza el ChatHistory de un usuario específico en la lista de usuarios.
%updateUserChatHistory([SystemName, InitialChatbotCodeLink, Chatbots, Users], Username, NewChatHistory, [SystemName, InitialChatbotCodeLink, Chatbots, NewUsers]) :-
%    findUser(Users, Username, [Username, _, Status]),
%    UpdatedUser = [Username, NewChatHistory, Status],
%    replaceUser(Users, UpdatedUser, NewUsers).
%
% Encuentra la información de un usuario específico.
%findUser([[Username, ChatHistory, Status]|_], Username, [Username, ChatHistory, Status]).
%findUser([_|Rest], Username, Result) :-
%    findUser(Rest, Username, Result).
%
% Reemplaza la información de un usuario en la lista de usuarios.
%replaceUser([], _, []) :- fail.
%replaceUser([User|Users], User, [User|Users]).
%replaceUser([CurrentUser|Users], User, [CurrentUser|UpdatedUsers]) :-
%    CurrentUser \= User,
%    replaceUser(Users, User, UpdatedUsers).
%
% Añade interacción al ChatHistory de un usuario.
%addInteractionToChatHistory(ChatHistory, Interaction, Timestamp, NewChatHistory) :-
%    NewInteraction = [Interaction, "system", Timestamp],  
%    NewChatHistory = [NewInteraction | ChatHistory].
%
% Predicado para hacer un resumen de las interacciones
%systemSynthesis(System, Username, FormattedSynthesis) :-.
%    findUserChatHistory(System, Username, UserChatHistory),
%    formatChatHistory(UserChatHistory, FormattedSynthesis).
%
% Encuentra el historial de chat de un usuario específico en el sistema.
%findUserChatHistory([_, _, _, Users], Username, ChatHistory) :-
%    member([Username, ChatHistory, _], Users).
%
% Formatea el chatHistory para la visualización.
%formatChatHistory(ChatHistory, FormattedSynthesis) :-
%    maplist(formatInteraction, ChatHistory, FormattedInteractions),
%    atomic_list_concat(FormattedInteractions, '\n', FormattedSynthesis).
%
% Formatea una única interacción del historial de chat para la visualización.
%formatInteraction([Text, Sender, Timestamp], FormattedInteraction) :-
%    format_time(string(DateString), '%c', Timestamp),
%    format(string(FormattedInteraction), '~w - ~w: ~w', [DateString, Sender, Text]).
