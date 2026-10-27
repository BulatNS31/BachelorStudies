

% Два человека живут в соседних домах
next_to(X, Y, List) :-
    nth1(PosX, List, X),
    nth1(PosY, List, Y),
    abs(PosX - PosY) =:= 1.

% X живёт левее Y
left_of(X, Y, List) :-
    nth1(PosX, List, X),
    nth1(PosY, List, Y),
    PosX < PosY.

% Получение позиции элемента в списке
position(X, List, Pos) :-
    nth1(Pos, List, X).

% Поиск подходящего расположения
solve(People, Professions) :-

    % Люди в домах слева направо
    permutation(
        [semyon, nikolay, arthur, roman],
        People
    ),

    % Профессии в домах слева направо
    permutation(
        [doctor, artist, gamekeeper, trainer],
        Professions
    ),

    % Семён живёт рядом с Николаем
    next_to(semyon, nikolay, People),

    % Артур не живёт рядом с Романом
    \+ next_to(arthur, roman, People),

    % Художник живёт рядом с тренером
    next_to(artist, trainer, Professions),

    % Врач живёт рядом с художником
    next_to(doctor, artist, Professions),

    % Егерь живёт левее врача
    left_of(gamekeeper, doctor, Professions),

    % Тренер не живёт рядом с егерем
    \+ next_to(trainer, gamekeeper, Professions),

    % Художник живёт правее Семёна
    position(semyon, People, SemyonPos),
    position(artist, Professions, ArtistPos),
    ArtistPos > SemyonPos,

    % Роман не является тренером
    position(roman, People, RomanPos),
    nth1(RomanPos, Professions, RomanProfession),
    RomanProfession \= trainer.
