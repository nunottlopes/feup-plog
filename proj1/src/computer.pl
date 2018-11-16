moveComputer(OldBoard, NewBoard, Player, Level) :-
    choose_move(Player, OldBoard, Level, OldRow, OldColumn, NewRow, NewColumn),
    makeMove(OldBoard, Player, OldRow, OldColumn, NewRow, NewColumn, NewBoard),
    printMove(OldRow, OldColumn, NewRow, NewColumn).

choose_move(Player, Board, 1, OldRow, OldColumn, NewRow, NewColumn) :-
    valid_moves(Player, Board, [], Ret),
    random_member([OldRow, OldColumn, NewRow, NewColumn], Ret).


choose_move(Player, Board, 2, OldRow, OldColumn, NewRow, NewColumn) :-
    checkIfAlmostVictory(Player, Board, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp, Flag),
    handleFlagAlmostVictory(Flag, Player, Board, OldRow, OldColumn, NewRow, NewColumn, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp).

handleFlagAlmostVictory(2, Player, Board, OldRow, OldColumn, NewRow, NewColumn, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp) :-
    OldRow = OldRowTemp,
    OldColumn = OldColumnTemp,
    NewRow = NewRowTemp,
    NewColumn = NewColumnTemp.

handleFlagAlmostVictory(_, Player, Board, OldRow, OldColumn, NewRow, NewColumn, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp) :-
    checkIfAlmostDefeat(Player, Board, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp, Flag),
    handleFlagAlmostDefeat(Flag, Player, Board, OldRow, OldColumn, NewRow, NewColumn, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp).
    write('handle').

% ------------------------------------------------------------------------------------------------------

handleFlagAlmostDefeat(2, Player, Board, OldRow, OldColumn, NewRow, NewColumn, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp) :-
    write('Almost Defeat'), nl,
    possibleDefense(isDefensible, Player, Board, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp),
    generateMove(isDefensible, Player, Board, OldRow, OldColumn, NewRow, NewColumn, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp).

possibleDefense(isDefensible, Player, Board, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp) :-
    valid_moves(Player, Board, [], Ret),
    % Iterar e ver se pode movimentar-se para a jogada que salva o jogo
    % member(X, [One]).

generateMove(1, Player, Board, OldRow, OldColumn, NewRow, NewColumn, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp):-
    valid_moves(Player, Board, [], Ret),
    random_member([OldRow, OldColumn, NewRow, NewColumn], Ret).

generateMove(2, Player, Board, OldRow, OldColumn, NewRow, NewColumn, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp):-
    OldRow = OldRowTemp,
    OldColumn = OldColumnTemp,
    NewRow = NewRowTemp,
    NewColumn = NewColumnTemp.


OtherPlayer('Player1', P2) :-
  P2 = 'Player2'.

OtherPlayer('Player2', P2) :-
  P2 = 'Player1'.

checkIfAlmostDefeat(Player, Board, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp, Flag) :-
  OtherPlayer(Player, P2)
  valid_moves(P2, Board, [], Ret),
  checkEachMove(P2, Board, Ret, Flag2, OR, OC, NR, NC),
  handleFlag(Flag2, Flag, OR, OC, NR, NC, OldRow, OldColumn, NewRow, NewColumn).

% ------------------------------------------------------------------------------------------------------

checkIfAlmostVictory(Player, Board, OldRow, OldColumn, NewRow, NewColumn, Flag) :-
    valid_moves(Player, Board, [], Ret),
    checkEachMove(Player, Board, Ret, Flag2, OR, OC, NR, NC),
    handleFlag(Flag2, Flag, OR, OC, NR, NC, OldRow, OldColumn, NewRow, NewColumn).

handleFlag(2, Flag, OR, OC, NR, NC, OldRow, OldColumn, NewRow, NewColumn) :-
    OldRow = OR,
    OldColumn = OC,
    NewRow = NR,
    NewColumn = NC,
    Flag is 2.

handleFlag(_, Flag, OR, OC, NR, NC, OldRow, OldColumn, NewRow, NewColumn) :-
    Flag is 1.

checkEachMove(Player, Board, [], Flag2, OldRow, OldColumn, NewRow, NewColumn) :-
    Flag2 is 1.

checkEachMove(Player, Board, [[OR,OC,NR,NC]|T], Flag2, OldRow, OldColumn, NewRow, NewColumn) :-
    makeMove(Board, Player, OR, OC, NR, NC, BoardTemp),
    checkVictory(Player, BoardTemp, Result),
    handleCheckVictory(Player, Board, T, OR, OC, NR, NC, Result, Flag2, OldRow, OldColumn, NewRow, NewColumn).

handleCheckVictory(Player, Board, T, OR, OC, NR, NC, 2, Flag2, OldRow, OldColumn, NewRow, NewColumn) :-
    OldRow = OR,
    OldColumn = OC,
    NewRow = NR,
    NewColumn = NC,
    Flag2 is 2.

handleCheckVictory(Player, Board, T, OR, OC, NR, NC, 1, Flag2, OldRow, OldColumn, NewRow, NewColumn) :-
    checkEachMove(Player, Board, T, Flag2, OldRow, OldColumn, NewRow, NewColumn).

checkVictory(Player, NewBoard, Result)








board([
    [empty, empty, white, white, white, white, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, black, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, black, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, black, empty, empty, empty, empty],
    [empty, black, empty, empty, empty, empty, empty, empty]
]).

t :-
    board(X),
    checkIfAlmostVictory('Player1', X, OldRow, OldColumn, NewRow, NewColumn, Flag),
    write(OldRow), nl,
    write(OldColumn), nl,
    write(NewRow), nl,
    write(NewColumn), nl,
    write('Flag final: '),
    write(Flag), nl.
