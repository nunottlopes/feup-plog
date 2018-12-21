% -------------------------------------- GET BOARD POSITION WITH CONSTRAINT LOGIC PROGRAMMING --------------------------------------

getMatrixPositionPLR(Position, NumColumns, PosRow, PosColumn) :-
    getColumnPLR(Position, NumColumns, PosColumn),
    getRowPLR(Position, NumColumns, PosRow).

getColumnPLR(Position, NumColumns, PosColumn) :-
    ((Position mod NumColumns) #= 0 #/\ PosColumn #= NumColumns) #\/
    ((Position mod NumColumns) #\= 0 #/\ PosColumn #= (Position mod NumColumns)).

getRowPLR(Position, NumColumns, PosRow) :-
    ((Position mod NumColumns) #= 0 #/\ PosRow #= Position/NumColumns) #\
    ((Position mod NumColumns) #\= 0 #/\ PosRow #= (Position/NumColumns +1)).


% -------------------------------------- GET BOARD POSITION --------------------------------------

getMatrixPosition(Position, NumColumns, PosRow, PosColumn) :-
    getColumn(Position, NumColumns, PosColumn),
    getRow(Position, NumColumns, PosRow).

getColumn(Position, NumColumns, PosColumn) :-
    (Position mod NumColumns) =:= 0, !,
    PosColumn is NumColumns;
    PosColumn is (Position mod NumColumns).

getRow(Position, NumColumns, PosRow) :-
    floor(Position/NumColumns) =:= ceiling(Position/NumColumns), !,
    PosRow is round(Position/NumColumns);
    PosRow is floor(Position/NumColumns)+1.


% -------------------------------------- BOARD DISPLAY --------------------------------------

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