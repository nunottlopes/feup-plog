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
    solveBoard(2, 3, 2, king, knight, P1, P2, Result),
    write(P1), nl,
    write(P2), nl,
    write(Result), nl,
    write('Board Representation: '),nl,
    getDisplayMatrix(2, 3, P1, king, P2, knight, Matrix),
    % write(H), nl.
    print_matrix(Matrix), nl.



% ------------------ SOME EXAMPLE SOLUTIONS ------------------

% 1.
% solveBoard(2, 3, 2, king, knight, P1, P2, Result).
% solveBoard(2, 3, 2, king, knight,[1,3],[4,6], Result).
% solveBoard(2, 3, 2, knight, king, P1, P2, Result). ----- Wrong

% 2.
% solveBoard(4, 5, 3, king, knight, P1, P2, Result).
% solveBoard(4, 5, 3, king, knight, [3,12,15], [4,6,19], Result).
% solveBoard(4, 5, 3, knight, king, P1, P2, Result). ------ Wrong

% 3.
% solveBoard(2, 4, 2, rook, king, P1, P2, Result).
% solveBoard(2, 4, 2, rook, king, [3,6], [1,8], Result).
% solveBoard(2, 4, 2, king, rook, P1, P2, Result). ------- Wrong

% 4.
% solveBoard(4, 5, 3, rook, king, P1, P2, Result).  ------- Wrong
% solveBoard(4, 5, 3, king, rook, P1, P2, Result).
% solveBoard(4, 5, 3, king, rook, [4,6,15], [8,12,19], Result).
	
% 5.
% solveBoard(3, 3, 2, bishop, knight, P1, P2, Result). ----- Wrong Results or missing results
% solveBoard(3, 3, 2, knight, bishop, P1, P2, Result).
% solveBoard(3, 3, 2, knight, bishop, [1,2], [6,9], Result).

% 6.
% solveBoard(4, 4, 4, bishop, knight, P1, P2, Result).
% solveBoard(4, 4, 4, bishop, knight, [2,8,9,15], [6,7,10,11], Result). ------ Wrong, but we can obtain a similar response (different order)

% 7. 
% solveBoard(3, 5, 3, bishop, knight, P1, P2, Result). --------- Wrong
% solveBoard(3, 5, 3, knight, bishop, P1, P2, Result). --------- Wrong
% solveBoard(3, 5, 3, bishop, knight, [4,6,13,15], [2,3,7,8], Result). ---- Wrong

% 8.
% solveBoard(4, 6, 4, bishop, king, P1, P2, Result). ------------- Prolly infinite loop
% solveBoard(4, 6, 4, bishop, king, [4,12,13,21], [3,7,18,22], Result).

% 9.
% solveBoard(5, 5, 4, bishop, king, P1, P2, Result). ------------- Prolly infinite loop
% solveBoard(5, 5, 4, bishop, king, [6,8,17,25], [1,9,18,20], Result).

% 10.
% solveBoard(3, 4, 3, knight, rook, P1, P2, Result). ------------- Wrong
% solveBoard(3, 4, 3, rook, knight, P1, P2, Result). ------------- Wrong
% solveBoard(3, 4, 3, knight, rook, [3,4,7], [1,6,12], Result).

% 11.
% solveBoard(3, 8, 5, knight, rook, P1, P2, Result). ----------- Taking too long, not sure if wrong
% solveBoard(3, 8, 5, knight, rook, [3,4,11,12,24], [1,7,10,13,22], Result).

% 12.
% solveBoard(2, 4, 2, knight, queen, P1, P2, Result).
% solveBoard(2, 4, 2, knight, queen, [2,7], [1,8], Result).

% 13.
% solveBoard(3, 6, 3, knight, queen, P1, P2, Result). -------------- Lot of solutions
% solveBoard(3, 6, 3, knight, queen, [3,9,10], [6,7,17], Result). ------ Wrong

% 14.
% solveBoard(4, 5, 3, knight, queen, P1, P2, Result). -------------- Lot of solutions
% solveBoard(4, 5, 3, knight, queen, [2,12,14], [5,11,19], Result). ----- wrong

% 15.
% solveBoard(4, 7, 4, knight, queen, P1, P2, Result). -------------- Lot of solutions
% solveBoard(4, 7, 4, knight, queen, [1,8,21,28], [6,10,19,23], Result). ---- wrong

