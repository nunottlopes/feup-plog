% -------------------------------------- GET BOARD POSITION WITH CONSTRAINT LOGIC PROGRAMMING --------------------------------------

getMatrixPositionPLR(Position, NumColumns, PosRow, PosColumn) :-
    getColumnPLR(Position, NumColumns, PosColumn),
    getRowPLR(Position, NumColumns, PosRow).

getColumnPLR(Position, NumColumns, PosColumn) :-
    ((Position mod NumColumns) #= 0 #/\ PosColumn #= NumColumns) #\/
    ((Position mod NumColumns) #\= 0 #/\ PosColumn #= (Position mod NumColumns)).

getRowPLR(Position, NumColumns, PosRow) :-
    ((Position mod NumColumns) #= 0 #/\ PosRow #= Position/NumColumns) #\
    ((Position mod NumColumns) #\= 0 #/\ PosRow #= (Position/NumColumns +1)).


% -------------------------------------- GET BOARD POSITION --------------------------------------

getMatrixPosition(Position, NumColumns, PosRow, PosColumn) :-
    getColumn(Position, NumColumns, PosColumn),
    getRow(Position, NumColumns, PosRow).

getColumn(Position, NumColumns, PosColumn) :-
    (Position mod NumColumns) =:= 0, !,
    PosColumn is NumColumns;
    PosColumn is (Position mod NumColumns).

getRow(Position, NumColumns, PosRow) :-
    floor(Position/NumColumns) =:= ceiling(Position/NumColumns), !,
    PosRow is round(Position/NumColumns);
    PosRow is floor(Position/NumColumns)+1.


% -------------------------------------- BOARD DISPLAY --------------------------------------

symbol(empty, S) :- S=' '.
symbol(kings, S) :- S='\x2654\'.
symbol(knights, S) :- S='\x2658\'.
symbol(queens, S) :- S='\x2655\'.
symbol(bishops, S) :- S='\x2657\'.
symbol(rooks, S) :- S='\x2656\'.

replaceBoard([],_,NewBoard,NewBoard).
replaceBoard([H|T], Type, Board, NewBoard) :-
    replace(Board, H, Type, NewBoard1),
    replaceBoard(T, Type, NewBoard1, NewBoard).

generateEmptyBoard(N, Board) :-
    generateBoard(N, [], Board).

generateBoard(0, Board, Board).
generateBoard(N, BoardIterator, Board) :-
    N > 0,
    append([empty], BoardIterator, NewBoard),
    N1 is N-1,
    generateBoard(N1, NewBoard, Board).

writeBoard([], _).
writeBoard([H|T], NumColumns, Counter) :-
    X is floor(Counter/NumColumns),
    Y is ceiling(Counter/NumColumns),
    X == Y, !,
    printSquare(H), write(' |'), nl,
    Counter1 is Counter+1,
    writeBoard(T, NumColumns, Counter1);
    printSquare(H),
    Counter1 is Counter+1,
    writeBoard(T, NumColumns, Counter1).

printSquare(Piece) :-
    symbol(Piece, PieceSymbol),
    write(' |'),
    write(PieceSymbol).

displayBoard(NumColumns, NumRows, Pieces1, TypePiece1, Pieces2, TypePiece2) :-
    Size is NumColumns*NumRows,
    generateEmptyBoard(Size, Board),
    replaceBoard(Pieces1, TypePiece1, Board, NewBoard),
    replaceBoard(Pieces2, TypePiece2, NewBoard, NewBoard1), !,
    writeBoard(NewBoard1, NumColumns, 1).

