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

symbol(empty, S) :- S=' '.
symbol(black, S) :- S='X'.
symbol(white, S) :- S='O'.

getColor('Player1', C) :- C = black.
getColor('Player2', C) :- C = white.
getColor('Computer1', C) :- C = black.
getColor('Computer2', C) :- C = white.


%-------------------------------------------------------
% PRINT BOARD

printBoard(B) :-
    nl, write('       A         B         C         D         E         F         G         H     '), nl,
    printBoard(B, 8),
    nl, write('       A         B         C         D         E         F         G         H     ').

printBoard([H|T], N) :-
    N > 0,
    write('  |---------|---------|---------|---------|---------|---------|---------|---------|'), nl,
    write('  |         |         |         |         |         |         |         |         |'), nl,
    write(N), write(' |'),
    printLine(H),
    write(' '), write(N), nl,
    write('  |         |         |         |         |         |         |         |         |'), nl,
    N1 is N-1,
    printBoard(T, N1).

printBoard([], _) :-
    write('  |---------|---------|---------|---------|---------|---------|---------|---------|').

printLine([H|T]) :-
    write('    '), symbol(H,S),
    write(S), write('    |'),
    printLine(T).

printLine([]).


%-------------------------------------------------------
% PRINT BOARD REVERSE

printBoardReverse(Board) :-
    reverseAllBoard(Board, BoardReverse),
    nl, write('       H         G         F         E         D         C         B         A     '), nl,
    printBoardReverse(BoardReverse, 1),
    nl, write('       H         G         F         E         D         C         B         A     ').

printBoardReverse([H|T], N) :-
    N < 9,
    write('  |---------|---------|---------|---------|---------|---------|---------|---------|'), nl,
    write('  |         |         |         |         |         |         |         |         |'), nl,
    write(N), write(' |'),
    printLine(H),
    write(' '), write(N), nl,
    write('  |         |         |         |         |         |         |         |         |'), nl,
    N1 is N+1,
    printBoardReverse(T, N1).

printBoardReverse([], _) :-
    write('  |---------|---------|---------|---------|---------|---------|---------|---------|').


%-------------------------------------------------------
% DISPLAY GAME

display_game(Board, 'Player2') :-
    printBoardReverse(Board).

display_game(Board, _Player) :-
    printBoard(Board).