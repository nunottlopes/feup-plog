% -------------------------------------- BOARD SOLVER PREDICATE --------------------------------------
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

    same_elements_list(Piece1A, Piece1B),
    same_elements_list(Piece2A, Piece2B),

    % Piece A Attacks
    pieceNoAttackSelf(Piece1A, NumColumns, king),
    pieceAttack(Piece1A, Piece2A, NumColumns, king),

    % Piece B Attacks
    pieceNoAttackSelf(Piece2B, NumColumns, knight),
    pieceAttack(Piece2B, Piece1B, NumColumns, knight),

    % Check if the positions form a loop
    checkForLoop(Piece1A, Piece2A, Piece1B, Piece2B, NumPieces),

    % Check if the positions of the type of Piece1 are different from the positions of the piece type Piece2 
    append(Piece1A, Piece2A, FirstResult),
    all_different(FirstResult),
    append(Piece1B, Piece2B, SecondResult),
    all_different(SecondResult),

    Value #= NumPieces*2,
    different_lists(FirstResult, SecondResult, Value), % verify if the solutions are different, if not we don't have a loop

    % Constraints to avoid repeated solutions
    sorted(Piece1A),
    different_lists(Piece1A, Piece1B, NumPieces),

    append(Piece1A, Piece1B, Piece1),
    append(Piece2A, Piece2B, Piece2),

    append(Piece1, Piece2, Result),
    %append(Piece1A, Piece2A, Result),

    labeling([], Result).




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
    getMatrixPositionPLR(A, NumColumns, PieceRow, PieceColumn),
    getMatrixPositionPLR(B, NumColumns, OtherRow, OtherColumn),
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
    getMatrixPositionPLR(A, NumColumns, PieceRow, PieceColumn),
    getMatrixPositionPLR(B, NumColumns, OtherRow, OtherColumn),
    valid_position(Type, PieceColumn, PieceRow, OtherColumn, OtherRow).




% -------------------------------------- ATTACK LOOP VERIFICATION --------------------------------------

checkForLoop(Piece1A, Piece2A, Piece1B, Piece2B, NumLoops) :-
    element(1, Piece1A, FirstPiece),
    loop(Piece1A, Piece2A, Piece1B, Piece2B, FirstPiece, FirstPiece, NumLoops).


loop(Piece1A, Piece2A, Piece1B, Piece2B, NextPiece, FirstPiece, 1) :-
    element(Pos1A, Piece1A, NextPiece),
    element(Pos1A, Piece2A, NextPiece2),
    element(Pos2B, Piece2B, NextPiece2),
    element(Pos2B, Piece1B, NextPiece3),

    NextPiece3 #= FirstPiece.

loop(Piece1A, Piece2A, Piece1B, Piece2B, NextPiece, FirstPiece, Counter) :-
    Counter #> 1,
    element(Pos1A, Piece1A, NextPiece),
    element(Pos1A, Piece2A, NextPiece2),
    element(Pos2B, Piece2B, NextPiece2),
    element(Pos2B, Piece1B, NextPiece3),

    NextPiece3 #\= FirstPiece,

    Counter1 is Counter-1,
    loop(Piece1A, Piece2A, Piece1B, Piece2B, NextPiece3, FirstPiece, Counter1).
