emptyBoard([
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty]
]).

initialBoard([
    [empty, empty, white, white, white, white, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, black, black, black, black, empty, empty]
]).

finalBoard([
    [empty, empty, white, empty, empty, empty, white, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, black, empty],
    [empty, empty, black, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, white, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, white, empty, empty, empty, black],
    [empty, empty, empty, black, empty, empty, empty, empty]
]).

symbol(empty, S) :- S=' '.
symbol(black, S) :- S='X'.
symbol(white, S) :- S='O'.

printBoard(B) :-
    write('       A         B         C         D         E         F         G         H     '),
    nl,
    printBoard(B, 8),
    nl,
    write('       A         B         C         D         E         F         G         H     ').

printBoard([H|T], N) :-
    N > 0,
    write('  |---------|---------|---------|---------|---------|---------|---------|---------|'),
    nl,
    write('  |         |         |         |         |         |         |         |         |'),
    nl,
    write(N),
    write(' |'),
    printLine(H),
    write(' '),
    write(N),
    nl,
    write('  |         |         |         |         |         |         |         |         |'),
    nl,
    N1 is N-1,
    printBoard(T, N1).

printBoard([], _) :-
    write('  |---------|---------|---------|---------|---------|---------|---------|---------|').

printLine([H|T]) :-
    write('    '),
    symbol(H,S),
    write(S),
    write('    |'),
    printLine(T).

printLine([]).

display_game(B, P) :- 
    printBoard(B).

movePiece(InitialBoard, InitialColumn, InitialRow, NewColumn, NewRow, NewBoard) :-
    checkEmptySpot(InitialBoard, InitialColumn, InitialRow).

checkEmptySpot(InitialBoard, InitialColumn, InitialRow) :-
    write('empty spot').
