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

askMove(OldRow, OldColumn, NewRow, NewColumn, OldBoard, NewBoard, Player) :-
    askOldPosition(Player, OldRow, OldColumn, OldBoard),
    askNewPosition(Player, NewRow, NewColumn, NewBoard).

askOldPosition(Player, OldRow, OldColumn, OldBoard) :-
    write('> Which board piece do you want to move?\n'),
    readExistPiece(Player, OldRow, OldColumn, OldBoard).

askNewPosition(Player, NewRow, NewColumn, NewBoard) :-
    write('> Where do you want to place the piece?\n'),
    readNewPiece(Player, NewRow, NewColumn, NewBoard).

readExistPiece(Player, OldRow, OldColumn, OldBoard) :-
    askRow(OldRow),
    askColumn(OldColumn),
    checkPieceOnPosition(OldRow, OldColumn, Player, OldBoard, Valid),
    (Valid == 1 -> (
        write('\n> No piece in that position, please chose another one\n'),
        readExistPiece(Player, OldRow, OldColumn, OldBoard)
    );
    write('\n')).

readNewPiece(Player, NewRow, NewColumn, NewBoard) :-
    askRow(NewRow),
    askColumn(NewColumn),
    checkValidNewPosition(NewRow, NewColumn, Player, NewBoard, Valid),
    (Valid == 1 -> (
        write('\n> Invalid position to place the piece, please chose another one\n'),
        readNewPiece(Player, NewRow, NewColumn, NewBoard)
    );
    write('\n')).

checkPieceOnPosition(OldRow, OldColumn, Player, [H|T], Valid) :-
    OldRow == 1 -> (
        lookOnColumn(OldColumn, Player, H, Valid)
    );(
        OldRow1 is OldRow-1,
        checkPieceOnPosition(OldRow1, OldColumn, Player, T, Valid)
    ).

checkPieceOnPosition(OldRow, OldColumn, Player, [], Valid).

lookOnColumn(OldColumn, Player, [H|T], Valid) :-
    OldColumn == 1 -> (
        checkIfCorrectPiece(H, Player, Valid)
    );(
        OldColumn1 is OldColumn-1,
        lookOnColumn(OldColumn1, Player, T, Valid)
    ).

checkIfCorrectPiece(Piece, Player, Valid) :-
    Player == 'Player1' -> (
        Piece == 'black' -> (
            Valid is 2
        );(
            Valid is 1
        )
    );(
        Piece == 'white' -> (
            Valid is 2
        );(
            Valid is 1
        )
    ).











checkValidNewPosition(NewRow, NewColumn, Player, NewBoard, Valid) :-
    Valid is 1,
    write('check here if new position for piece is valid, return on Valid\n').



move(OldRow, OldColumn, NewRow, NewColumn, OldBoard, NewBoard, Player) :-
    askMove(OldRow, OldColumn, NewRow, NewColumn, OldBoard, NewBoard, Player),
    write('move the piece from oldposition to newposition here\n').

checkVictory(Player, Board, Result) :-
    write('check if player won, response on Result\n').

initializeGame(Player1, Player2) :-
    initialBoard(Board),
    play(Player1, Player2, Board).

