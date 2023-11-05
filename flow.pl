:- include('option.pl').

% Constructor TDA Flow
% flow/4
% Dominio: int Id, string Message, list Options

% Constructor de TDA flow
flow(Id, Message, Options, Flow):- 
    % Inicializa el flujo con un identificador, mensaje y opciones únicas.
    Flow = [Id, Message, UniqueOptions],
    % Llama a addUnique para filtrar las opciones únicas.
    addUnique(Options, [], UniqueOptions, []).

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

% Caso base para addUnique, cuando no hay mas opciones para añadir, 
% retorna la lista acumulada como la lista de opciones únicas.
addUnique([], ListaAcum, ListaAcum, _).

% Recursión para addUnique: agrega opciones NO duplicadas a la lista.
addUnique([OptionToAdd|RestToAdd], ListaAcum, OutputList, Codes) :- 
    % Obtiene el código de la opción actual.
    getOptionCode(OptionToAdd, Code),
    % Verifica que el código NO esté ya en la lista de códigos.
    isNotInList(Code, Codes),
    % Si el código NO está en la lista, o sea, que la línea anterior
    % devuelva true, el programa continúa y añade la opción a la lista acumulada.
    addUnique(RestToAdd, [OptionToAdd|ListaAcum], OutputList, [Code|Codes]).


% Predicado para añadir una opción a un Flow existente
% flowAddOption/3
% Dominio: 
% Agrega una opción al flujo si el ID de la opción es único.
flowAddOption(Flow, Option, NewFlow) :- 
    % Extrae componentes del flujo.
    Flow = [Id, Message, Options],
    % Obtiene el ID de la nueva opción.
    getOptionCode(Option, OptionCode),
    % Encuentra todos los códigos de las opciones existentes.
    findall(Code, (isInList(ExistingOption, Options), getOptionCode(ExistingOption, Code)), Codes),
    % Verifica que el ID de la nueva opción no esté en la lista de códigos.
    isNotInList(OptionCode, Codes),
    % Detiene el backtracking si el ID es único.
    !,
    % Añade la nueva opción a las opciones existentes.
    NewOptions = [Option|Options],
    % Forma el nuevo flujo.
    NewFlow = [Id, Message, NewOptions].

% Falla si el ID de la opción ya existe en el flujo.
flowAddOption(Flow, Option, _) :-
    % Extrae solo las opciones del flujo.
    Flow = [_, _, Options],
    % Obtiene el ID de la nueva opción.
    getOptionCode(Option, OptionCode),
    % Verifica si el ID ya existe.
    isInList(OptionCode, Options),
    % Falla si el ID ya está presente.
    fail.



