:- include('option.pl').

% Constructor TDA Flow
% flow/4
% Dominio: int id, string nameMsg, list of Option options, list of Flow flow

% Constructor
% TDA flow
flow(Id, Names, OptionsEntry, [Id, NamesMsg, OptionsNoDuplicates]):- 
    addUnique(OptionsEntry, [], OptionsNoDuplicates, []).

isInList(Elemento, [Elemento|_]).
isInList(Elemento, [_|Resto]):- 
    isInList(Elemento, Resto).

isNotInList(Elemento, List):- 
    \+ isInList(Elemento, List).

% Caso base: lista de opciones vacía.
addUnique([], ListaAcum, ListaAcum, _).

% Recursión: opciones NO duplicadas
addUnique([OptionToAdd|RestToAdd], ListaAcum, OutputList, Codes) :- 
    getOptionCode(OptionToAdd, Code),
    isNotInList(Code, Codes), 
    addUnique(RestToAdd, [OptionToAdd|ListaAcum], OutputList, [Code|Codes]).