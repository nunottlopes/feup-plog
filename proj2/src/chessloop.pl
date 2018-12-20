:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(random)).

:- include('board.pl').

re :-
    reconsult('chessloop').


% solveBoard(NumRows, NumColumns, NumPieces, TypePiece1, TypePiece2, Piece1A, Piece2A, Result) :-
%     BoardSize is NumRows*NumColumns,
%     length(Piece1A, NumPieces),
%     length(Piece2A, NumPieces),
%     length(Piece1B, NumPieces),
%     length(Piece2B, NumPieces),

%     domain(Piece1A, 1, BoardSize),
%     domain(Piece1B, 1, BoardSize),
%     domain(Piece2A, 1, BoardSize),
%     domain(Piece2B, 1, BoardSize),

%     all_different(Piece1A),
%     all_different(Piece1B),
%     all_different(Piece2A),
%     all_different(Piece2B),

%     same_elements_list(Piece1A, Piece1B),
%     different_lists(Piece1A, Piece1B),
%     %reverse_list(Piece1A, Piece1B),
%     %same_elements_list(Piece2A, Piece2B),

%     pieceNoAttackSelf(Piece1A, NumColumns, king),
%     pieceAttack(Piece1A, Piece2A, NumColumns, king),

%     pieceNoAttackSelf(Piece2A, NumColumns, knight),
%     pieceAttack(Piece2A, Piece1B, NumColumns, knight),

%     %append(Piece1A, Piece1B, Piece2A, Piece2B, Result),
%     append(Piece1A, Piece2A, Result),
%     all_different(Result),
%     labeling([], Result).


solveBoard(NumRows, NumColumns, NumPieces, TypePiece1, TypePiece2, Piece1, Piece2, Result) :-
    BoardSize is NumRows*NumColumns,
    length(Piece1A, NumPieces),
    length(Piece2A, NumPieces),
    length(Piece1B, NumPieces),
    length(Piece2B, NumPieces),

    domain(Piece1A, 1, BoardSize),
    domain(Piece1B, 1, BoardSize),
    domain(Piece2A, 1, BoardSize),
    domain(Piece2B, 1, BoardSize),

    all_different(Piece1A),
    all_different(Piece1B),
    all_different(Piece2A),
    all_different(Piece2B),

    same_elements_list(Piece1A, Piece1B),
    %different_lists(Piece1A, Piece1B),
    %reverse_list(Piece1A, Piece1B),
    same_elements_list(Piece2A, Piece2B),

    % Piece A
    pieceNoAttackSelf(Piece1A, NumColumns, king),
    pieceAttack(Piece1A, Piece2A, NumColumns, king),

    % Piece B
    pieceNoAttackSelf(Piece2B, NumColumns, knight),
    pieceAttack(Piece2B, Piece1B, NumColumns, knight),

    append(Piece1A, Piece2A, FirstResult),
    all_different(FirstResult),
    append(Piece1B, Piece2B, SecondResult),
    all_different(SecondResult),
    %different_lists(FirstResult, SecondResult), % verify if the solutions are different, if not we don't have a loop

    append(Piece1A, Piece1B, Piece1),
    append(Piece2A, Piece2B, Piece2),

    %append(Piece1A, Piece1B, Piece2A, Piece2B, Result),
    append(Piece1, Piece2, Result),

    labeling([], Result).


%checkForLoop(Piece1A, Piece2A, Piece1B, Piece2B) :-


% ------------------ SOME EXAMPLE SOLUTIONS ------------------
% solveBoard(2, 3, 2, 1, 1, P1, P2, Result).
% solveBoard(4, 4, 2, 1, 1, P1, P2, Result).
% solveBoard(2,3,2,1,1,[1,3],[4,6], [1,3,4,6]).
% solveBoard(2,3,2,1,1,[1,3],[4,6], Result).
% solveBoard(2,3,2,1,1,[1,3],[4,6], [1,3,3,1,4,6,6,4]).

