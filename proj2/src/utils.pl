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