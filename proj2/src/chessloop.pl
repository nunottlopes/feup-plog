:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(random)).

:- include('board.pl').

re :-
    reconsult('chessloop').

valid_position_knight(KnightColumn, KnightRow, KingColumn, KingRow) :-
    KingColumn #= KnightColumn+2 #/\ KingRow #= KnightRow+1 #\/
    KingColumn #= KnightColumn+2 #/\ KingRow #= KnightRow-1 #\/
    KingColumn #= KnightColumn-2 #/\ KingRow #= KnightRow+1 #\/
    KingColumn #= KnightColumn-2 #/\ KingRow #= KnightRow-1 #\/
    KingRow #= KnightRow+2 #/\ KingColumn #= KnightColumn+1 #\/
    KingRow #= KnightRow+2 #/\ KingColumn #= KnightColumn-1 #\/
    KingRow #= KnightRow-2 #/\ KingColumn #= KnightColumn+1 #\/
    KingRow #= KnightRow-2 #/\ KingColumn #= KnightColumn-1.

valid_position_king(KingColumn, KingRow, KnightColumn, KnightRow) :-
    KnightColumn #= KingColumn #/\ KnightRow #= KingRow+1 #\/
    KnightColumn #= KingColumn #/\ KnightRow #= KingRow-1 #\/
    KnightColumn #= KingColumn+1 #/\ KnightRow #= KingRow+1 #\/
    KnightColumn #= KingColumn+1 #/\ KnightRow #= KingRow-1 #\/
    KnightColumn #= KingColumn-1 #/\ KnightRow #= KingRow+1 #\/
    KnightColumn #= KingColumn-1 #/\ KnightRow #= KingRow-1 #\/
    KnightColumn #= KingColumn+1 #/\ KnightRow #= KingRow #\/
    KnightColumn #= KingColumn-1 #/\ KnightRow #= KingRow.

% invalid_position_knight(KnightColumn, KnightRow, KingColumn, KingRow) :-
%     KingColumn #\= KnightColumn+2 #\/ KingRow #\= KnightRow+1 #/\
%     KingColumn #\= KnightColumn+2 #\/ KingRow #\= KnightRow-1 #/\
%     KingColumn #\= KnightColumn-2 #\/ KingRow #\= KnightRow+1 #/\
%     KingColumn #\= KnightColumn-2 #\/ KingRow #\= KnightRow-1 #/\
%     KingRow #\= KnightRow+2 #\/ KingColumn #\= KnightColumn+1 #/\
%     KingRow #\= KnightRow+2 #\/ KingColumn #\= KnightColumn-1 #/\
%     KingRow #\= KnightRow-2 #\/ KingColumn #\= KnightColumn+1 #/\
%     KingRow #\= KnightRow-2 #\/ KingColumn #\= KnightColumn-1.

