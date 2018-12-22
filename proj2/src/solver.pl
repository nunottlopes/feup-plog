% -------------------------------------- BOARD SOLVER PREDICATE --------------------------------------

solveBoard(NumRows, NumColumns, NumPieces, TypePiece1, TypePiece2) :-
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

    append(Piece1A, Piece1B, Piece1),
    append(Piece2A, Piece2B, Piece2),

    append(Piece1, Piece2, Result),

    statistics(walltime, _),
    labeling([], Result),
    statistics(walltime, [_, ElapsedTime | _]),
	format('A solution has been found!~nElapsed time: ~3d seconds', ElapsedTime), nl,
    fd_statistics, nl,

    !, displayBoard(NumColumns, NumRows, Piece1A, TypePiece1, Piece2A, TypePiece2).



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

verifyNoPieceAttack(A, B, NumColumns, Type, C) :-
    getMatrixPositionPLR(A, NumColumns, PieceRow, PieceColumn),
    getMatrixPositionPLR(B, NumColumns, OtherRow, OtherColumn),
    getMatrixPositionPLR(C, NumColumns, MiddlePieceRow, MiddlePieceColumn),
    noAttackPositions(Type, PieceColumn, PieceRow, OtherColumn, OtherRow, MiddlePieceColumn, MiddlePieceRow).


% Verify if the Piece attack only one of the other type of Piece
pieceAttack(Piece, Other, NumColumns, Type) :-
    pieceAttackIterator(Piece, Other, NumColumns, [], Type).

pieceAttackIterator([A|Piece], [B|Other], NumColumns, Previous, Type) :- 
    verifyPieceAttack(A, B, NumColumns, Type), 
    pieceNoAttackOthers(A, Other, NumColumns, Type, B), 
    pieceNoAttackOthers(A, Previous, NumColumns, Type, B), 
    append([B], Previous, NewPrevious),
    pieceAttackIterator(Piece, Other, NumColumns, NewPrevious, Type).
pieceAttackIterator([], [], _, _, _).

pieceNoAttackOthers(_, [], _, _, _).
pieceNoAttackOthers(A, [C|Other], NumColumns, Type, B) :-
    verifyNoPieceAttack(A, C, NumColumns, Type, B),
    pieceNoAttackOthers(A, Other, NumColumns, Type, B).


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




% -------------------------------------- BOARD SOLVER PREDICATE TO SEE/VERIFY ALL SOLUTIONS --------------------------------------
solveBoard(NumRows, NumColumns, NumPieces, TypePiece1, TypePiece2, FinalPiece1, FinalPiece2) :-
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

    % Constraints to avoid some repeated solutions
    % -------------------------------------------------------------
    sorted(Piece1A),
    different_lists(Piece1A, Piece1B, NumPieces),
    % -------------------------------------------------------------

    append(Piece1A, Piece1B, Piece1),
    append(Piece2A, Piece2B, Piece2),

    append(Piece1, Piece2, Result),

    statistics(walltime, _),
    labeling([], Result),
    statistics(walltime, [_, ElapsedTime | _]),

    sort(Piece1A, FinalPiece1),
    sort(Piece2A, FinalPiece2),

    nl, format('A solution has been found!~nElapsed time: ~3d seconds', ElapsedTime), nl,
    fd_statistics, nl.




% ------------------ SOME EXAMPLE SOLUTIONS ------------------

% 1.
% solveBoard(2, 3, 2, kings, knights, P1, P2).  ------- Correct
% solveBoard(2, 3, 2, kings, knights,[1,3],[4,6]). ----- Correct

% 2.
% solveBoard(4, 5, 3, kings, knights, P1, P2). -------- Correct
% solveBoard(4, 5, 3, kings, knights, [3,12,15], [4,6,19]). ----- Correct

% 3.
% solveBoard(2, 4, 2, rooks, kings, P1, P2).  ------ Correct
% solveBoard(2, 4, 2, rooks, kings, [3,6], [1,8]). ------ Correct

% 4.
% solveBoard(4, 5, 3, rooks, kings, P1, P2).  ------- Correct
% solveBoard(4, 5, 3, rooks, kings, [8,12,19],[4,6,15]). ------ Correct
	
% 5.
% solveBoard(3, 3, 2, bishops, knights, P1, P2). ----- Correct
% solveBoard(3, 3, 2, bishops, knights, [6,9], [1,2]). ----- Correct

% 6.
% solveBoard(4, 4, 4, bishops, knights, P1, P2). --- Correct but takes too long
% solveBoard(4, 4, 4, bishops, knights, [2,8,9,15], [6,7,10,11]). --- Correct but takes too long

% 7. 
% solveBoard(3, 5, 4, bishops, knights, P1, P2). --------- Correct
% solveBoard(3, 5, 4, bishops, knights, [4,6,13,15], [2,3,7,8]). ---- Correct

% 8.
% solveBoard(4, 6, 4, bishops, kings, P1, P2). ------------- Prolly infinite loop
% solveBoard(4, 6, 4, bishops, kings, [4,12,13,21], [3,7,18,22]).

% 9.
% solveBoard(5, 5, 4, bishops, kings, P1, P2). ------------- Correct but takes really long time
% solveBoard(5, 5, 4, bishops, kings, [1,9,18,20], [6,8,17,25]). ----- Correct

% 10.
% solveBoard(3, 4, 3, knights, rooks, P1, P2). ------------- Correct
% solveBoard(3, 4, 3, knights, rooks, [3,4,7], [1,6,12]). -------- Correct

% 11.
% solveBoard(3, 8, 5, knights, rooks, P1, P2). ----------- Taking too long, not sure if wrong (2)
% solveBoard(3, 8, 5, knights, rooks, [3,4,11,12,24], [1,7,10,13,22]).

% 12.
% solveBoard(2, 4, 2, knights, queens, P1, P2). ----- Correct
% solveBoard(2, 4, 2, knights, queens, [2,7], [1,8]). ---- Correct

% 13.
% solveBoard(3, 6, 3, knights, queens, P1, P2). -------------- Correct
% solveBoard(3, 6, 3, knights, queens, [3,9,10], [6,7,17]). ------ Correct

% 14.
% solveBoard(4, 5, 3, knights, queens, P1, P2). -------------- Correct
% solveBoard(4, 5, 3, knights, queens, [2,12,14], [5,11,19]). ----- Correct

% 15.
% solveBoard(4, 7, 4, knights, queens, P1, P2). ----------- Too Long
% solveBoard(4, 7, 4, knights, queens, [1,8,21,28], [6,10,19,23]). --------- Too Long
