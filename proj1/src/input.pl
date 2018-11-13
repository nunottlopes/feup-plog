readExistPiece(Player, OldRow, OldColumn, OldBoard) :-
    write('> Row'), read(R),
    write('> Column'), read(C),
    convertRow(R, Rnumber),
    convertColumn(C, Cnumber),
    checkPieceOnPosition(Rnumber, Cnumber, Player, OldBoard, Valid),
    (Valid == 1 -> (
        write('\n> No piece in that position, please chose another one\n'),
        readExistPiece(Player, OldRow, OldColumn, OldBoard)
    );(
        OldRow = Rnumber,
        OldColumn = Cnumber
    )).

readNewPiece(OldRow, OldColumn, NewRow, NewColumn, OldBoard) :-
    write('> Row'), read(R),
    write('> Column'), read(C),
    convertRow(R, Rnumber),
    convertColumn(C, Cnumber),
    checkValidNewPosition(OldRow, OldColumn, Rnumber, Cnumber, OldBoard, Valid),
    (Valid == 1 -> (
        write('\n> Invalid position to place the piece, please chose another one\n'),
        readNewPiece(OldRow, OldColumn, NewRow, NewColumn, OldBoard)
    );(
        NewRow = Rnumber,
        NewColumn = Cnumber
    )).

convertRow(1, T) :-
    T = 8.

convertRow(2, T) :-
    T = 7.

convertRow(3, T) :-
    T = 6.

convertRow(4, T) :-
    T = 5.

convertRow(5, T) :-
    T = 4.

convertRow(6, T) :-
    T = 3.

convertRow(7, T) :-
    T = 2.

convertRow(8, T) :-
    T = 1.

convertRow(_, T) :-
    % Error
    T = 10.

convertColumn('a', V) :-
    V = 1.

convertColumn('b', V) :-
    V = 2.

convertColumn('c', V) :-
    V = 3.

convertColumn('d', V) :-
    V = 4.

convertColumn('e', V) :-
    V = 5.

convertColumn('f', V) :-
    V = 6.

convertColumn('g', V) :-
    V = 7.

convertColumn('h', V) :-
    V = 8.

convertColumn(_, V) :- !,
    % Error
    V = 10.

