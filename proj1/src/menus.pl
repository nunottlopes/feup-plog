mainMenu :-
    printMainMenu,
    askInput,
    read(Input),
    handleMainMenuInput(Input).

handleMainMenuInput(0) :-
    write('\nExiting game...\n\n').

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
    write('\nExiting game...\n\n').

handleStartMenuInput(1) :-
    initializeGame('Player1', 'Player2', 0).

handleStartMenuInput(2) :-
    printDificultLevelMenu,
    askInput,
    read(Input),
    handleDificultLevelMenuInput('Player1', 'Computer2', Input).

handleStartMenuInput(3) :-  
    printDificultLevelMenu,
    askInput,
    read(Input),
    handleDificultLevelMenuInput('Computer1', 'Computer2', Input).

handleStartMenuInput(_) :-
    write('> Wrong option, please chose another option '),
    read(Input),
    handleStartMenuInput(Input).

handleDificultLevelMenuInput(Player1, Player2, 1) :-
    initializeGame(Player1, Player2, 1).

handleDificultLevelMenuInput(Player1, Player2, 2) :-
    initializeGame(Player1, Player2, 2).

handleDificultLevelMenuInput(Player1, Player2, 0) :-
    write('\nExiting game...\n\n').

handleDificultLevelMenuInput(Player1, Player2, _) :-
    write('> Wrong option, please chose another option '),
    read(Input),
    handleDificultLevelMenuInput(Player1, Player2, Input).

askInput :-
    write('> Insert your option ').

printMainMenu :-
    clearScreen,
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
    clearScreen,
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

printDificultLevelMenu :-
    clearScreen,
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
    write('|         |         |      |         1. Easy         |      |         |         |'), nl,
    write('|         |         |      |                         |      |         |         |'), nl,
    write('|---------|---------|------|         2. Hard         |------|---------|---------|'), nl,
    write('|         |         |      |                         |      |         |         |'), nl,
    write('|         |         |      |         0. Exit         |      |         |         |'), nl,
    write('|         |         |      |-------------------------|      |         |         |'), nl,
    write('|---------|---------|------|                         |------|---------|---------|'), nl,
    write('|         |         |                                       |         |         |'), nl,
    write('|         |         |        ______________________         |         |         |'), nl,
    write('|         |         |               Nuno Lopes              |         |         |'), nl,
    write('|         |         |          Francisco Ferreira           |         |         |'), nl,
    write('|         |         |                                       |         |         |'), nl,
    write('|---------|---------|---------|---------|---------|---------|---------|---------|'), nl, nl.


player1Turn :-
	write('\n\n------------------------- PLAYER 1 TURN (X) -------------------------\n').

player2Turn :-
	write('\n\n------------------------- PLAYER 2 TURN (O) -------------------------\n').

computer1Turn :-
	write('\n\n------------------------- COMPUTER 1 TURN (X) -------------------------\n').

computer2Turn :-
	write('\n\n------------------------- COMPUTER 2 TURN (O) -------------------------\n').

player1Win(Board) :-
    display_game(Board, 'Player1'),
	write('\n\n------------------------- PLAYER 1 WINS (X) !! -------------------------\n\n').

player2Win(Board) :-
    display_game(Board, 'Player2'),
	write('\n\n------------------------- PLAYER 2 WINS (O) !! -------------------------\n\n').

computer1Win(Board) :-
    display_game(Board, 'Computer1'),
	write('\n\n------------------------- COMPUTER 1 WINS (X) !! -------------------------\n\n').

computer2Win(Board) :-
    display_game(Board, 'Computer2'),
	write('\n\n------------------------- COMPUTER 2 WINS (O) !! -------------------------\n\n').


printMove(OldRow, OldColumn, NewRow, NewColumn) :-
    convertRowReverse(OldRow, OR),
    convertColumnReverse(OldColumn, OC),
    convertRowReverse(NewRow, NR),
    convertColumnReverse(NewColumn, NC),
    write('FROM:\n > Row: '),
    write(OR), nl,
    write(' > Column: '),
    write(OC), nl,
    write('TO:\n > Row: '),
    write(NR), nl,
    write(' > Column: '),
    write(NC), nl.

convertRowReverse(1, T) :-
    T = 8.

convertRowReverse(2, T) :-
    T = 7.

convertRowReverse(3, T) :-
    T = 6.

convertRowReverse(4, T) :-
    T = 5.

convertRowReverse(5, T) :-
    T = 4.

convertRowReverse(6, T) :-
    T = 3.

convertRowReverse(7, T) :-
    T = 2.

convertRowReverse(8, T) :-
    T = 1.

convertColumnReverse(1, V) :-
    V = 'A'.

convertColumnReverse(2, V) :-
    V = 'B'.

convertColumnReverse(3, V) :-
    V = 'C'.

convertColumnReverse(4, V) :-
    V = 'D'.

convertColumnReverse(5, V) :-
    V = 'E'.

convertColumnReverse(6, V) :-
    V = 'F'.

convertColumnReverse(7, V) :-
    V = 'G'.

convertColumnReverse(8, V) :-
    V = 'H'.
