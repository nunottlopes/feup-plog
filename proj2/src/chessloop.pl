:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(random)).

:- include('board.pl').
:- include('moves.pl').
:- include('solver.pl').
:- include('utils.pl').

re :-
    reconsult('chessloop').


replace([_|T], 1, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > 0, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

createMatrix(NRows, NCols).

length_list(N, List) :- length(List, N).

generate_matrix(Cols, Rows, Matrix) :-
    length_list(Rows, Matrix),
    maplist(length_list(Cols), Matrix).

replaceMatrix(DisplayMatrix, NRow, NCol, Val, NewMatrix) :-
    nth1(NRow, DisplayMatrix, Elem),
    replace(Elem, NCol, Val, NewElem),
    replace(DisplayMatrix, NRow, NewElem, NewMatrix).   

replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

getDisplayMatrix(NRows, NCols, [P1|P2], P1Type, [P3|P4], P2Type, DisplayMatrix) :-
    getMatrixPosition(P1, NCols, PR1, PC1),
    getMatrixPosition(P2, NCols, PR2, PC2),
    getMatrixPosition(P3, NCols, PR3, PC3),
    getMatrixPosition(P4, NCols, PR4, PC4),
    generate_matrix(NCols, NRows, DisplayMatrixTemp),
    replaceMatrix(DisplayMatrixTemp, PR1, PC1, P1Type, MatrixTemp),
    replaceMatrix(MatrixTemp, PR2, PC2, P1Type, MatrixTemp1),
    replaceMatrix(MatrixTemp1, PR3, PC3, P2Type, MatrixTemp2),
    replaceMatrix(MatrixTemp2, PR4, PC4, P2Type, DisplayMatrix).


symbol(V, ' ') :- var(V).
symbol(king, 'k').
symbol(knight, 'c').
symbol( _ , ' ').

printElem([]).

printElem([H|T]):-
    symbol(H, S), write('|  '), write(S), write('  |'),
    printElem(T).

print_matrix([]).
print_matrix([H|T]) :- printElem(H), nl, print_matrix(T).

chessloop :-
    solveBoard(2, 3, 2, 1, 1, P1, P2, Result),
    write(P1), nl,
    write(P2), nl,
    write(Result), nl,
    write('Board Representation: '),nl,
    getDisplayMatrix(2, 3, P1, king, P2, knight, Matrix),
    % write(H), nl.
    print_matrix(Matrix), nl.




% ------------------ SOME EXAMPLE SOLUTIONS ------------------
% solveBoard(2, 3, 2, 1, 1, P1, P2, Result).
% solveBoard(4, 4, 2, 1, 1, P1, P2, Result).
% solveBoard(2,3,2,1,1,[1,3],[4,6], [1,3,4,6]).
% solveBoard(2,3,2,1,1,[1,3],[4,6], Result).
% solveBoard(2,3,2,1,1,[1,3],[4,6], [1,3,3,1,4,6,6,4]).

% solveBoard(4, 5, 3, 1, 1, P1, P2, Result).
% solveBoard(4, 5, 3, 1, 1, [3,12,15], [4,6,19], Result).
% solveBoard(6, 6, 3, 1, 1, P1, P2, Result).


% solveBoard(2,3,2,1,1, [1,3,4,6]).
% solveBoard(2,3,2,1,1, Result).




















% Temos de adicionar circuit por causa do loop que tem de fazer

% O problema que temos agora é que ele usa uma ordem [1,3][4,6] - ([4,6][1,3] em vez de [6,4][1,3])
% Precisamos de um predicado que faça para qualquer ordem de listas

% Vêr problema do floor e ceiling...

% Como evitar estas soluções?
% P1 = [1,3],
% P2 = [4,6],

% P1 = [3,1],
% P2 = [6,4],


% sorting(+Xs,+Ps,+Ys)
% – captura a relação entre uma lista de valores, uma lista de valores ordenada de forma
% ascendente e as suas posições na lista original
% – Xs, Ps e Ys são listas de igual comprimento n de variáveis de domínio ou inteiros
% – a restrição verifica-se se:
% • Ys está em ordenação ascendente
% • Ps é uma permutação de [1,n]
% • para cada i em [1,n], Xs[i] = Ys[Ps[i]]
% • Exemplos:
% | ?- length(Ys,5), length(Ps,5), sorting([2,7,9,1,3],Ps,Ys).
% Ps = [2,4,5,1,3], Ys = [1,2,3,7,9]
% | ?- length(Ys,5), length(Ps,5), sorting([2,7,3,1,3],Ps,Ys).
% Ps = [2,5,_A,1,_B], Ys = [1,2,3,3,7],
% _A in 3..4, _B in 3..4

