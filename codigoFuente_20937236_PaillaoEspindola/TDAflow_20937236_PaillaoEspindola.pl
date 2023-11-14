
% --------------------------- flow/4 ---------------------------
% flow/4
% Dominio: Id (int), Message (string), Options (list).

% Constructor de TDA flow

flow(Id, Message, OptionstoAdd, [Id, Message, UniqueOptions]):-
    addUnique(OptionstoAdd, [], UniqueOptions, []).

% Caso base recursivo cuando la lista de opciones esta vacia
addUnique([], ListaAcum, ListaAcum, _).

% Caso recursivo cuando la lista de opciones no esta vacia y comprueba duplicidad.
addUnique([ElementToAdd|RestToAdd], ListaAcum, ListOut, Codes) :-

    % Obtiene el codigo de la opcion a agregar.
    getOptionCode(ElementToAdd, Code),

    % Verifica que el codigo no este en la lista de codigos.
    \+ member(Code, Codes),

    % Agrega el codigo a la lista de codigos.
    addUnique(RestToAdd, [ElementToAdd|ListaAcum], ListOut, [Code|Codes]).

%---------------------------------- flowAddOption/3 ----------------------------------

% Predicado para añadir una opción a un Flow existente
% flowAddOption/3
% Dominio: Flow (list), Option, (list), NewFlow (list).
% Agrega una opción al flujo si el ID de la opción es único.

flowAddOption(Flow, Option, NewFlow) :- 

    % Descompone el flujo.
    Flow = [Id, Message, Options],

    % Obtiene el ID de la nueva opción.
    getOptionCode(Option, OptionCode),

    % Verifica que el ID de la nueva opción no esté en la lista de códigos.
    \+ optionIdExists(Options, OptionCode),

    % Añade la nueva opción a las opciones existentes.
    NewOptions = [Option|Options],

    % Forma el nuevo flujo.
    NewFlow = [Id, Message, NewOptions].

% Verifica si un ID de opción existe en la lista de opciones.
optionIdExists(Options, OptionCode) :-

    % Recorre la lista de opciones.
    member(Opt, Options),

    % Obtiene el ID de la opción.
    getOptionCode(Opt, Code),

    % Si encuentra una coincidencia, se detiene.
    Code == OptionCode,
    !.