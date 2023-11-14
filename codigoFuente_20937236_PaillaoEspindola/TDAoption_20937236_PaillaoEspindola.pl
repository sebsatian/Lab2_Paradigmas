
% ---------------------- option/6 ---------------------- 
% option/6
% Dominio: Code (int), Message (string), ChatbotCodeLink (int), InitialFlowCodeLink (int), PalabrasClave (list), Option (list).

% Constructor
option(Code, Message, ChatbotCodeLink, InitialFlowCodeLink, PalabrasClave, Option) :-

    string(Message),
    integer(ChatbotCodeLink),
    integer(InitialFlowCodeLink),
    is_list(PalabrasClave),
    % Construir la opción.
    Option = [Code, Message, ChatbotCodeLink, InitialFlowCodeLink, PalabrasClave].

% Selectores
% Extrae el código de una opción. Sabiendo que está en el primer lugar en la lista Option.
getOptionCode([Code|_], Code).