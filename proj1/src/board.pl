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

symbol(empty, S) :- S=' '.
symbol(black, S) :- S='X'.
symbol(white, S) :- S='O'.

getColor(Player1, C) :- C = black.
getColor(Player2, C) :- C = white.

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

display_game(B, P) :-
    printBoard(B).

makeMove( OldBoard, Player, NewRow, NewColumn, NewBoard ):-
  write('Moving\n'),
	isWithinLimits(NewRow),
	isWithinLimits(NewColumn),
  getColor(Player, C),
  write(C), nl,
  makeMoveAux( OldBoard, 0, C, NewRow, NewColumn, [], NewBoard ).

makeMoveAux([], _, _, _, _, InvertedBoard, FinalBoard) :-
  reverse(InvertedBoard, FinalBoard).

makeMoveAux( [ CurrentLine | RestOfBoard ], N, S, X, Y, TempBoard, FinalBoard ):-
write('N is : '),
write(N), nl,
write('NewC is : '),
write(Y), nl,
  N == Y,(
    N1 is Y+1,
    replace( CurrentLine, X, S, NewLine ),
    write('Replaced\n'),nl,
    write(NewLine),
    makeMoveAux( RestOfBoard, N1, S, X, Y, [ NewLine | TempBoard ], FinalBoard)
  );(
    N1 is N+1,
    makeMoveAux( RestOfBoard, N1, S, X, Y, [ CurrentLine | TempBoard ], FinalBoard )
  ).
