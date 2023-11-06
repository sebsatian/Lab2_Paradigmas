% TDA User - Constructor
% user/2
% Dominio: username (string), user

% Constructor de TDA user
user(Username, User) :-
    % Inicializa el usuario con un nombre de usuario, un historial de chat vacío y un estado de sesión no logueado.
    User = [Username, [], notLogged].  % El chatHistory se inicializa como una lista vacía y el estado de sesión como no logueado.
