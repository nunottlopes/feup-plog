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
    nl,write('To solve a board use: '), nl,
    write('solveBoard(NumRows, NumColumns, NumPieces, TypePiece1, TypePiece2).'), nl, nl,
    write('Example:'), nl,
    write('- Place 2 knights and kings on a 2/3 chess board'), nl,
    write('solveBoard(2, 3, 2, king, knight).'), nl, nl.

