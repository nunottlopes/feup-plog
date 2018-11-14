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

askMove(OldRow, OldColumn, NewRow, NewColumn, OldBoard, Player) :-
    askOldPosition(Player, OldRow, OldColumn, OldBoard),
    askNewPosition(OldRow, OldColumn, NewRow, NewColumn, OldBoard).

askOldPosition(Player, OldRow, OldColumn, OldBoard) :-
    write('> Which board piece do you want to move?\n'),
    readExistPiece(Player, OldRow, OldColumn, OldBoard).

askNewPosition(OldRow, OldColumn, NewRow, NewColumn, OldBoard) :-
    write('> Where do you want to place the piece?\n'),
    readNewPiece(OldRow, OldColumn, NewRow, NewColumn, OldBoard).

checkPieceOnPosition(OldRow, OldColumn, Player, [H|T], Valid) :-
    OldColumn == 10 -> (
        Valid is 1
    );(
        OldRow == 10 ->(
            Valid is 1
        );(
            OldRow == 1 -> (
                lookOnColumn(OldColumn, Player, H, Valid)
            );(
                OldRow1 is OldRow-1,
                checkPieceOnPosition(OldRow1, OldColumn, Player, T, Valid) 
            )
    )).

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

checkValidNewPosition(OldRow, OldColumn, NewRow, NewColumn, [H|T], Valid) :-
    NewColumn == 10 -> (
        Valid is 1
    );(
        NewRow == 10 ->(
            Valid is 1
        );(
            OldRow == NewRow -> (
                OldColumn == NewColumn -> (
                Valid is 1
            );(
                OldRow == 1 -> (
                    validColumn(OldColumn, NewColumn, H, Valid)
                );(
                    OldRow1 is OldRow-1,
                    NewRow1 is NewRow-1,
                    checkValidNewPosition(OldRow1, OldColumn, NewRow1, NewColumn, T, Valid) 
                    )
                )
            );(
                OldColumn == NewColumn -> (
                    validRow(OldRow, NewRow, OldColumn, [H|T], Valid)
                );(
                    Valid is 1
                )
            )
        )
    ).

checkValidNewPosition(OldRow, OldColumn, NewRow, NewColumn, [], Valid).

validColumn(OldColumn, NewColumn, [H|T], Valid) :-
    OldColumn < NewColumn -> (
        OldColumn == 1 -> (
            validColumnForward(T, NewColumn, Valid)
        );(
            OldColumn1 is OldColumn-1,
            NewColumn1 is NewColumn-1,
            validColumn(OldColumn1, NewColumn1, T, Valid)
        )
    );(
        NewColumn == 1 -> (
            validColumnBackward([H|T], OldColumn, Valid)
        );(
            OldColumn1 is OldColumn-1,
            NewColumn1 is NewColumn-1,
            validColumn(OldColumn1, NewColumn1, T, Valid)
        )
    ).

validColumn(OldColumn, NewColumn, [], Valid).

validColumnForward([H|T], Column, Valid) :-
    H == 'empty' -> (
        Column == 2 -> (
            Valid is 2
        );(
            Column1 is Column-1,
            validColumnForward(T, Column1, Valid)
        )
    );(
        Valid is 1
    ).

validColumnForward([], Column, Valid).

validColumnBackward([H|T], Column, Valid) :-
    H == 'empty' -> (
        Column == 2 -> (
            Valid is 2
        );(
            Column1 is Column-1,
            validColumnBackward(T, Column1, Valid)
        )
    );(
        Valid is 1
    ).

validColumnBackward([], Column, Valid).

validRow(OldRow, NewRow, Column, [H|T], Valid) :- 
    OldRow < NewRow -> (
        OldRow = 1 -> (
            validRowIterator(T, NewRow, Column, Valid)
        );(
            OldRow1 is OldRow-1,
            NewRow1 is NewRow-1,
            validRow(OldRow1, NewRow1, Column, T, Valid)
        )
    );(
        NewRow = 1 -> (
            validRowIterator([H|T], OldRow, Column, Valid)
        );(
            OldRow1 is OldRow-1,
            NewRow1 is NewRow-1,
            validRow(OldRow1, NewRow1, Column, T, Valid)
        )
    ).

validRow(OldRow, NewRow, Column, [], Valid).

validRowIterator([H|T], Row, Column, Valid) :-
    checkEmptySpot(H, Column, Flag),
    % Flag == 1 ->(
      %  Valid is 1
    % );(
      %  Row == 2 -> (
         %   Valid is 2
       % );(
         %   Row1 is Row-1,
         %   validRowIterator(T, Row1, Column, Valid)
       % )
    %).
    checkFlag(Flag, Valid, Row, T, Column).

checkFlag(1, Valid, Row, T, Column) :-
    Valid is 1.

checkFlag(_, Valid, Row, T, Column) :-
    % Row == 2 -> (
       %  Valid is 2
    % );(
       %  Row1 is Row-1,
        % validRowIterator(T, Row1, Column, Valid)
    %)
    checkIfRow(Valid, Row, T, Column).

checkIfRow(Valid, 2, T, Column) :-
    Valid is 2.

checkIfRow(Valid, Row, T, Column) :-
    Row1 is Row-1,
    validRowIterator(T, Row1, Column, Valid).

validRowIterator([], Row, Column, Valid).

checkEmptySpot([H|T], Column, Flag) :-
    Column == 1 -> (
        H == 'empty' -> (
            Flag is 2
        );(
            Flag is 1
        )
    );(
        Column1 is Column-1,
        checkEmptySpot(T, Column1, Flag)
    ).

checkEmptySpot([], Column, Flag).

move(OldRow, OldColumn, NewRow, NewColumn, OldBoard, NewBoard, Player) :-
    askMove(OldRow, OldColumn, NewRow, NewColumn, OldBoard, Player),
    write(OldRow), nl,
    write(OldColumn), nl,
    write(NewRow), nl,
    write(NewColumn), nl,
    write('move the piece from oldposition to newposition here\n').

checkVictory(Player, Board, Result) :-
    write('check if player won, response on Result\n').

initializeGame(Player1, Player2) :-
    initialBoard(Board),
    play(Player1, Player2, Board).



re :-
    reconsult('src/quartetto'),
    quartetto.