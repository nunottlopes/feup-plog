:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(random)).

:- include('board.pl').
:- include('moves.pl').
:- include('solver.pl').
:- include('utils.pl').

re :-
    reconsult('chessloop').

chessloop :-
    nl,
    write('----------------------- CHESS LOOP PUZZLE-----------------------'), nl, nl,
    write('> To solve a board and see the solution visually use:'), nl,
    write('solveBoard(NumRows, NumColumns, NumPieces, TypePiece1, TypePiece2).'), nl, nl,
    write('     Example:'), nl,
    write('     - Place 2 knights and kings on a 2x3 chess board'), nl,
    write('     solveBoard(2, 3, 2, kings, knights).'), nl, nl,

    write('> To generate a random problem and a solution use:'), nl,
    write('chessloopRandom.'), nl, nl,

    write('> If you want to check all solutions manually use:'), nl,
    write('solveBoard(NumRows, NumColumns, NumPieces, TypePiece1, TypePiece2, Pieces1List, Pieces2List).'), nl, nl.

chessloopRandom :-
    random(2, 7, NumRows),
    random(2, 7, NumColumns),
    random(2, 5, NumPieces),
    random(1, 5, NumTypePiece1),
    random(1, 5, NumTypePiece2),
    nth1(NumTypePiece1, [kings, knights, queens, bishops, rooks], TypePiece1),
    nth1(NumTypePiece2, [kings, knights, queens, bishops, rooks], TypePiece2),

    nl,
    write('- Placing '), write(NumPieces), write(' '), write(TypePiece1), write(' and '), write(TypePiece2), 
    write(' on a '), write(NumRows), write('x'), write(NumColumns), write(' chess board.'), nl,
    nl,

    solveBoard(NumRows, NumColumns, NumPieces, TypePiece1, TypePiece2).