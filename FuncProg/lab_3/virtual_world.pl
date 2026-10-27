
% Объекты виртуального мира

object(apple).
object(banana).
object(orange).
object(pear).
object(grape).
object(book).
object(magazine).
object(comic).

% Предпочтения Анны
likes(anna, apple).
likes(anna, banana).
likes(anna, book).

% Предпочтения Петра
likes(peter, orange).
likes(peter, pear).
likes(peter, comic).

% Предпочтения Марии
likes(maria, grape).
likes(maria, book).
likes(maria, magazine).

% Предпочтения Ивана
likes(ivan, apple).
likes(ivan, orange).
likes(ivan, comic).

% Объекты, которые нравятся человеку
preferred(Person, Object) :-
    likes(Person, Object).

% Объекты, которые не нравятся человеку
not_preferred(Person, Object) :-
    object(Object),
    \+ likes(Person, Object).
