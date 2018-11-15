:- use_module(library(lists)).

initialBoard([
    [empty, empty, white, white, white, white, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, black, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, black, empty],
    [empty, empty, black, empty, empty, empty, empty, empty],
    [empty, empty, black, black, black, black, empty, empty]
]).

matrix(Matrix, I, J, Value) :-
    nth0(I, Matrix, Row),
    nth0(J, Row, Value).

test :-
    initialBoard(X),
    matrix(X,0,7,Value),
    write('Value: '),
    write(Value).
