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
    PosColumn is 5;
    PosColumn is (Position mod NumColumns).

getRow(Position, NumColumns, PosRow) :-
    floor(Position/NumColumns) =:= ceiling(Position/NumColumns), !,
    PosRow is round(Position/NumColumns);
    PosRow is floor(Position/NumColumns)+1.