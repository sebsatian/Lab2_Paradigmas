
% -------------------------- user/2 --------------------------
% user/2
% Dominio: Username (string), User (list).

% Constructor TDA user
% se inicializa el usuario con su username, una lista vacia para el chatHistory y el estado de sesion.

user(Username, [Username, [], notLogged]).

% Verifica si un nombre de usuario ya existe en la lista de usuarios.

userExists(Users, Username) :-
    member([Username, _, _], Users).