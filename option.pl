% Constructor
option(Code, Message, ChatbotCodeLink, InitialFlowCodeLink, PalabrasClave, Etiqueta) :-
    number(Code),
    string(Message),
    number(ChatbotCodeLink),
    number(InitialFlowCodeLink),
    is_list(PalabrasClave),
    Etiqueta = [Code, Message, ChatbotCodeLink, InitialFlowCodeLink, PalabrasClave].

% Hecho
option(2, "2 - estudiar", 4, 3, ["aprender", "perfeccionarme"], O2)