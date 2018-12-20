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

invalid_position_knight(KnightColumn, KnightRow, KingColumn, KingRow).
% TODO: here





solveBoard(NumRows, NumColumns, NumPieces, TypePiece1, TypePiece2, NewPiece1, Piece2, Result) :-
    BoardSize is NumRows*NumColumns,
    length(Piece1, NumPieces),
    length(Piece2, NumPieces),

    domain(Piece1, 1, BoardSize),
    domain(Piece2, 1, BoardSize),

    all_different(Piece1),
    all_different(Piece2),

    %element(1, Piece1, 4),
    %element(2, Piece1, 9),

    % pieceNoAttackSelf(Piece1, NumColumns, king),
    % pieceAttack(Piece1, Piece2, NumColumns, king),

    % pieceNoAttackSelf(Piece2, NumColumns, knight),
    % pieceAttack(Piece2, Piece1, NumColumns, knight),

    kingNoAttackSelf(Piece1, NumColumns),
    kingAttack([Piece1], Piece2, NumColumns),

    knightNoAttackSelf(Piece2, NumColumns),
    knightAttack(Piece2, Piece1, NumColumns),

    append(Piece1, Piece2, Result),
    all_different(Result),
    labeling([], Result).

% solveBoard(2, 3, 2, 1, 1, P1, P2, Result).
% solveBoard(4, 4, 2, 1, 1, P1, P2, Result).
% solveBoard(2,3,2,1,1,[1,3],[4,6], [1,3,4,6]).



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
%     (Position mod NumColumns) #= 0 #/\ PosColumn #= NumColumns #\/
%     PosColumn #= (Position mod NumColumns).

% getRow(Position, NumColumns, PosRow) :-
%     A #= floor(Position/NumColumns),
%     B #= ceiling(Position/NumColumns),
%     C #= round(Position/NumColumns),
%     A #= B #/\ PosRow #= C #\/
%     PosRow #= A+1.

% getRow(Position, NumColumns, PosRow) :-
%     floor(Position/NumColumns) =:= ceiling(Position/NumColumns), !,
%     PosRow is round(Position/NumColumns);
%     PosRow is floor(Position/NumColumns)+1.




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

