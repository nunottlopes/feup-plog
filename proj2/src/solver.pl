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

    % Check if the lists have same elements
    same_elements_list(Piece1A, Piece1B),
    same_elements_list(Piece2A, Piece2B),

    % Piece A attack constraints
    pieceNoAttackSelf(Piece1A, NumColumns, TypePiece1),
    pieceAttack(Piece1A, Piece2A, NumColumns, TypePiece1),

    % Piece B attack constraints
    pieceNoAttackSelf(Piece2B, NumColumns, TypePiece2),
    pieceAttack(Piece2B, Piece1B, NumColumns, TypePiece2),

    % Check if the positions form a loop
    checkForLoop(Piece1A, Piece2A, Piece1B, Piece2B, NumPieces),

    % Check if the positions of the type of Piece1 are different from the positions of the piece type Piece2 
    append(Piece1A, Piece2A, FirstResult),
    all_different(FirstResult),
    append(Piece1B, Piece2B, SecondResult),
    all_different(SecondResult),

    % Verifies if the solutions are different, if not there is no loop in the solutions
    Value #= NumPieces*2,
    different_lists(FirstResult, SecondResult, Value), 

    % Constraints to avoid repeated solutions
    % Remove this if you want to have all the possible combinations
    % -------------------------------------------------------------
    sorted(Piece1A),
    % Remove next so that you can change types order
    %sorted(Piece2B),
    different_lists(Piece1A, Piece1B, NumPieces),
    % -------------------------------------------------------------

    append(Piece1A, Piece1B, Piece1),
    append(Piece2A, Piece2B, Piece2),

    append(Piece1, Piece2, Result),

    labeling([], Result).



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
    noAttackPositions(Type, PieceColumn, PieceRow, OtherColumn, OtherRow).


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
    attackPositions(Type, PieceColumn, PieceRow, OtherColumn, OtherRow).




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
