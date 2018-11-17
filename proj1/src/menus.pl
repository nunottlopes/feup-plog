%----------------------------------------------------------------
% MAIN MENU AND HANDLERS

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
    write('|         |         |      |      1. Start Game      |      |         |         |'), nl,
    write('|         |         |      |                         |      |         |         |'), nl,
    write('|---------|---------|------|      2. How to Play     |------|---------|---------|'), nl,
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

handleMainMenuInput(2) :-
    printHowToPlay,
    pressEnterToContinue,
    mainMenu.

handleMainMenuInput(_) :-
    write('> Wrong option, please chose another option '),
    read(Input),
    handleMainMenuInput(Input).

askInput :-
    write('> Insert your option ').


%----------------------------------------------------------------
% START MENU AND HANDLERS 

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

handleStartMenuInput(0) :-
    write('\nExiting game...\n\n').

handleStartMenuInput(1) :-
    initializeGame('Player1', 'Player2', 0).

handleStartMenuInput(2) :-
    printDificultLevelMenu,
    askInput,
    read(Input),
    handleDifficultLevelMenuInput('Player1', 'Computer2', Input).

handleStartMenuInput(3) :-  
    printDificultLevelMenu,
    askInput,
    read(Input),
    handleDifficultLevelMenuInput('Computer1', 'Computer2', Input).

handleStartMenuInput(_) :-
    write('> Wrong option, please chose another option '),
    read(Input),
    handleStartMenuInput(Input).


%----------------------------------------------------------------
% DIFFICULT LEVEL MENU AND HANDLERS 

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
    write('|---------|---------|------|-------------------------|------|---------|---------|'), nl,
    write('|         |         |      |         1. Easy         |      |         |         |'), nl,
    write('|         |         |      |                         |      |         |         |'), nl,
    write('|         |         |      |         2. Normal       |      |         |         |'), nl,
    write('|---------|---------|------|                         |------|---------|---------|'), nl,
    write('|         |         |      |         3. Hard         |      |         |         |'), nl,
    write('|         |         |      |                         |      |         |         |'), nl,
    write('|         |         |      |         0. Exit         |      |         |         |'), nl,
    write('|---------|---------|------|-------------------------|------|---------|---------|'), nl,
    write('|         |         |                                       |         |         |'), nl,
    write('|         |         |        ______________________         |         |         |'), nl,
    write('|         |         |               Nuno Lopes              |         |         |'), nl,
    write('|         |         |          Francisco Ferreira           |         |         |'), nl,
    write('|         |         |                                       |         |         |'), nl,
    write('|---------|---------|---------|---------|---------|---------|---------|---------|'), nl, nl.

handleDifficultLevelMenuInput(Player1, Player2, 1) :-
    initializeGame(Player1, Player2, 1).

handleDifficultLevelMenuInput(Player1, Player2, 2) :-
    initializeGame(Player1, Player2, 2).

handleDifficultLevelMenuInput(Player1, Player2, 3) :-
    initializeGame(Player1, Player2, 3).

handleDifficultLevelMenuInput(Player1, Player2, 0) :-
    write('\nExiting game...\n\n').

handleDifficultLevelMenuInput(Player1, Player2, _) :-
    write('> Wrong option, please chose another option '),
    read(Input),
    handleDifficultLevelMenuInput(Player1, Player2, Input).


%----------------------------------------------------------------
% HOW TO PLAY MENU AND HANDLERS 

printHowToPlay :-
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
    write('|         |         |              HOW TO PLAY              |         |         |'), nl,
    write('|---------|---------|------|                         |------|---------|---------|'), nl,
    write('|                          |-------------------------|                          |'), nl,
    write('|   Objective:                                                                  |'), nl,
    write('|    Place all own checkers in cells meeting the following conditions:          |'), nl,
    write('|     1. Middle points of the cells should be vertices of some rotated square.  |'), nl,
    write('|     2. The smallest bounding box containing the cells should be at least 5x5. |'), nl,
    write('|                                                                               |'), nl,
    write('|   Move:                                                                       |'), nl,
    write('|     Checkers are moved horizontally or vertically any number of cells.        |'), nl,
    write('|     Checkers cannot land on an occupied cell or jump over such cells.         |'), nl,
    write('|     IMPORTANT: Use lowercase letters to select the columns.                   |'), nl,
    write('|                                                                               |'), nl,
    write('|---------|---------|---------|-------------------|---------|---------|---------|'), nl,
    write('|         |         |               Nuno Lopes              |         |         |'), nl,
    write('|         |         |          Francisco Ferreira           |         |         |'), nl,
    write('|         |         |                                       |         |         |'), nl,
    write('|---------|---------|---------|---------|---------|---------|---------|---------|'), nl, nl.

pressEnterToContinue:-
	write('Press <Enter> to go back.'), nl,
	waitForEnter, !.

waitForEnter:-
	get_char(_),
    get_char(_).


%----------------------------------------------------------------
% TURN, MOVE AND WIN PRINTS

player1Turn :-
	write('\n\n------------------------- PLAYER 1 TURN (X) -------------------------\n').

player2Turn :-
	write('\n\n------------------------- PLAYER 2 TURN (O) -------------------------\n').

player1Win(Board) :-
    display_game(Board, 'Player1'),
    write('\n\n\n-----------------------------------------------------------------------\n'),
	write('|                          PLAYER 1 WINS (X)                          |\n'),
    write('-----------------------------------------------------------------------\n\n').

player2Win(Board) :-
    display_game(Board, 'Player2'),
    write('\n\n\n-----------------------------------------------------------------------\n'),
	write('|                          PLAYER 2 WINS (O)                          |\n'),
    write('-----------------------------------------------------------------------\n\n').

computer1Win(Board) :-
    display_game(Board, 'Computer1'),
    write('\n\n\n-----------------------------------------------------------------------\n'),
	write('|                         COMPUTER 1 WINS (X)                         |\n'),
    write('-----------------------------------------------------------------------\n\n').

computer2Win(Board) :-
    display_game(Board, 'Computer2'),
    write('\n\n\n-----------------------------------------------------------------------\n'),
	write('|                         COMPUTER 2 WINS (O)                         |\n'),
    write('-----------------------------------------------------------------------\n\n').

printPlayerMove('Player1') :-
    write('\n\n------------------------- PLAYER 1 MOVE (X) -------------------------\n').

printPlayerMove('Player2') :-
    write('\n\n------------------------- PLAYER 2 MOVE (O) -------------------------\n').

printPlayerMove('Computer1') :-
    write('\n\n------------------------- COMPUTER 1 MOVE (X) -------------------------\n').

printPlayerMove('Computer2') :-
    write('\n\n------------------------- COMPUTER 2 MOVE (O) -------------------------\n').


%----------------------------------------------------------------
% PRINT PLAYER MOVE FUNCTION 

printMove(Player, OldRow, OldColumn, NewRow, NewColumn) :-
    printPlayerMove(Player),
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
