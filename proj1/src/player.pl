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
% PLAYER MOVE

move(OldBoard, NewBoard, Player) :-
    askMove(OldRow, OldColumn, NewRow, NewColumn, OldBoard, Player),
    makeMove(OldBoard, Player, OldRow, OldColumn, NewRow, NewColumn, NewBoard),
    clearScreen,
    printMove(Player, OldRow, OldColumn, NewRow, NewColumn).