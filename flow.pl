% Constructor TDA Flow
% flow/4
% Dominio: int id, string nameMsg, list of Option options, list of Flow flow

% Constructor
flow(Id, NameMsg, Options, Flow) :-
    integer(Id),
    string(NameMsg),
    is_list(Options),
    % Verificar que el Id del flujo sea único
    \+ flow(Id, _, _, _),
    % Verificar que las opciones no se repitan en base a su id
    verifyUniqueOptions(Options),
    % Construir el flujo
    Flow = [Id, NameMsg, Options].

% Verificar que las opciones no se repitan en base a su id
verifyUniqueOptions([]).
verifyUniqueOptions([Option|Options]) :-
    \+ member(Option, Options),
    verifyUniqueOptions(Options).