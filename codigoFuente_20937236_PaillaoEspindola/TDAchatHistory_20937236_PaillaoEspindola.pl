
%--------------------------- chatHistory/4 ---------------------------
% chatHistory/4
% Dominio: Text (string), Sender (string), Timestamp (string), History (list).

% Constructor de TDA chatHistory

chatHistory(Text, Sender, Timestamp, History) :-
    History = [Text, Sender, Timestamp].