:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(random)).

:- include('board.pl').

re :-
    reconsult('chessloop').

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





solveBoard(NumRows, NumColumns, NumPieces, TypePiece1, TypePiece2, Piece1A, Piece2A, Result) :-
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

    %element(1, Piece1, 4),
    %element(2, Piece1, 9),

    % pieceNoAttackSelf(Piece1, NumColumns, king),
    % pieceAttack(Piece1, Piece2, NumColumns, king),

    % pieceNoAttackSelf(Piece2, NumColumns, knight),
    % pieceAttack(Piece2, Piece1, NumColumns, knight),

    same_elements_list(Piece1A, Piece1B),
    different_lists(Piece1A, Piece1B),
    %reverse_list(Piece1A, Piece1B),
    %same_elements_list(Piece2A, Piece2B),

    kingNoAttackSelf(Piece1A, NumColumns),
    kingAttack(Piece1A, Piece2A, NumColumns),

    knightNoAttackSelf(Piece2A, NumColumns),
    knightAttack(Piece2A, Piece1B, NumColumns),

    %append(Piece1A, Piece1B, Piece2A, Piece2B, Result),
    append(Piece1A, Piece2A, Result),
    all_different(Result),
    labeling([], Result).

% solveBoard(2, 3, 2, 1, 1, P1, P2, Result).
% solveBoard(4, 4, 2, 1, 1, P1, P2, Result).
% solveBoard(2,3,2,1,1,[1,3],[4,6], [1,3,4,6]).
% solveBoard(2,3,2,1,1,[1,3],[4,6], Result).
% solveBoard(2,3,2,1,1,[1,3],[4,6], [1,3,3,1,4,6,6,4]).

% solveBoard(4, 5, 3, 1, 1, P1, P2, Result).
% solveBoard(4, 5, 3, 1, 1, [3,12,15], [4,6,19], Result).


% solveBoard(2,3,2,1,1, [1,3,4,6]).
% solveBoard(2,3,2,1,1, Result).

same_elements_list([], _).
same_elements_list([A|Rest], ListB) :-
    element(_, ListB, A),
    same_elements_list(Rest, ListB).

different_lists([],[]).
different_lists([A|RestA], [B|RestB]) :-
    A #\= B,
    different_lists(RestA, RestB).
    





% -------------------------------------- KNIGHT --------------------------------------

% Verify Knight can't attack another Knight
knightNoAttackSelf([A|Rest], NumColumns) :- 
  forEachKnight(A, Rest, NumColumns), 
  knightNoAttackSelf(Rest, NumColumns).
knightNoAttackSelf([], _).

forEachKnight(A, [B|Rest], NumColumns) :- 
  verifyNoKnightAttack(A, B, NumColumns), 
  forEachKnight(A, Rest, NumColumns).
forEachKnight(_, [], _).

verifyNoKnightAttack(A, B, NumColumns) :-
    convertColumnRow(A, KnightColumn, KnightRow),
    %getMatrixPosition(A, NumColumns, KnightRow, KnightColumn),
    convertColumnRow(B, OtherColumn, OtherRow),
    %getMatrixPosition(B, NumColumns, OtherRow, OtherColumn),
    invalid_position_knight(KnightColumn, KnightRow, OtherColumn, OtherRow).

% Verify if Knight attack only one of the others

knightAttack(Knight, Other, NumColumns) :-
    knightAttackIterator(Knight, Other, NumColumns, []).

knightAttackIterator([A|Knight], [B|Other], NumColumns, Previous) :- 
    verifyKnightAttack(A, B, NumColumns), 
    knightNoAttackOthers(A, Other, NumColumns), 
    knightNoAttackOthers(A, Previous, NumColumns), 
    append([B], Previous, NewPrevious),
    knightAttackIterator(Knight, Other, NumColumns, NewPrevious).
knightAttackIterator([], [], _, _).

