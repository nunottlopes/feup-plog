mainMenu :-
    printMainMenu,
    askInput,
    read(Input),
    handleMainMenuInput(Input).

handleMainMenuInput(0) :-
    write('\nExiting game...\n').

handleMainMenuInput(1) :-
    printStartMenu,
    askInput,
    read(Input),
    handleStartMenuInput(Input).

handleMainMenuInput(_) :-
    write('> Wrong option, please chose another option '),
    read(Input),
    handleMainMenuInput(Input).

handleStartMenuInput(0) :-
    write('\nExiting game...\n').

handleStartMenuInput(1) :-
    initializeGame('Player', 'Player').

handleStartMenuInput(2) :-
    initializeGame('Player', 'Computer').

handleStartMenuInput(3) :-
    initializeGame('Computer', 'Computer').

handleStartMenuInput(_) :-
    write('> Wrong option, please chose another option '),
    read(Input),
    handleStartMenuInput(Input).

askInput :-
    write('> Insert your option ').

printMainMenu :-
    nl,
    write('|---------|---------|---------|---------|---------|---------|---------|---------|'), nl,
    write('|                 _____                 _         _    _                        |'), nl,
    write('|                |     | _ _  ___  ___ | |_  ___ | |_ | |_  ___                 |'), nl,
    write('|                |  |  || | || . ||  _||  _|| -_||  _||  _|| . |                |'), nl,
    write('|                |__  _||___||__,||_|  |_|  |___||_|  |_|  |___|                |'), nl,
    write('|                   |__|                                                        |'), nl,
    write('|                                                                               |'), nl,
    write('|---------|---------|---------|---------|---------|---------|---------|---------|'), nl,
    write('|         |         |                                       |         |         |'), nl,
    write('|         |         |                                       |         |         |'), nl,
    write('|---------|---------|------|                         |------|---------|---------|'), nl,
    write('|         |         |      |-------------------------|      |         |         |'), nl,
    write('|         |         |      |                         |      |         |         |'), nl,
    write('|         |         |      |      1. Start Game      |      |         |         |'), nl,
    write('|---------|---------|------|                         |------|---------|---------|'), nl,
    write('|         |         |      |         0. Exit         |      |         |         |'), nl,
    write('|         |         |      |                         |      |         |         |'), nl,
    write('|         |         |      |-------------------------|      |         |         |'), nl,
    write('|---------|---------|------|                         |------|---------|---------|'), nl,
    write('|         |         |                                       |         |         |'), nl,
    write('|         |         |        ______________________         |         |         |'), nl,
    write('|         |         |               Nuno Lopes              |         |         |'), nl,
    write('|         |         |          Francisco Ferreira           |         |         |'), nl,
    write('|         |         |                                       |         |         |'), nl,
    write('|---------|---------|---------|---------|---------|---------|---------|---------|'), nl, nl.

printStartMenu :-
    nl,
    write('|---------|---------|---------|---------|---------|---------|---------|---------|'), nl,
    write('|                 _____                 _         _    _                        |'), nl,
    write('|                |     | _ _  ___  ___ | |_  ___ | |_ | |_  ___                 |'), nl,
    write('|                |  |  || | || . ||  _||  _|| -_||  _||  _|| . |                |'), nl,
    write('|                |__  _||___||__,||_|  |_|  |___||_|  |_|  |___|                |'), nl,
    write('|                   |__|                                                        |'), nl,
    write('|                                                                               |'), nl,
    write('|---------|---------|---------|---------|---------|---------|---------|---------|'), nl,
    write('|         |         |                                       |         |         |'), nl,
    write('|         |         |                                       |         |         |'), nl,
    write('|---------|---------|------|-------------------------|------|---------|---------|'), nl,
    write('|         |         |      |   1. Player vs Player   |      |         |         |'), nl,
    write('|         |         |      |                         |      |         |         |'), nl,
    write('|         |         |      |  2. Player vs Computer  |      |         |         |'), nl,
    write('|---------|---------|------|                         |------|---------|---------|'), nl,
    write('|         |         |      | 3. Computer vs Computer |      |         |         |'), nl,
    write('|         |         |      |                         |      |         |         |'), nl,
    write('|         |         |      |         0. Exit         |      |         |         |'), nl,
    write('|---------|---------|------|-------------------------|------|---------|---------|'), nl,
    write('|         |         |                                       |         |         |'), nl,
    write('|         |         |        ______________________         |         |         |'), nl,
    write('|         |         |               Nuno Lopes              |         |         |'), nl,
    write('|         |         |          Francisco Ferreira           |         |         |'), nl,
    write('|         |         |                                       |         |         |'), nl,
    write('|---------|---------|---------|---------|---------|---------|---------|---------|'), nl, nl.


player1Turn :-
	write('\n\n------------------------- PLAYER 1 TURN -------------------------\n').

player2Turn :-
	write('\n\n------------------------- PLAYER 2 TURN -------------------------\n').

askMove(OldPosition, NewPosition, OldBoard, NewBoard, Player) :-
    write('Which board piece do you want to move? '),
    readExistPiece(Player, OldPosition, OldBoard),
    choseNewPosition(Player, NewPosition).

readExistPiece(Player, OldPosition, OldBoard) :- 
    read(OldPosition),
    checkPieceOnPosition(OldPosition, Player, OldBoard, Valid),
    Valid == 1 -> (
        write('No piece in that position, please chose another one '),
        readExistPiece(Player, OldPosition, OldBoard)
    ).

choseNewPosition(Player, Position) :-
    write('Where do you want to place the piece? '),
    readNewPiece(Player, Position).

readNewPiece(Player, Position) :-
    read(Position),
    checkValidNewPosition(Position, Player, Valid),
    Valid == 1 -> (
        write('ask for new position again')
    ).