invalid_position_king(KingColumn, KingRow, KnightColumn, KnightRow) :-
    (KnightColumn #\= KingColumn #\/ KnightRow #\= KingRow+1) #/\
    (KnightColumn #\= KingColumn #\/ KnightRow #\= KingRow-1) #/\
    (KnightColumn #\= KingColumn+1 #\/ KnightRow #\= KingRow+1) #/\
    (KnightColumn #\= KingColumn+1 #\/ KnightRow #\= KingRow-1) #/\
    (KnightColumn #\= KingColumn-1 #\/ KnightRow #\= KingRow+1) #/\
    (KnightColumn #\= KingColumn-1 #\/ KnightRow #\= KingRow-1) #/\
    (KnightColumn #\= KingColumn+1 #\/ KnightRow #\= KingRow) #/\
    (KnightColumn #\= KingColumn-1 #\/ KnightRow #\= KingRow).


% invalid_position_knight(KnightColumn, KnightRow, KingColumn, KingRow) :-
%     KingColumn #\= KnightColumn+2 #\/ KingRow #\= KnightRow+1 #/\
%     KingColumn #\= KnightColumn+2 #\/ KingRow #\= KnightRow-1 #/\
%     KingColumn #\= KnightColumn-2 #\/ KingRow #\= KnightRow+1 #/\
%     KingColumn #\= KnightColumn-2 #\/ KingRow #\= KnightRow-1 #/\
%     KingRow #\= KnightRow+2 #\/ KingColumn #\= KnightColumn+1 #/\
%     KingRow #\= KnightRow+2 #\/ KingColumn #\= KnightColumn-1 #/\
%     KingRow #\= KnightRow-2 #\/ KingColumn #\= KnightColumn+1 #/\
%     KingRow #\= KnightRow-2 #\/ KingColumn #\= KnightColumn-1.





solveBoard(NumRows, NumColumns, NumPieces, TypePiece1, TypePiece2, Piece1, Piece2, Result) :-
    BoardSize is NumRows*NumColumns,
    length(Piece1, NumPieces),
    length(Piece2, NumPieces),

    domain(Piece1, 1, BoardSize),
    domain(Piece2, 1, BoardSize),

    all_different(Piece1),
    all_different(Piece2),

    %element(1, Piece1, 4),
    %element(2, Piece1, 9),
    kingNoAttackSelf(Piece1, NumColumns),

    kingAttack(Piece1, Piece2, NumColumns),

    append(Piece1, Piece2, Result),
    all_different(Result),
    labeling([], Result).




% solveBoard(2, 3, 2, 1, 1, P1, P2, Result).
% solveBoard(4, 4, 2, 1, 1, P1, P2, Result).
% solveBoard(2,3,2,1,1,[1,3],[4,6], [1,3,4,6]).


% Verify King can't attack another King
kingNoAttackSelf([A|Rest], NumColumns) :- forEachKing(A, Rest, NumColumns), kingNoAttackSelf(Rest, NumColumns).
kingNoAttackSelf([], _).

forEachKing(A, [B|Rest], NumColumns) :- verifyNoKingAttack(A, B, NumColumns), forEachKing(A, Rest, NumColumns).
forEachKing(_, [], _).

% Problem if the king is in one side, this doens't accept to another king to be in the opposite side in the next row
% verifyNoKingAttack(A, B, NumColumns) :- 
%     A-NumColumns-1 #\= B #/\
%     A-NumColumns #\= B #/\
%     A-NumColumns+1 #\= B #/\
%     A+NumColumns-1 #\= B #/\
%     A+NumColumns #\= B #/\
%     A+NumColumns+1 #\= B #/\
%     A+1 #\= B #/\
%     A-1 #\= B.

verifyNoKingAttack(A, B, NumColumns) :-
    convertColumnRow(A, KingColumn, KingRow),
    convertColumnRow(B, OtherColumn, OtherRow),
    invalid_position_king(KingColumn, KingRow, OtherColumn, OtherRow).

% Verify if King attack only one of the others
kingAttack(King, Other, NumColumns) :-
    kingAttackIterator(King, Other, NumColumns, []).

kingAttackIterator([A|King], [B|Other], NumColumns, Previous) :- 
    verifyKingAttack(A, B, NumColumns), 
    kingNoAttackOthers(A, Other, NumColumns), 
    kingNoAttackOthers(A, Previous, NumColumns), 
    append([B], Previous, NewPrevious),
    kingAttackIterator(King, Other, NumColumns, NewPrevious).
kingAttackIterator([], [], _, _).


% verifyKingAttack(A, B, NumColumns) :- 
%     A-NumColumns-1 #= B #\/
%     A-NumColumns #= B #\/
%     A-NumColumns+1 #= B #\/
%     A+NumColumns-1 #= B #\/
%     A+NumColumns #= B #\/
%     A+NumColumns+1 #= B #\/
%     A+1 #= B #\/
%     A-1 #= B.

kingNoAttackOthers(_, [], _).
kingNoAttackOthers(A, [B|Other], NumColumns) :-
    verifyNoKingAttack(A, B, NumColumns),
    kingNoAttackOthers(A, Other, NumColumns).


verifyKingAttack(A, B, NumColumns) :- 
    convertColumnRow(A, KingColumn, KingRow),
    convertColumnRow(B, OtherColumn, OtherRow),
    valid_position_king(KingColumn, KingRow, OtherColumn, OtherRow).

convertColumnRow(Pos, Column, Row) :-
    Pos #= 1 #/\ Column #= 1 #/\ Row #= 1 #\/
    Pos #= 2 #/\ Column #= 2 #/\ Row #= 1 #\/
    Pos #= 3 #/\ Column #= 3 #/\ Row #= 1 #\/
    Pos #= 4 #/\ Column #= 1 #/\ Row #= 2 #\/
    Pos #= 5 #/\ Column #= 2 #/\ Row #= 2 #\/
    Pos #= 6 #/\ Column #= 3 #/\ Row #= 2.

% convertColumnRow(Pos, Column, Row) :-
%     Pos #= 1 #/\ Column #= 1 #/\ Row #= 1 #\/
%     Pos #= 2 #/\ Column #= 2 #/\ Row #= 1 #\/
%     Pos #= 3 #/\ Column #= 3 #/\ Row #= 1 #\/
%     Pos #= 4 #/\ Column #= 4 #/\ Row #= 1 #\/

%     Pos #= 5 #/\ Column #= 1 #/\ Row #= 2 #\/
%     Pos #= 6 #/\ Column #= 2 #/\ Row #= 2 #\/
%     Pos #= 7 #/\ Column #= 3 #/\ Row #= 2 #\/
%     Pos #= 8 #/\ Column #= 4 #/\ Row #= 2 #\/

%     Pos #= 9 #/\ Column #= 1 #/\ Row #= 3 #\/
%     Pos #= 10 #/\ Column #= 2 #/\ Row #= 3 #\/
%     Pos #= 11 #/\ Column #= 3 #/\ Row #= 3 #\/
%     Pos #= 12 #/\ Column #= 4 #/\ Row #= 3 #\/

%     Pos #= 13 #/\ Column #= 1 #/\ Row #= 4 #\/
%     Pos #= 14 #/\ Column #= 2 #/\ Row #= 4 #\/
%     Pos #= 15 #/\ Column #= 3 #/\ Row #= 4 #\/
%     Pos #= 16 #/\ Column #= 4 #/\ Row #= 4.

% getMatrixPosition(Position, NumColumns, PosRow, PosColumn) :-
%     getColumn(Position, NumColumns, PosColumn),
%     getRow(Position, NumColumns, PosRow).

% getColumn(Position, NumColumns, PosColumn) :-
%     (Position mod NumColumns) =:= 0, !,
%     PosColumn is 5;
%     PosColumn is (Position mod NumColumns).

% getRow(Position, NumColumns, PosRow) :-
%     floor(Position/NumColumns) =:= ceiling(Position/NumColumns), !,
%     PosRow is round(Position/NumColumns);
%     PosRow is floor(Position/NumColumns)+1.

