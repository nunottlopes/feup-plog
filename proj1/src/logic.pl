play(Player1, Player2, Board) :-
    display_game(Board, Player1),
    player1Turn,
    move(OldPosition1, NewPosition1, Board, NewBoard1, Player1),
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

checkPieceOnPosition(Position, Player, OldBoard, Valid) :-
    Valid is 2,
    write('check here if there is a piece in Position, return on Valid').

move(OldPosition, NewPosition, OldBoard, NewBoard, Player) :-
    askMove(OldPosition, NewPosition, OldBoard, NewBoard, Player),
    write('move the piece from oldposition to newposition here').

checkVictory(Player, Board, Result) :-
    write('check if player won, response on Result').

initializeGame(Player1, Player2) :-
    initialBoard(Board),
    play(Player1, Player2, Board).