knightNoAttackOthers(_, [], _).
knightNoAttackOthers(A, [B|Other], NumColumns) :-
    verifyNoKnightAttack(A, B, NumColumns),
    knightNoAttackOthers(A, Other, NumColumns).


verifyKnightAttack(A, B, NumColumns) :- 
    convertColumnRow(A, KnightColumn, KnightRow),
    %getMatrixPosition(A, NumColumns, KnightRow, KnightColumn),
    convertColumnRow(B, OtherColumn, OtherRow),
    %getMatrixPosition(B, NumColumns, OtherRow, OtherColumn),
    valid_position_knight(KnightColumn, KnightRow, OtherColumn, OtherRow).




% -------------------------------------- KING --------------------------------------

% Verify King can't attack another King
kingNoAttackSelf([A|Rest], NumColumns) :- forEachKing(A, Rest, NumColumns), kingNoAttackSelf(Rest, NumColumns).
kingNoAttackSelf([], _).

forEachKing(A, [B|Rest], NumColumns) :- verifyNoKingAttack(A, B, NumColumns), forEachKing(A, Rest, NumColumns).
forEachKing(_, [], _).

verifyNoKingAttack(A, B, NumColumns) :-
    convertColumnRow(A, KingColumn, KingRow),
    %getMatrixPosition(A, NumColumns, KingRow, KingColumn),
    convertColumnRow(B, OtherColumn, OtherRow),
    %getMatrixPosition(B, NumColumns, OtherRow, OtherColumn),
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

kingNoAttackOthers(_, [], _).
kingNoAttackOthers(A, [B|Other], NumColumns) :-
    verifyNoKingAttack(A, B, NumColumns),
    kingNoAttackOthers(A, Other, NumColumns).


verifyKingAttack(A, B, NumColumns) :- 
    convertColumnRow(A, KingColumn, KingRow),
    %getMatrixPosition(A, NumColumns, KingRow, KingColumn),
    convertColumnRow(B, OtherColumn, OtherRow),
    %getMatrixPosition(B, NumColumns, OtherRow, OtherColumn),
    valid_position_king(KingColumn, KingRow, OtherColumn, OtherRow).



% % -------------------------------------- EACH TYPE OF PIECE HANDLER --------------------------------------

% % Verify Piece can't attack Piece of the same type
% pieceNoAttackSelf([A|Rest], NumColumns, Type) :- 
%     forEachPiece(A, Rest, NumColumns, Type), 
%     pieceNoAttackSelf(Rest, NumColumns, Type).
% pieceNoAttackSelf([], _, _).

% forEachPiece(A, [B|Rest], NumColumns, Type) :- 
%     verifyNoPieceAttack(A, B, NumColumns, Type), 
%     forEachPiece(A, Rest, NumColumns, Type).
% forEachPiece(_, [], _, _).

% verifyNoPieceAttack(A, B, NumColumns, Type) :-
%     convertColumnRow(A, PieceColumn, PieceRow),
%     %getMatrixPosition(A, NumColumns, PieceRow, PieceColumn),
%     convertColumnRow(B, OtherColumn, OtherRow),
%     %getMatrixPosition(B, NumColumns, OtherRow, OtherColumn),
%     invalid_position(Type, PieceColumn, PieceRow, OtherColumn, OtherRow).

% % Verify if the Piece attack only one of the other type of Piece
% pieceAttack(Piece, Other, NumColumns, Type) :-
%     pieceAttackIterator(Piece, Other, NumColumns, [], Type).

% pieceAttackIterator([A|Piece], [B|Other], NumColumns, Previous, Type) :- 
%     verifyPieceAttack(A, B, NumColumns, Type), 
%     pieceNoAttackOthers(A, Other, NumColumns, Type), 
%     pieceNoAttackOthers(A, Previous, NumColumns, Type), 
%     append([B], Previous, NewPrevious),
%     pieceAttackIterator(Piece, Other, NumColumns, NewPrevious, Type).
% pieceAttackIterator([], [], _, _, _).

