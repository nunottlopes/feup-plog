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
    write('FROM:\n > Row: '),
    write(OldRow), nl,
    write(' > Column: '),
    write(OldColumn), nl,
    write('TO:\n > Row: '),
    write(NewRow), nl,
    write(' > Column: '),
    write(NewColumn), nl.


