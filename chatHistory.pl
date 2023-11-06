% chatHistory/4
% Dominio: 

% Constructor de TDA chatHistory
chatHistory(Text, Sender, Timestamp, History) :-
    History = [Text, Sender, Timestamp].
