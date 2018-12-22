% -------------------------------------- PIECES MOVES HANDLERS --------------------------------------

% Attack

attackPositions(kings, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    attackPositionsKing(PieceColumn, PieceRow, OtherColumn, OtherRow).

attackPositions(knights, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    attackPositionsKnight(PieceColumn, PieceRow, OtherColumn, OtherRow).

attackPositions(rooks, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    attackPositionsRook(PieceColumn, PieceRow, OtherColumn, OtherRow).

attackPositions(bishops, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    attackPositionsBishop(PieceColumn, PieceRow, OtherColumn, OtherRow).

attackPositions(queens, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    attackPositionsQueen(PieceColumn, PieceRow, OtherColumn, OtherRow).


% No Attack

noAttackPositions(kings, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    noAttackPositionsKing(PieceColumn, PieceRow, OtherColumn, OtherRow).

noAttackPositions(knights, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    noAttackPositionsKnight(PieceColumn, PieceRow, OtherColumn, OtherRow).

noAttackPositions(rooks, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    noAttackPositionsRook(PieceColumn, PieceRow, OtherColumn, OtherRow).

noAttackPositions(bishops, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    noAttackPositionsBishop(PieceColumn, PieceRow, OtherColumn, OtherRow).

noAttackPositions(queens, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    noAttackPositionsQueen(PieceColumn, PieceRow, OtherColumn, OtherRow).


noAttackPositions(kings, PieceColumn, PieceRow, OtherColumn, OtherRow, MiddlePieceColumn, MiddlePieceRow) :-
    noAttackPositionsKing(PieceColumn, PieceRow, OtherColumn, OtherRow, MiddlePieceColumn, MiddlePieceRow).

noAttackPositions(knights, PieceColumn, PieceRow, OtherColumn, OtherRow, MiddlePieceColumn, MiddlePieceRow) :-
    noAttackPositionsKnight(PieceColumn, PieceRow, OtherColumn, OtherRow, MiddlePieceColumn, MiddlePieceRow).

noAttackPositions(rooks, PieceColumn, PieceRow, OtherColumn, OtherRow, MiddlePieceColumn, MiddlePieceRow) :-
    noAttackPositionsRook(PieceColumn, PieceRow, OtherColumn, OtherRow, MiddlePieceColumn, MiddlePieceRow).

noAttackPositions(bishops, PieceColumn, PieceRow, OtherColumn, OtherRow, MiddlePieceColumn, MiddlePieceRow) :-
    noAttackPositionsBishop(PieceColumn, PieceRow, OtherColumn, OtherRow, MiddlePieceColumn, MiddlePieceRow).

noAttackPositions(queens, PieceColumn, PieceRow, OtherColumn, OtherRow, MiddlePieceColumn, MiddlePieceRow) :-
    noAttackPositionsQueen(PieceColumn, PieceRow, OtherColumn, OtherRow, MiddlePieceColumn, MiddlePieceRow).



% -------------------------------------- KING MOVES --------------------------------------

attackPositionsKing(KingColumn, KingRow, OtherColumn, OtherRow) :-
    (OtherColumn #= KingColumn #/\ OtherRow #= KingRow+1) #\
    (OtherColumn #= KingColumn #/\ OtherRow #= KingRow-1) #\
    (OtherColumn #= KingColumn+1 #/\ OtherRow #= KingRow+1) #\
    (OtherColumn #= KingColumn+1 #/\ OtherRow #= KingRow-1) #\
    (OtherColumn #= KingColumn-1 #/\ OtherRow #= KingRow+1) #\
    (OtherColumn #= KingColumn-1 #/\ OtherRow #= KingRow-1) #\
    (OtherColumn #= KingColumn+1 #/\ OtherRow #= KingRow) #\
    (OtherColumn #= KingColumn-1 #/\ OtherRow #= KingRow).

noAttackPositionsKing(KingColumn, KingRow, OtherColumn, OtherRow) :-
    (OtherColumn #\= KingColumn #\/ OtherRow #\= KingRow+1) #/\
    (OtherColumn #\= KingColumn #\/ OtherRow #\= KingRow-1) #/\
    (OtherColumn #\= KingColumn+1 #\/ OtherRow #\= KingRow+1) #/\
    (OtherColumn #\= KingColumn+1 #\/ OtherRow #\= KingRow-1) #/\
    (OtherColumn #\= KingColumn-1 #\/ OtherRow #\= KingRow+1) #/\
    (OtherColumn #\= KingColumn-1 #\/ OtherRow #\= KingRow-1) #/\
    (OtherColumn #\= KingColumn+1 #\/ OtherRow #\= KingRow) #/\
    (OtherColumn #\= KingColumn-1 #\/ OtherRow #\= KingRow).

noAttackPositionsKing(KingColumn, KingRow, OtherColumn, OtherRow, _, _) :-
    (OtherColumn #\= KingColumn #\/ OtherRow #\= KingRow+1) #/\
    (OtherColumn #\= KingColumn #\/ OtherRow #\= KingRow-1) #/\
    (OtherColumn #\= KingColumn+1 #\/ OtherRow #\= KingRow+1) #/\
    (OtherColumn #\= KingColumn+1 #\/ OtherRow #\= KingRow-1) #/\
    (OtherColumn #\= KingColumn-1 #\/ OtherRow #\= KingRow+1) #/\
    (OtherColumn #\= KingColumn-1 #\/ OtherRow #\= KingRow-1) #/\
    (OtherColumn #\= KingColumn+1 #\/ OtherRow #\= KingRow) #/\
    (OtherColumn #\= KingColumn-1 #\/ OtherRow #\= KingRow).



% -------------------------------------- KNIGHT MOVES --------------------------------------

attackPositionsKnight(KnightColumn, KnightRow, OtherColumn, OtherRow) :-
    (OtherColumn #= KnightColumn+2 #/\ OtherRow #= KnightRow+1) #\
    (OtherColumn #= KnightColumn+2 #/\ OtherRow #= KnightRow-1) #\
    (OtherColumn #= KnightColumn-2 #/\ OtherRow #= KnightRow+1) #\
    (OtherColumn #= KnightColumn-2 #/\ OtherRow #= KnightRow-1) #\
    (OtherRow #= KnightRow+2 #/\ OtherColumn #= KnightColumn+1) #\
    (OtherRow #= KnightRow+2 #/\ OtherColumn #= KnightColumn-1) #\
    (OtherRow #= KnightRow-2 #/\ OtherColumn #= KnightColumn+1) #\
    (OtherRow #= KnightRow-2 #/\ OtherColumn #= KnightColumn-1).

noAttackPositionsKnight(KnightColumn, KnightRow, OtherColumn, OtherRow) :-
    (OtherColumn #\= KnightColumn+2 #\/ OtherRow #\= KnightRow+1) #/\
    (OtherColumn #\= KnightColumn+2 #\/ OtherRow #\= KnightRow-1) #/\
    (OtherColumn #\= KnightColumn-2 #\/ OtherRow #\= KnightRow+1) #/\
    (OtherColumn #\= KnightColumn-2 #\/ OtherRow #\= KnightRow-1) #/\
    (OtherRow #\= KnightRow+2 #\/ OtherColumn #\= KnightColumn+1) #/\
    (OtherRow #\= KnightRow+2 #\/ OtherColumn #\= KnightColumn-1) #/\
    (OtherRow #\= KnightRow-2 #\/ OtherColumn #\= KnightColumn+1) #/\
    (OtherRow #\= KnightRow-2 #\/ OtherColumn #\= KnightColumn-1).

noAttackPositionsKnight(KnightColumn, KnightRow, OtherColumn, OtherRow, _, _) :-
    (OtherColumn #\= KnightColumn+2 #\/ OtherRow #\= KnightRow+1) #/\
    (OtherColumn #\= KnightColumn+2 #\/ OtherRow #\= KnightRow-1) #/\
    (OtherColumn #\= KnightColumn-2 #\/ OtherRow #\= KnightRow+1) #/\
    (OtherColumn #\= KnightColumn-2 #\/ OtherRow #\= KnightRow-1) #/\
    (OtherRow #\= KnightRow+2 #\/ OtherColumn #\= KnightColumn+1) #/\
    (OtherRow #\= KnightRow+2 #\/ OtherColumn #\= KnightColumn-1) #/\
    (OtherRow #\= KnightRow-2 #\/ OtherColumn #\= KnightColumn+1) #/\
    (OtherRow #\= KnightRow-2 #\/ OtherColumn #\= KnightColumn-1).



% -------------------------------------- ROOK MOVES --------------------------------------

attackPositionsRook(RookColumn, RookRow, OtherColumn, OtherRow) :-
    (OtherColumn #= RookColumn #\ OtherRow #= RookRow).

noAttackPositionsRook(RookColumn, RookRow, OtherColumn, OtherRow) :-
    (OtherColumn #\= RookColumn #/\ OtherRow #\= RookRow).

noAttackPositionsRook(RookColumn, RookRow, OtherColumn, OtherRow, MiddlePieceColumn, MiddlePieceRow) :-
    (OtherColumn #\= RookColumn #/\ OtherRow #\= RookRow) #\
    (OtherColumn #= RookColumn #/\ OtherColumn #= MiddlePieceColumn #/\ OtherRow #< MiddlePieceRow #/\ MiddlePieceRow #< RookRow) #\
    (OtherColumn #= RookColumn #/\ OtherColumn #= MiddlePieceColumn #/\ OtherRow #> MiddlePieceRow #/\ MiddlePieceRow #> RookRow) #\
    (OtherRow #= RookRow #/\ OtherRow #= MiddlePieceRow #/\ OtherColumn #< MiddlePieceColumn #/\ MiddlePieceColumn #< RookColumn) #\
    (OtherRow #= RookRow #/\ OtherRow #= MiddlePieceRow #/\ OtherColumn #> MiddlePieceColumn #/\ MiddlePieceColumn #> RookColumn).


% -------------------------------------- BISHOP MOVES --------------------------------------

attackPositionsBishop(BishopColumn, BishopRow, OtherColumn, OtherRow) :-
    abs(BishopColumn - OtherColumn) #= abs(BishopRow - OtherRow).

noAttackPositionsBishop(BishopColumn, BishopRow, OtherColumn, OtherRow) :-
    abs(BishopColumn - OtherColumn) #\= abs(BishopRow - OtherRow).

noAttackPositionsBishop(BishopColumn, BishopRow, OtherColumn, OtherRow, MiddlePieceColumn, MiddlePieceRow) :-
    (abs(BishopColumn - OtherColumn) #\= abs(BishopRow - OtherRow)) #\
    (abs(BishopColumn - OtherColumn) #= abs(BishopRow - OtherRow) #/\ abs(BishopColumn - MiddlePieceColumn) #= abs(BishopRow - MiddlePieceRow) #/\ MiddlePieceColumn #> BishopColumn #/\ OtherColumn #> MiddlePieceColumn) #\
    (abs(BishopColumn - OtherColumn) #= abs(BishopRow - OtherRow) #/\ abs(BishopColumn - MiddlePieceColumn) #= abs(BishopRow - MiddlePieceRow) #/\ MiddlePieceColumn #< BishopColumn #/\ OtherColumn #< MiddlePieceColumn).



% -------------------------------------- QUEEN MOVES --------------------------------------

attackPositionsQueen(QueenColumn, QueenRow, OtherColumn, OtherRow) :-
    (OtherColumn #= QueenColumn #/\ OtherRow #\= QueenRow) #\
    (OtherColumn #\= QueenColumn #/\ OtherRow #= QueenRow) #\
    (abs(QueenColumn - OtherColumn) #= abs(QueenRow - OtherRow)).

noAttackPositionsQueen(QueenColumn, QueenRow, OtherColumn, OtherRow) :-
    (OtherColumn #\= QueenColumn #\/ OtherRow #= QueenRow) #/\
    (OtherColumn #= QueenColumn #\/ OtherRow #\= QueenRow) #/\
    (abs(QueenColumn - OtherColumn) #\= abs(QueenRow - OtherRow)).

noAttackPositionsQueen(QueenColumn, QueenRow, OtherColumn, OtherRow, MiddlePieceColumn, MiddlePieceRow) :-
    ((OtherColumn #\= QueenColumn #/\ OtherRow #\= QueenRow) #\
    (OtherColumn #= QueenColumn #/\ OtherColumn #= MiddlePieceColumn #/\ OtherRow #< MiddlePieceRow #/\ MiddlePieceRow #< QueenRow) #\
    (OtherColumn #= QueenColumn #/\ OtherColumn #= MiddlePieceColumn #/\ OtherRow #> MiddlePieceRow #/\ MiddlePieceRow #> QueenRow) #\
    (OtherRow #= QueenRow #/\ OtherRow #= MiddlePieceRow #/\ OtherColumn #< MiddlePieceColumn #/\ MiddlePieceColumn #< QueenColumn) #\
    (OtherRow #= QueenRow #/\ OtherRow #= MiddlePieceRow #/\ OtherColumn #> MiddlePieceColumn #/\ MiddlePieceColumn #> QueenColumn)) #/\
    ((abs(QueenColumn - OtherColumn) #\= abs(QueenRow - OtherRow)) #\
    (abs(QueenColumn - OtherColumn) #= abs(QueenRow - OtherRow) #/\ abs(QueenColumn - MiddlePieceColumn) #= abs(QueenRow - MiddlePieceRow) #/\ MiddlePieceColumn #> QueenColumn #/\ OtherColumn #> MiddlePieceColumn) #\
    (abs(QueenColumn - OtherColumn) #= abs(QueenRow - OtherRow) #/\ abs(QueenColumn - MiddlePieceColumn) #= abs(QueenRow - MiddlePieceRow) #/\ MiddlePieceColumn #< QueenColumn #/\ OtherColumn #< MiddlePieceColumn)).


