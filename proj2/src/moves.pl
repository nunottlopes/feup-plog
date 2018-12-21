% -------------------------------------- PIECES MOVES HANDLERS --------------------------------------

% Attack

attackPositions(king, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    attackPositionsKing(PieceColumn, PieceRow, OtherColumn, OtherRow).

attackPositions(knight, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    attackPositionsKnight(PieceColumn, PieceRow, OtherColumn, OtherRow).

attackPositions(rook, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    attackPositionsRook(PieceColumn, PieceRow, OtherColumn, OtherRow).

attackPositions(bishop, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    attackPositionsBishop(PieceColumn, PieceRow, OtherColumn, OtherRow).

attackPositions(queen, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    attackPositionsQueen(PieceColumn, PieceRow, OtherColumn, OtherRow).


% No Attack

noAttackPositions(king, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    noAttackPositionsKing(PieceColumn, PieceRow, OtherColumn, OtherRow).

noAttackPositions(knight, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    noAttackPositionsKnight(PieceColumn, PieceRow, OtherColumn, OtherRow).

noAttackPositions(rook, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    noAttackPositionsRook(PieceColumn, PieceRow, OtherColumn, OtherRow).

noAttackPositions(bishop, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    noAttackPositionsBishop(PieceColumn, PieceRow, OtherColumn, OtherRow).

noAttackPositions(queen, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    noAttackPositionsQueen(PieceColumn, PieceRow, OtherColumn, OtherRow).



% -------------------------------------- KING MOVES --------------------------------------

attackPositionsKing(KingColumn, KingRow, OtherColumn, OtherRow) :-
    OtherColumn #= KingColumn #/\ OtherRow #= KingRow+1 #\/
    OtherColumn #= KingColumn #/\ OtherRow #= KingRow-1 #\/
    OtherColumn #= KingColumn+1 #/\ OtherRow #= KingRow+1 #\/
    OtherColumn #= KingColumn+1 #/\ OtherRow #= KingRow-1 #\/
    OtherColumn #= KingColumn-1 #/\ OtherRow #= KingRow+1 #\/
    OtherColumn #= KingColumn-1 #/\ OtherRow #= KingRow-1 #\/
    OtherColumn #= KingColumn+1 #/\ OtherRow #= KingRow #\/
    OtherColumn #= KingColumn-1 #/\ OtherRow #= KingRow.

noAttackPositionsKing(KingColumn, KingRow, OtherColumn, OtherRow) :-
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
    OtherColumn #= KnightColumn+2 #/\ OtherRow #= KnightRow+1 #\/
    OtherColumn #= KnightColumn+2 #/\ OtherRow #= KnightRow-1 #\/
    OtherColumn #= KnightColumn-2 #/\ OtherRow #= KnightRow+1 #\/
    OtherColumn #= KnightColumn-2 #/\ OtherRow #= KnightRow-1 #\/
    OtherRow #= KnightRow+2 #/\ OtherColumn #= KnightColumn+1 #\/
    OtherRow #= KnightRow+2 #/\ OtherColumn #= KnightColumn-1 #\/
    OtherRow #= KnightRow-2 #/\ OtherColumn #= KnightColumn+1 #\/
    OtherRow #= KnightRow-2 #/\ OtherColumn #= KnightColumn-1.

noAttackPositionsKnight(KnightColumn, KnightRow, OtherColumn, OtherRow) :-
    (OtherColumn #\= KnightColumn+2 #\/ OtherRow #\= KnightRow+1) #/\
    (OtherColumn #\= KnightColumn+2 #\/ OtherRow #\= KnightRow-1) #/\
    (OtherColumn #\= KnightColumn-2 #\/ OtherRow #\= KnightRow+1) #/\
    (OtherColumn #\= KnightColumn-2 #\/ OtherRow #\= KnightRow-1) #/\
    (OtherRow #\= KnightRow+2 #\/ OtherColumn #\= KnightColumn+1) #/\
    (OtherRow #\= KnightRow+2 #\/ OtherColumn #\= KnightColumn-1) #/\
    (OtherRow #\= KnightRow-2 #\/ OtherColumn #\= KnightColumn+1) #/\
    (OtherRow #\= KnightRow-2 #\/ OtherColumn #\= KnightColumn-1).



% -------------------------------------- ROOK MOVES --------------------------------------

attackPositionsRook(RookColumn, RookRow, KingColumn, KingRow) :-
    (KingColumn #= RookColumn #/\ KingRow #\= RookRow) #\/
    (KingColumn #\= RookColumn #/\ KingRow #= RookRow).

noAttackPositionsRook(RookColumn, RookRow, KingColumn, KingRow) :-
    (KingColumn #\= RookColumn #/\ KingRow #\= RookRow).



% -------------------------------------- BISHOP MOVES --------------------------------------

attackPositionsBishop(BishopColumn, BishopRow, KingColumn, KingRow) :-
    abs(BishopColumn - KingColumn) #= abs(BishopRow - KingRow).

noAttackPositionsBishop(BishopColumn, BishopRow, KingColumn, KingRow) :-
    abs(BishopColumn - KingColumn) #\= abs(BishopRow - KingRow).



% -------------------------------------- QUEEN MOVES --------------------------------------

attackPositionsQueen(QueenColumn, QueenRow, KingColumn, KingRow) :-
    (KingColumn #= QueenColumn #/\ KingRow #\= QueenRow) #\/
    (KingColumn #\= QueenColumn #/\ KingRow #= QueenRow) #\/
    (abs(QueenColumn - KingColumn) #= abs(QueenRow - KingRow)).

noAttackPositionsQueen(QueenColumn, QueenRow, KingColumn, KingRow) :-
    (KingColumn #\= QueenColumn #/\ KingRow #\= QueenRow) #\/
    abs(QueenColumn - KingColumn) #\= abs(QueenRow - KingRow).
