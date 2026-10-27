
% Участники автомобильных гонок

% Петя не занял второе и третье места
place(petya, 1).

% Коля не занял третье место
place(kolya, 1).
place(kolya, 2).

% Алёша может занять любое место
place(alesha, 1).
place(alesha, 2).
place(alesha, 3).


% Проверка, что все места различны
all_different([]).

all_different([H|T]) :-
    \+ member(H, T),
    all_different(T).


% Поиск решения
solve(Alesha, Petya, Kolya) :-
    place(alesha, Alesha),
    place(petya, Petya),
    place(kolya, Kolya),
    all_different([Alesha, Petya, Kolya]).
