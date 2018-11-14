play(Player1, Player2, Board) :-
    display_game(Board, Player1),
    player1Turn,
    move(OldRow1, OldColumn1, NewRow1, NewColumn1, Board, NewBoard1, Player1),
    checkVictory(Player1, NewBoard1, Result1),

    if(Result1 == 1,
        (
            display_game(NewBoard1, Player2),
            player2Turn,
            askMove(Position2, Player2),
            move(OldPosition2, NewPosition2, NewBoard1, NewBoard2),
            checkVictory(Player2, NewBoard2, Result2),

            if(Result2 == 1, play(Player1, Player2, NewBoard2), player2Win)

        ), player1Win).

%-------------------------------------------------------
% INPUT HANDLER FOR GAME MOVES

askMove(OldRow, OldColumn, NewRow, NewColumn, OldBoard, Player) :-
    askOldPosition(Player, OldRow, OldColumn, OldBoard),
    askNewPosition(OldRow, OldColumn, NewRow, NewColumn, OldBoard).

askOldPosition(Player, OldRow, OldColumn, OldBoard) :-
    write('> Which board piece do you want to move?\n'),
    readExistPiece(Player, OldRow, OldColumn, OldBoard).

askNewPosition(OldRow, OldColumn, NewRow, NewColumn, OldBoard) :-
    write('> Where do you want to place the piece?\n'),
    readNewPiece(OldRow, OldColumn, NewRow, NewColumn, OldBoard).


%-------------------------------------------------------
% CHECK IF THERE IS A PIECE IN THE POSITION CHOSEN

checkPieceOnPosition(OldRow, 10, Player, [H|T], Valid) :-
    Valid is 1.

checkPieceOnPosition(10, OldColumn, Player, [H|T], Valid) :-
    Valid is 1.

checkPieceOnPosition(1, OldColumn, Player, [H|T], Valid) :-
    lookOnColumn(OldColumn, Player, H, Valid).

checkPieceOnPosition(OldRow, OldColumn, Player, [H|T], Valid) :-
    OldRow1 is OldRow-1,
    checkPieceOnPosition(OldRow1, OldColumn, Player, T, Valid).

checkPieceOnPosition(OldRow, OldColumn, Player, [], Valid).

lookOnColumn(1, Player, [H|T], Valid) :-
    checkIfCorrectPiece(H, Player, Valid).

lookOnColumn(OldColumn, Player, [H|T], Valid) :-
    OldColumn1 is OldColumn-1,
    lookOnColumn(OldColumn1, Player, T, Valid).

checkIfCorrectPiece('black', 'Player1', Valid) :-
    Valid is 2.

checkIfCorrectPiece(Piece, 'Player1', Valid) :-
    Valid is 1.

checkIfCorrectPiece('white', Player, Valid) :-
    Valid is 2.

checkIfCorrectPiece(Piece, Player, Valid) :-
    Valid is 1.

%-------------------------------------------------------
% CHECK IF NEW PLACE CHOSEN IS VALID

checkValidNewPosition(OldRow, OldColumn, NewRow, 10, Board, Valid) :-
    Valid is 1.

checkValidNewPosition(OldRow, OldColumn, 10, NewColumn, Board, Valid) :-
    Valid is 1.

checkValidNewPosition(OldRow, OldColumn, NewRow, NewColumn, [H|T], Valid) :-
    OldRow == NewRow,
    (OldColumn == NewColumn,
    Valid is 1;
    checkIfRowValidNewPosition(OldRow, OldColumn, NewRow, NewColumn, [H|T], Valid));
    (OldColumn == NewColumn,
    validRow(OldRow, NewRow, OldColumn, [H|T], Valid);
    Valid is 1).

checkIfRowValidNewPosition(1, OldColumn, NewRow, NewColumn, [H|T], Valid) :-
    validColumn(OldColumn, NewColumn, H, Valid).

checkIfRowValidNewPosition(OldRow, OldColumn, NewRow, NewColumn, [H|T], Valid) :-
    OldRow1 is OldRow-1,
    NewRow1 is NewRow-1,
    checkValidNewPosition(OldRow1, OldColumn, NewRow1, NewColumn, T, Valid).

