% Constructor TDA Flow
% flow/4
% Dominio: int Id, string Message, list Options

% Constructor de TDA flow

flow(Id, Message, OptionstoAdd, [Id, Message, UniqueOptions]):-
    addUnique(OptionstoAdd, [], UniqueOptions, []).

% Caso base recursivo cuando la lista de opciones esta vacia
addUnique([], ListaAcum, ListaAcum, _).

% Caso recursivo cuando la lista de opciones no esta vacia y comprueba duplicidad.
addUnique([ElementToAdd|RestToAdd], ListaAcum, ListOut, Codes) :-
    getOptionCode(ElementToAdd, Code),
    \+ member(Code, Codes),
    addUnique(RestToAdd, [ElementToAdd|ListaAcum], ListOut, [Code|Codes]).

    
% Predicado para añadir una opción a un Flow existente
% flowAddOption/3
% Agrega una opción al flujo si el ID de la opción es único.
flowAddOption(Flow, Option, NewFlow) :- 
    % Extrae componentes del flujo.
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
    member(Opt, Options),
    getOptionCode(Opt, Code),
    Code == OptionCode,  % Si encuentra una coincidencia, se detiene.
    !.