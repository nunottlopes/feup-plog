:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(random)).

:- include('board.pl').

re :-
    reconsult('src/chessloop').

puzzle(L) :-
    L=[A, B, C, D, E, F],
    domain(L, 0, 2), Empty = 0, Knight = 1, King = 2,
    
    count(Knight, L, #=, 2),
    count(King, L, #=, 2),

    getPosition(L, Knight, [], [PosKnight1, PosKnight2], 0),
    getPosition(L, King, [], [PosKing1, PosKing2], 0),

    convertColumnRow(PosKnight1, KnightColumn1, KnightRow1),
    convertColumnRow(PosKnight2, KnightColumn2, KnightRow2),
    convertColumnRow(PosKing1, KingColumn1, KingRow1),
    convertColumnRow(PosKing2, KingColumn2, KingRow2),

    % valid_position_knight(KnightColumn1, KnightRow1, KingColumn1, KingRow1), valid_position_king(KingColumn2, KingRow2, KnightColumn2, KnightRow2),
    % valid_position_knight(KnightColumn1, KnightRow1, KingColumn2, KingRow2), valid_position_king(KingColumn1, KingRow1, KnightColumn2, KnightRow2),
    % valid_position_knight(KnightColumn2, KnightRow2, KingColumn1, KingRow1), valid_position_king(KingColumn2, KingRow2, KnightColumn1, KnightRow1),
    valid_position_knight(KnightColumn2, KnightRow2, KingColumn2, KingRow2), valid_position_king(KingColumn1, KingRow1, KnightColumn1, KnightRow1),

    invalid_position_knight(KnightColumn1, KnightRow1, KnightColumn2, KnightRow2),
    invalid_position_knight(KnightColumn2, KnightRow2, KnightColumn1, KnightRow1),
    invalid_position_king(KingColumn1, KingRow1, KingColumn2, KingRow2),
    invalid_position_king(KingColumn2, KingRow2, KingColumn1, KingRow1),

    labeling([], L).

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

% invalid_position_king(KingColumn, KingRow, KnightColumn, KnightRow) :-
%     KnightColumn #\= KingColumn #\/ KnightRow #\= KingRow+1 #/\
%     KnightColumn #\= KingColumn #\/ KnightRow #\= KingRow-1 #/\
%     KnightColumn #\= KingColumn+1 #\/ KnightRow #\= KingRow+1 #/\
%     KnightColumn #\= KingColumn+1 #\/ KnightRow #\= KingRow-1 #/\
%     KnightColumn #\= KingColumn-1 #\/ KnightRow #\= KingRow+1 #/\
%     KnightColumn #\= KingColumn-1 #\/ KnightRow #\= KingRow-1 #/\
%     KnightColumn #\= KingColumn+1 #\/ KnightRow #\= KingRow #/\
%     KnightColumn #\= KingColumn-1 #\/ KnightRow #\= KingRow.

% valid_position_knight(1, 1, 2, 3).
getPosition([], _, Result, Result, _).
getPosition([H|T], Type, List, Result, Counter) :-
    H #= Type,
    append(List, [Counter], NewList),
    Counter1 is Counter+1,
    getPosition(T, Type, NewList, Result, Counter1);
    Counter1 is Counter+1,
    getPosition(T, Type, List, Result, Counter1).

convertColumnRow(0, 1, 1).
convertColumnRow(1, 2, 1).
convertColumnRow(2, 3, 1).
convertColumnRow(3, 1, 2).
convertColumnRow(4, 2, 2).
convertColumnRow(5, 3, 2).


puzzle2(Knight, King, Final) :-
    length(Knight, 2),
    length(King, 2),

    domain(Knight, 1, 6),
    domain(King, 1, 6),

    all_different(Knight),
    all_different(King),

    element(1, Knight, PosKnight1),
    element(2, Knight, PosKnight2),
    element(1, King, PosKing1),
    element(2, King, PosKing2),



    append(Knight, King, Final),
    all_different(Final),

    labeling([], Final).
    
    
noAttackKnight(KnightColumn1, KnightRow1, KnightColumn2, KnightRow2) :-
    % Falta terminar
    KnightColumn1 #\= KnightColumn2+2.


% invalid_position_knight(KnightColumn, KnightRow, KingColumn, KingRow) :-
%     KingColumn #\= KnightColumn+2 #\/ KingRow #\= KnightRow+1 #/\
%     KingColumn #\= KnightColumn+2 #\/ KingRow #\= KnightRow-1 #/\
%     KingColumn #\= KnightColumn-2 #\/ KingRow #\= KnightRow+1 #/\
%     KingColumn #\= KnightColumn-2 #\/ KingRow #\= KnightRow-1 #/\
%     KingRow #\= KnightRow+2 #\/ KingColumn #\= KnightColumn+1 #/\
%     KingRow #\= KnightRow+2 #\/ KingColumn #\= KnightColumn-1 #/\
%     KingRow #\= KnightRow-2 #\/ KingColumn #\= KnightColumn+1 #/\
%     KingRow #\= KnightRow-2 #\/ KingColumn #\= KnightColumn-1.