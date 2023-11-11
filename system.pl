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
    % Verifica que el ChatbotID no está en el resto de la lista de chatbots utilizando \+ member.
    \+ member(ChatbotID, Rest),
    % Recursivamente verifica el resto de la lista.     
    uniqueChatbotIds(Rest).

% systemAddChatbot/3   
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


% systemAddUser/3
% Modificador para añadir usuarios a un sistema asegurándose de que no haya duplicados.

systemAddUser(System, Username, NewSystem) :-
    % Descompone System para obtener los componentes actuales.
    System = [SystemName, InitialChatbotCodeLink, Chatbots, Users],
    % Verificar que el nombre de usuario no está ya en la lista de usuarios del sistema.
    % Si el usuario ya existe, el predicado fallará y retornará false.
    \+ userExists(Users, Username),
    % Utiliza el constructor de user para crear el nuevo TDA usuario.
    user(Username, NewUser),
    % Añadir el nuevo usuario al final de la lista de usuarios.
    append(Users, [NewUser], NewUsers),
    % Crear el nuevo sistema con la lista de usuarios actualizada.
    NewSystem = [SystemName, InitialChatbotCodeLink, Chatbots, NewUsers].

% Predicado para iniciar sesión de un usuario en el sistema.
% systemLogin/3
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
updateUserStatus([], _, _, []) :- fail.
updateUserStatus([[Username, ChatHistory, notLogged]|Rest], Username, logged, [[Username, ChatHistory, logged]|Rest]).
updateUserStatus([User|Users], Username, NewStatus, [User|UpdatedUsers]) :-
    updateUserStatus(Users, Username, NewStatus, UpdatedUsers).


% systemLogout/2
% Predicado para cerrar la sesión del usuario actualmente logueado en el sistema.
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
% Actualiza el estado de sesión de un usuario en la lista de usuarios.
updateUserStatusOut([], _, _, []) :- fail. % Falla si la lista está vacía o el usuario no se encuentra.
updateUserStatusOut([[Username, ChatHistory, logged]|Rest], Username, notLogged, [[Username, ChatHistory, notLogged]|Rest]).
updateUserStatusOut([UserInfo|Users], Username, Status, [UserInfo|UpdatedUsers]) :-
    % Continúa buscando en el resto de la lista si el primer usuario no es el correcto.
    updateUserStatusOut(Users, Username, Status, UpdatedUsers).