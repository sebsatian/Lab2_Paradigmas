% Constructor TDA option
% option/6
% Dominio: int code, string message, int chatbotCodeLink, int initialFlowCodeLink, list palabrasClave

% Constructor
option(Code, Message, ChatbotCodeLink, InitialFlowCodeLink, PalabrasClave, Option) :-

    string(Message),
    integer(ChatbotCodeLink),
    integer(InitialFlowCodeLink),
    is_list(PalabrasClave),
    % Construir la opción.
    Option = [Code, Message, ChatbotCodeLink, InitialFlowCodeLink, PalabrasClave].

% Selectores
% Extrae el código de una opción. Asumimos que la opción está representada como una lista,
% y el código es el primer elemento de esa lista.
getOptionCode([Code|_], Code).