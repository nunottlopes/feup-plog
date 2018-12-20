% -------------------------------------- PIECES MOVES HANDLERS --------------------------------------

valid_position(king, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    valid_position_king(PieceColumn, PieceRow, OtherColumn, OtherRow).

valid_position(knight, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    valid_position_knight(PieceColumn, PieceRow, OtherColumn, OtherRow).

invalid_position(king, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    invalid_position_king(PieceColumn, PieceRow, OtherColumn, OtherRow).

invalid_position(knight, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
    invalid_position_knight(PieceColumn, PieceRow, OtherColumn, OtherRow).

valid_position_knight(KnightColumn, KnightRow, OtherColumn, OtherRow) :-
    OtherColumn #= KnightColumn+2 #/\ OtherRow #= KnightRow+1 #\/
    OtherColumn #= KnightColumn+2 #/\ OtherRow #= KnightRow-1 #\/
    OtherColumn #= KnightColumn-2 #/\ OtherRow #= KnightRow+1 #\/
    OtherColumn #= KnightColumn-2 #/\ OtherRow #= KnightRow-1 #\/
    OtherRow #= KnightRow+2 #/\ OtherColumn #= KnightColumn+1 #\/
    OtherRow #= KnightRow+2 #/\ OtherColumn #= KnightColumn-1 #\/
    OtherRow #= KnightRow-2 #/\ OtherColumn #= KnightColumn+1 #\/
    OtherRow #= KnightRow-2 #/\ OtherColumn #= KnightColumn-1.

valid_position_king(KingColumn, KingRow, KnightColumn, KnightRow) :-
    KnightColumn #= KingColumn #/\ KnightRow #= KingRow+1 #\/
    KnightColumn #= KingColumn #/\ KnightRow #= KingRow-1 #\/
    KnightColumn #= KingColumn+1 #/\ KnightRow #= KingRow+1 #\/
    KnightColumn #= KingColumn+1 #/\ KnightRow #= KingRow-1 #\/
    KnightColumn #= KingColumn-1 #/\ KnightRow #= KingRow+1 #\/
    KnightColumn #= KingColumn-1 #/\ KnightRow #= KingRow-1 #\/
    KnightColumn #= KingColumn+1 #/\ KnightRow #= KingRow #\/
    KnightColumn #= KingColumn-1 #/\ KnightRow #= KingRow.

invalid_position_king(KingColumn, KingRow, KnightColumn, KnightRow) :-
    (KnightColumn #\= KingColumn #\/ KnightRow #\= KingRow+1) #/\
    (KnightColumn #\= KingColumn #\/ KnightRow #\= KingRow-1) #/\
    (KnightColumn #\= KingColumn+1 #\/ KnightRow #\= KingRow+1) #/\
    (KnightColumn #\= KingColumn+1 #\/ KnightRow #\= KingRow-1) #/\
    (KnightColumn #\= KingColumn-1 #\/ KnightRow #\= KingRow+1) #/\
    (KnightColumn #\= KingColumn-1 #\/ KnightRow #\= KingRow-1) #/\
    (KnightColumn #\= KingColumn+1 #\/ KnightRow #\= KingRow) #/\
    (KnightColumn #\= KingColumn-1 #\/ KnightRow #\= KingRow).

invalid_position_knight(KnightColumn, KnightRow, KingColumn, KingRow) :-
    (KingColumn #\= KnightColumn+2 #\/ KingRow #\= KnightRow+1) #/\
    (KingColumn #\= KnightColumn+2 #\/ KingRow #\= KnightRow-1) #/\
    (KingColumn #\= KnightColumn-2 #\/ KingRow #\= KnightRow+1) #/\
    (KingColumn #\= KnightColumn-2 #\/ KingRow #\= KnightRow-1) #/\
    (KingRow #\= KnightRow+2 #\/ KingColumn #\= KnightColumn+1) #/\
    (KingRow #\= KnightRow+2 #\/ KingColumn #\= KnightColumn-1) #/\
    (KingRow #\= KnightRow-2 #\/ KingColumn #\= KnightColumn+1) #/\
    (KingRow #\= KnightRow-2 #\/ KingColumn #\= KnightColumn-1).

% valid_position_Rook(RookColumn, RookRow, KingColumn, KingRow) :-
%     (KingColumn #= RookColumn #/\ KingRow #\= RookRow) #\/
%     (KingColumn #\= RookColumn #/\ KingRow #= RookRow).

% invalid_position_Rook(RookColumn, RookRow, KingColumn, KingRow) :-
%     (KingColumn #\= RookColumn #/\ KingRow #\= RookRow).

% valid_position_Bishop(BishopColumn, BishopRow, KingColumn, KingRow) :-
%     abs(BishopColumn - KingColumn) #= abs(BishopRow - KingRow).

% invalid_position_Bishop(BishopColumn, BishopRow, KingColumn, KingRow) :-
%     abs(BishopColumn - KingColumn) #\= abs(BishopRow - KingRow).

% valid_position_Queen(QueenColumn, QueenRow, KingColumn, KingRow) :-
%     (KingColumn #= QueenColumn #/\ KingRow #\= QueenRow) #\/
%     (KingColumn #\= QueenColumn #/\ KingRow #= QueenRow) #\/
%     (abs(QueenColumn - KingColumn) #= abs(QueenRow - KingRow)).

% invalid_position_Queen(QueenColumn, QueenRow, KingColumn, KingRow) :-
%     (KingColumn #\= QueenColumn #/\ KingRow #\= QueenRow) #\/
%     abs(QueenColumn - KingColumn) #\= abs(QueenRow - KingRow).
