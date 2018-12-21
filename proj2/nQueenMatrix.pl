% Para aprender

% Colocar, num tabuleiro com NxN casas, N rainhas (de xadrez), sem que nenhuma
% rainha ataque nenhuma outra (não podem estar na mesma linha horizontal,
% vertical ou diagonal)

:- use_module(library(clpfd)).

re :-
    reconsult(nQueenMatrix).

knight(List, Piece) :-
    length(PosRow, 4), % Board de 4x4
    domain(PosRow, 1, 4),
    length(PosCol, 4),
    domain(PosCol, 1, 4),
    knightAttack(1,2, PosRow, PosCol),
    labeling([], [PosRow, PosCol]).

verifyKnight([H|T], Index, X, Y, Piece) :-
    % getMatrixPosition(Index, 4, PosRow, PosCol),
    knightAttack(X, Y, PosRow, PosCol),
    Index1 is Index + 1,
    verifyKnight(T, Index1, X, Y, Piece).

knightAttack(X, Y, PosRow, PosCol) :-
    (PosRow #\= X + 2  #/\ PosCol #\= Y + 1)
    #\/ (PosRow #\= X + 2  #/\ PosCol #\= Y - 1)
    #\/ (PosRow #\= X - 2  #/\ PosCol #\= Y + 1)
    #\/ (PosRow #\= X - 2  #/\ PosCol #\= Y - 1)
    #\/ (PosRow #\= X + 1  #/\ PosCol #\= Y + 2)
    #\/ (PosRow #\= X + 1  #/\ PosCol #\= Y - 2)
    #\/ (PosRow #\= X - 1  #/\ PosCol #\= Y + 2)
    #\/ (PosRow #\= X - 1  #/\ PosCol #\= Y - 2).



valid_position_king(KingColumn, KingRow, KnightColumn, KnightRow) :-
    % KnightColumn #= KingColumn #/\ KnightRow #= KingRow+1 #\/
    % KnightColumn #= KingColumn #/\ KnightRow #= KingRow-1 #\/
    % KnightColumn #= KingColumn+1 #/\ KnightRow #= KingRow+1 #\/
    % KnightColumn #= KingColumn+1 #/\ KnightRow #= KingRow-1 #\/
    % KnightColumn #= KingColumn-1 #/\ KnightRow #= KingRow+1 #\/
    % KnightColumn #= KingColumn-1 #/\ KnightRow #= KingRow-1 #\/
    % KnightColumn #= KingColumn+1 #/\ KnightRow #= KingRow #\/
    % KnightColumn #= KingColumn-1 #/\ KnightRow #= KingRow.
    (KnightColumn #\= KingColumn #\/ KnightRow #\= KingRow+1) #/\
    (KnightColumn #\= KingColumn #\/ KnightRow #\= KingRow-1) #/\
    (KnightColumn #\= KingColumn+1 #\/ KnightRow #\= KingRow+1) #/\
    (KnightColumn #\= KingColumn+1 #\/ KnightRow #\= KingRow-1) #/\
    (KnightColumn #\= KingColumn-1 #\/ KnightRow #\= KingRow+1) #/\
    (KnightColumn #\= KingColumn-1 #\/ KnightRow #\= KingRow-1) #/\
    (KnightColumn #\= KingColumn+1 #\/ KnightRow #\= KingRow) #/\
    (KnightColumn #\= KingColumn-1 #\/ KnightRow #\= KingRow).

valid_position_knight(KnightColumn, KnightRow, KingColumn, KingRow) :-
    (KingColumn #\= KnightColumn+2 #\/ KingRow #\= KnightRow+1) #/\
    (KingColumn #\= KnightColumn+2 #\/ KingRow #\= KnightRow-1) #/\
    (KingColumn #\= KnightColumn-2 #\/ KingRow #\= KnightRow+1) #/\
    (KingColumn #\= KnightColumn-2 #\/ KingRow #\= KnightRow-1) #/\
    (KingRow #\= KnightRow+2 #\/ KingColumn #\= KnightColumn+1) #/\
    (KingRow #\= KnightRow+2 #\/ KingColumn #\= KnightColumn-1) #/\
    (KingRow #\= KnightRow-2 #\/ KingColumn #\= KnightColumn+1) #/\
    (KingRow #\= KnightRow-2 #\/ KingColumn #\= KnightColumn-1).

valid_position_knight(KnightColumn, KnightRow, KingColumn, KingRow) :-
(PosRow #\= X + 2  #/\ PosCol #\= Y + 1)
#\/ (PosRow #\= X + 2  #/\ PosCol #\= Y - 1)
#\/ (PosRow #\= X - 2  #/\ PosCol #\= Y + 1)
#\/ (PosRow #\= X - 2  #/\ PosCol #\= Y - 1)
#\/ (PosRow #\= X + 1  #/\ PosCol #\= Y + 2)
#\/ (PosRow #\= X + 1  #/\ PosCol #\= Y - 2)
#\/ (PosRow #\= X - 1  #/\ PosCol #\= Y + 2)
#\/ (PosRow #\= X - 1  #/\ PosCol #\= Y - 2).


invalid_position_knight(KnightColumn, KnightRow, KingColumn, KingRow) :-
    (KingColumn #\= KnightColumn+2 #\/ KingRow #\= KnightRow+1) #/\
    (KingColumn #\= KnightColumn+2 #\/ KingRow #\= KnightRow-1) #/\
    (KingColumn #\= KnightColumn-2 #\/ KingRow #\= KnightRow+1) #/\
    (KingColumn #\= KnightColumn-2 #\/ KingRow #\= KnightRow-1) #/\
    (KingRow #\= KnightRow+2 #\/ KingColumn #\= KnightColumn+1) #/\
    (KingRow #\= KnightRow+2 #\/ KingColumn #\= KnightColumn-1) #/\
    (KingRow #\= KnightRow-2 #\/ KingColumn #\= KnightColumn+1) #/\
    (KingRow #\= KnightRow-2 #\/ KingColumn #\= KnightColumn-1).


valid_position_Rook(RookColumn, RookRow, KingColumn, KingRow) :-
    (KingColumn #= RookColumn #/\ KingRow #\= RookRow) #\/
    (KingColumn #\= RookColumn #/\ KingRow #= RookRow).

invalid_position_Rook(RookColumn, RookRow, KingColumn, KingRow) :-
    (KingColumn #\= RookColumn #/\ KingRow #\= RookRow).

valid_position_Bishop(BishopColumn, BishopRow, KingColumn, KingRow) :-
    abs(BishopColumn - KingColumn) #= abs(BishopRow - KingRow).

invalid_position_Bishop(BishopColumn, BishopRow, KingColumn, KingRow) :-
    abs(BishopColumn - KingColumn) #\= abs(BishopRow - KingRow).

valid_position_Queen(QueenColumn, QueenRow, KingColumn, KingRow) :-
    (KingColumn #= QueenColumn #/\ KingRow #\= QueenRow) #\/
    (KingColumn #\= QueenColumn #/\ KingRow #= QueenRow) #\/
    (abs(QueenColumn - KingColumn) #= abs(QueenRow - KingRow)).

invalid_position_Queen(QueenColumn, QueenRow, KingColumn, KingRow) :-
    (KingColumn #\= QueenColumn #/\ KingRow #\= QueenRow) #\/
    abs(QueenColumn - KingColumn) #\= abs(QueenRow - KingRow).



    