% pieceNoAttackOthers(_, [], _, _).
% pieceNoAttackOthers(A, [B|Other], NumColumns, Type) :-
%     verifyNoPieceAttack(A, B, NumColumns, Type),
%     pieceNoAttackOthers(A, Other, NumColumns, Type).


% verifyPieceAttack(A, B, NumColumns, Type) :- 
%     convertColumnRow(A, PieceColumn, PieceRow),
%     %getMatrixPosition(A, NumColumns, PieceRow, PieceColumn),
%     convertColumnRow(B, OtherColumn, OtherRow),
%     %getMatrixPosition(B, NumColumns, OtherRow, OtherColumn),
%     valid_position(Type, PieceColumn, PieceRow, OtherColumn, OtherRow).



% valid_position(king, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
%     valid_position_king(PieceColumn, PieceRow, OtherColumn, OtherRow).

% valid_position(knight, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
%     valid_position_knight(PieceColumn, PieceRow, OtherColumn, OtherRow).

% invalid_position(king, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
%     invalid_position_king(PieceColumn, PieceRow, OtherColumn, OtherRow).

% invalid_position(knight, PieceColumn, PieceRow, OtherColumn, OtherRow) :-
%     invalid_position_knight(PieceColumn, PieceRow, OtherColumn, OtherRow).






















% 2X3 BOARD
convertColumnRow(Pos, Column, Row) :-
    Pos #= 1 #/\ Column #= 1 #/\ Row #= 1 #\/
    Pos #= 2 #/\ Column #= 2 #/\ Row #= 1 #\/
    Pos #= 3 #/\ Column #= 3 #/\ Row #= 1 #\/
    Pos #= 4 #/\ Column #= 1 #/\ Row #= 2 #\/
    Pos #= 5 #/\ Column #= 2 #/\ Row #= 2 #\/
    Pos #= 6 #/\ Column #= 3 #/\ Row #= 2.


% 4X5 BOARD
% convertColumnRow(Pos, Column, Row) :-
%     Pos #= 1 #/\ Column #= 1 #/\ Row #= 1 #\/
%     Pos #= 2 #/\ Column #= 2 #/\ Row #= 1 #\/
%     Pos #= 3 #/\ Column #= 3 #/\ Row #= 1 #\/
%     Pos #= 4 #/\ Column #= 4 #/\ Row #= 1 #\/
%     Pos #= 5 #/\ Column #= 5 #/\ Row #= 1 #\/

%     Pos #= 6 #/\ Column #= 1 #/\ Row #= 2 #\/
%     Pos #= 7 #/\ Column #= 2 #/\ Row #= 2 #\/
%     Pos #= 8 #/\ Column #= 3 #/\ Row #= 2 #\/
%     Pos #= 9 #/\ Column #= 4 #/\ Row #= 2 #\/
%     Pos #= 10 #/\ Column #= 5 #/\ Row #= 2 #\/

%     Pos #= 11 #/\ Column #= 1 #/\ Row #= 3 #\/
%     Pos #= 12 #/\ Column #= 2 #/\ Row #= 3 #\/
%     Pos #= 13 #/\ Column #= 3 #/\ Row #= 3 #\/
%     Pos #= 14 #/\ Column #= 4 #/\ Row #= 3 #\/
%     Pos #= 15 #/\ Column #= 5 #/\ Row #= 3 #\/

%     Pos #= 16 #/\ Column #= 1 #/\ Row #= 4 #\/
%     Pos #= 17 #/\ Column #= 2 #/\ Row #= 4 #\/
%     Pos #= 18 #/\ Column #= 3 #/\ Row #= 4 #\/
%     Pos #= 19 #/\ Column #= 4 #/\ Row #= 4 #\/
%     Pos #= 20 #/\ Column #= 5 #/\ Row #= 4.


% 4X4 BOARD
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