checkValidNewPosition(OldRow, OldColumn, NewRow, NewColumn, [], Valid).


%-------------------------------------------------------
% HORIZONTAL MOVES

validColumn(OldColumn, NewColumn, [H|T], Valid) :-
    checkIfColumnIterator(OldColumn, NewColumn, [H|T], Valid).

checkIfColumnIterator(1, NewColumn, [H|T], Valid) :-
    validColumnIterator(T, NewColumn, Valid).

checkIfColumnIterator(OldColumn, 1, [H|T], Valid) :-
    validColumnIterator([H|T], OldColumn, Valid).

checkIfColumnIterator(OldColumn, NewColumn, [H|T], Valid) :-
    OldColumn1 is OldColumn-1,
    NewColumn1 is NewColumn-1,
    validColumn(OldColumn1, NewColumn1, T, Valid).

validColumn(OldColumn, NewColumn, [], Valid).

validColumnIterator([H|T], Column, Valid) :-
    checkPieceEmpty(H, T, Column, Valid).

checkPieceEmpty('empty', T, Column, Valid) :-
    checkEndColumn(T, Column, Valid).

checkEndColumn(T, 2, Valid) :-
    Valid is 2.

checkEndColumn(T, Column, Valid) :-
    Column1 is Column-1,
    validColumnIterator(T, Column1, Valid).

checkPieceEmpty(H, T, Column, Valid) :-
    Valid is 1.

validColumnIterator([], Column, Valid).


%-------------------------------------------------------
% VERTICAL MOVES

validRow(1, NewRow, Column, [H|T], Valid) :-
    validRowIterator(T, NewRow, Column, Valid).

validRow(OldRow, 1, Column, [H|T], Valid) :-
    validRowIterator([H|T], OldRow, Column, Valid).

validRow(OldRow, NewRow, Column, [H|T], Valid) :-
    OldRow1 is OldRow-1,
    NewRow1 is NewRow-1,
    validRow(OldRow1, NewRow1, Column, T, Valid).

validRow(OldRow, NewRow, Column, [], Valid).

validRowIterator([H|T], Row, Column, Valid) :-
    checkEmptySpot(H, Column, Flag),
    checkFlag(Flag, Valid, Row, T, Column).

checkFlag(1, Valid, Row, T, Column) :-
    Valid is 1.

checkFlag(_, Valid, 2, T, Column) :-
    Valid is 2.

checkFlag(_, Valid, Row, T, Column) :-
    Row1 is Row-1,
    validRowIterator(T, Row1, Column, Valid).

validRowIterator([], Row, Column, Valid).


%-------------------------------------------------------
% CHECK IF THE POSITION IS EMPTY

checkEmptySpot([H|T], Column, Flag) :-
    handleIfColumn(Column, [H|T], Flag).

handleIfColumn(1, [H|T], Flag) :-
    handleTypePiece(H,Flag).

handleTypePiece('empty', Flag) :-
    Flag is 2.

handleTypePiece(_,Flag) :-
    Flag is 1.

handleIfColumn(Column, [H|T], Flag) :-
    Column1 is Column-1,
    checkEmptySpot(T, Column1, Flag).

checkEmptySpot([], Column, Flag).


%-------------------------------------------------------



move(OldRow, OldColumn, NewRow, NewColumn, OldBoard, NewBoard, Player) :-
    askMove(OldRow, OldColumn, NewRow, NewColumn, OldBoard, Player),
    write(OldRow), nl,
    write(OldColumn), nl,
    write(NewRow), nl,
    write(NewColumn), nl,
    write('move the piece from oldposition to newposition here'), nl,
    makeMove( OldBoard, Player, NewRow, NewColumn, NewBoard ),
    write('New Board'), nl,
    printBoard(NewBoard).

checkVictory(Player, Board, Result) :-
    write('check if player won, response on Result\n').

initializeGame(Player1, Player2) :-
    initialBoard(Board),
    play(Player1, Player2, Board).



re :-
    reconsult('src/quartetto'),
    quartetto.
