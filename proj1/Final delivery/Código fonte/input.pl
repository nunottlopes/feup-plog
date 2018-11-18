%----------------------------------------------------------------
% READ INPUT AND CHECK IF THERE IS A PIECE IN THE POSITION CHOSEN

readExistPiece(Player, OldRow, OldColumn, OldBoard) :-
    write('> Row'), read(R),
    write('> Column'), read(C),
    convertRow(R, Rnumber),
    convertColumn(C, Cnumber),
    checkPieceOnPosition(Rnumber, Cnumber, Player, OldBoard, Valid),
    convertIndex(Rnumber, Row),
    convertIndex(Cnumber, Column),
    getMovesList(Player, OldBoard, Row, Column, 0, 0, [], ListOfMoves),
    handleResponsePieceOldPosition(Valid, Player, OldRow, OldColumn, OldBoard, Rnumber, Cnumber, ListOfMoves).

handleResponsePieceOldPosition(2, Player, OldRow, OldColumn, OldBoard, _Rnumber, _Cnumber, []) :-
    write('> No available moves for that piece, please chose another one\n'),
    readExistPiece(Player, OldRow, OldColumn, OldBoard).

handleResponsePieceOldPosition(1, Player, OldRow, OldColumn, OldBoard, _Rnumber, _Cnumber, _) :-
    write('> No piece in that position, please chose another one\n'),
    readExistPiece(Player, OldRow, OldColumn, OldBoard).

handleResponsePieceOldPosition(_, _Player, OldRow, OldColumn, _OldBoard, Rnumber, Cnumber, _) :-
    OldRow = Rnumber,
    OldColumn = Cnumber.


%--------------------------------------------------------------------------------
% READ INPUT AND CHECK IF IT IS POSSIBLE TO MOVE THE PIECE TO THE POSITION CHOSEN

readNewPiece(OldRow, OldColumn, NewRow, NewColumn, OldBoard) :-
    write('> Row'), read(R),
    write('> Column'), read(C),
    convertRow(R, Rnumber),
    convertColumn(C, Cnumber),
    checkValidNewPosition(OldRow, OldColumn, Rnumber, Cnumber, OldBoard, Valid),
    handleResponsePieceNewPosition(Valid, OldRow, OldColumn, NewRow, NewColumn, OldBoard, Rnumber, Cnumber).

handleResponsePieceNewPosition(1, OldRow, OldColumn, NewRow, NewColumn, OldBoard, _Rnumber, _Cnumber) :-
    write('> Invalid position to place the piece, please chose another one\n'),
    readNewPiece(OldRow, OldColumn, NewRow, NewColumn, OldBoard).

handleResponsePieceNewPosition(_, _OldRow, _OldColumn, NewRow, NewColumn, _OldBoard, Rnumber, Cnumber) :-
    NewRow = Rnumber,
    NewColumn = Cnumber.


%----------------------------------------------------------------
% CONVERT INPUT TO VALUES USED BY THE FUNCTIONS

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

convertIndex(1, I) :-
    I = 0.

convertIndex(2, I) :-
    I = 1.

convertIndex(3, I) :-
    I = 2.

convertIndex(4, I) :-
    I = 3.

convertIndex(5, I) :-
    I = 4.

convertIndex(6, I) :-
    I = 5.

convertIndex(7, I) :-
    I = 6.

convertIndex(8, I) :-
    I = 7.
