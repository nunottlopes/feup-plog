moveComputer(OldBoard, NewBoard, Player, Level) :-
    choose_move(Player, OldBoard, Level, OldRow, OldColumn, NewRow, NewColumn),
    makeMove(OldBoard, Player, OldRow, OldColumn, NewRow, NewColumn, NewBoard),
    printComputerMove(OldRow, OldColumn, NewRow, NewColumn).

choose_move(Player, Board, 1, OldRow, OldColumn, NewRow, NewColumn) :-
    valid_moves(Player, Board, [], Ret),
    random_member([OldRow, OldColumn, NewRow, NewColumn], Ret).


choose_move(Player, Board, 2, OldRow, OldColumn, NewRow, NewColumn) :-
    write('nivel dificil\n'),
    write('chamar aqui a função que gera todas as Moves possiveis').


printComputerMove(OldRow, OldColumn, NewRow, NewColumn) :-
    convertRowReverse(OldRow, OR),
    convertColumnReverse(OldColumn, OC),
    convertRowReverse(NewRow, NR),
    convertColumnReverse(NewColumn, NC),
    write('FROM:\n > Row: '),
    write(OR), nl,
    write(' > Column: '),
    write(OC), nl,
    write('TO:\n > Row: '),
    write(NR), nl,
    write(' > Column: '),
    write(NC), nl.

convertRowReverse(1, T) :-
    T = 8.

convertRowReverse(2, T) :-
    T = 7.

convertRowReverse(3, T) :-
    T = 6.

convertRowReverse(4, T) :-
    T = 5.

convertRowReverse(5, T) :-
    T = 4.

convertRowReverse(6, T) :-
    T = 3.

convertRowReverse(7, T) :-
    T = 2.

convertRowReverse(8, T) :-
    T = 1.

convertColumnReverse(1, V) :-
    V = 'A'.

convertColumnReverse(2, V) :-
    V = 'B'.

convertColumnReverse(3, V) :-
    V = 'C'.

convertColumnReverse(4, V) :-
    V = 'D'.

convertColumnReverse(5, V) :-
    V = 'E'.

convertColumnReverse(6, V) :-
    V = 'F'.

convertColumnReverse(7, V) :-
    V = 'G'.

convertColumnReverse(8, V) :-
    V = 'H'.