% solveBoard(4, 5, 3, 1, 1, P1, P2, Result).
% solveBoard(4, 5, 3, 1, 1, [3,12,15], [4,6,19], Result).


% solveBoard(2,3,2,1,1, [1,3,4,6]).
% solveBoard(2,3,2,1,1, Result).



% ----------------- UTILS -----------------

same_elements_list([], _).
same_elements_list([A|Rest], ListB) :-
    element(_, ListB, A),
    same_elements_list(Rest, ListB).

% checks if two lists with same elements have a different order
different_lists(ListA, ListB) :-
    different_lists_iterator(ListA, ListA, ListB).

different_lists_iterator([],_,_).
different_lists_iterator([A|RestA], ListA, ListB) :-
    element(PosListA, ListA, A),
    element(PosListB, ListB, A),
    PosListA #\= PosListB,
    different_lists_iterator(RestA, ListA, ListB).
    


% -------------------------------------- EACH TYPE OF PIECE HANDLER --------------------------------------

% Verify Piece can't attack Piece of the same type
pieceNoAttackSelf([A|Rest], NumColumns, Type) :- 
    forEachPiece(A, Rest, NumColumns, Type), 
    pieceNoAttackSelf(Rest, NumColumns, Type).
pieceNoAttackSelf([], _, _).

forEachPiece(A, [B|Rest], NumColumns, Type) :- 
    verifyNoPieceAttack(A, B, NumColumns, Type), 
    forEachPiece(A, Rest, NumColumns, Type).
forEachPiece(_, [], _, _).

verifyNoPieceAttack(A, B, NumColumns, Type) :-
    getMatrixPosition(A, NumColumns, PieceRow, PieceColumn),
    getMatrixPosition(B, NumColumns, OtherRow, OtherColumn),
    invalid_position(Type, PieceColumn, PieceRow, OtherColumn, OtherRow).

% Verify if the Piece attack only one of the other type of Piece
pieceAttack(Piece, Other, NumColumns, Type) :-
    pieceAttackIterator(Piece, Other, NumColumns, [], Type).

pieceAttackIterator([A|Piece], [B|Other], NumColumns, Previous, Type) :- 
    verifyPieceAttack(A, B, NumColumns, Type), 
    pieceNoAttackOthers(A, Other, NumColumns, Type), 
    pieceNoAttackOthers(A, Previous, NumColumns, Type), 
    append([B], Previous, NewPrevious),
    pieceAttackIterator(Piece, Other, NumColumns, NewPrevious, Type).
pieceAttackIterator([], [], _, _, _).

pieceNoAttackOthers(_, [], _, _).
pieceNoAttackOthers(A, [B|Other], NumColumns, Type) :-
    verifyNoPieceAttack(A, B, NumColumns, Type),
    pieceNoAttackOthers(A, Other, NumColumns, Type).


verifyPieceAttack(A, B, NumColumns, Type) :- 
    getMatrixPosition(A, NumColumns, PieceRow, PieceColumn),
    getMatrixPosition(B, NumColumns, OtherRow, OtherColumn),
    valid_position(Type, PieceColumn, PieceRow, OtherColumn, OtherRow).




% ------------------- PIECES MOVES HANDLERS -------------------------

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












% ---------------------- GET BOARD POSITION ------------------------

getMatrixPosition(Position, NumColumns, PosRow, PosColumn) :-
    getColumn(Position, NumColumns, PosColumn),
    getRow(Position, NumColumns, PosRow).

getColumn(Position, NumColumns, PosColumn) :-
    ((Position mod NumColumns) #= 0 #/\ PosColumn #= NumColumns) #\/
    ((Position mod NumColumns) #\= 0 #/\ PosColumn #= (Position mod NumColumns)).

getRow(Position, NumColumns, PosRow) :-
    ((Position mod NumColumns) #= 0 #/\ PosRow #= Position/NumColumns) #\
    ((Position mod NumColumns) #\= 0 #/\ PosRow #= (Position/NumColumns +1)).




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

