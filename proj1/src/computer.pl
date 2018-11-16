moveComputer(OldBoard, NewBoard, Player, Level) :-
    choose_move(Player, OldBoard, Level, OldRow, OldColumn, NewRow, NewColumn),
    makeMove(OldBoard, Player, OldRow, OldColumn, NewRow, NewColumn, NewBoard),
    printMove(OldRow, OldColumn, NewRow, NewColumn).

% ------------------------------------------------------------------------------------------------------
% EASY MODE

choose_move(Player, Board, 1, OldRow, OldColumn, NewRow, NewColumn) :-
    valid_moves(Player, Board, [], Ret),
    random_member([OldRow, OldColumn, NewRow, NewColumn], Ret).

% ------------------------------------------------------------------------------------------------------
% HARD MODE

choose_move(Player, Board, 2, OldRow, OldColumn, NewRow, NewColumn) :-
    evaluate_and_choose(Player, Board, OldRow, OldColumn, NewRow, NewColumn).
    % checkIfAlmostVictory(Player, Board, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp, Flag),
    % handleFlagAlmostVictory(Flag, Player, Board, OldRow, OldColumn, NewRow, NewColumn, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp).

handleFlagAlmostVictory(2, Player, Board, OldRow, OldColumn, NewRow, NewColumn, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp) :-
    OldRow = OldRowTemp,
    OldColumn = OldColumnTemp,
    NewRow = NewRowTemp,
    NewColumn = NewColumnTemp.

handleFlagAlmostVictory(_, Player, Board, OldRow, OldColumn, NewRow, NewColumn, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp) :-
    checkIfAlmostDefeat(Player, Board, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp, Flag),
    handleFlagAlmostDefeat(Flag, Player, Board, OldRow, OldColumn, NewRow, NewColumn, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp).
    OldRow = OldRowTemp,
    OldColumn = OldColumnTemp,
    NewRow = NewRowTemp,
    NewColumn = NewColumnTemp,
    write('handle').

% ------------------------------------------------------------------------------------------------------

handleFlagAlmostDefeat(2, Player, Board, OldRow, OldColumn, NewRow, NewColumn, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp) :-
    write('Almost Defeat'), nl,
    possibleDefense(IsDefensible, Player, Board, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp),
    write('Teste'), write(IsDefensible),
    generateMove(IsDefensible, Player, Board, OldRow, OldColumn, NewRow, NewColumn, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp).

possibleDefense(IsDefensible, Player, Board, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp) :-
    valid_moves(Player, Board, [], Ret),
    countOccurences(Ret, [Row1, Col1, NewRowTemp, NewColumnTemp], Count),
    write('entrei'), nl,
    setIsDefensible(Count, IsDefensible, OldRowTemp, OldColumnTemp, Row1, Col1).

setIsDefensible(0, IsDefensible, OldRowTemp, OldColumnTemp, Row1, Col1) :-
  write('Indefensavel'),
  IsDefensible = 1.

setIsDefensible(_, IsDefensible, OldRowTemp, OldColumnTemp, Row1, Col1) :-
  write('Defensavel'),
  OldRowTemp = Row1,
  OldColumnTemp = Col1,
  IsDefensible = 2.

generateMove(1, Player, Board, OldRow, OldColumn, NewRow, NewColumn, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp):-
    valid_moves(Player, Board, [], Ret),
    random_member([OldRow, OldColumn, NewRow, NewColumn], Ret).

generateMove(2, Player, Board, OldRow, OldColumn, NewRow, NewColumn, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp):-
    write('Moving'),
    OldRow = OldRowTemp,
    OldColumn = OldColumnTemp,
    NewRow = NewRowTemp,
    NewColumn = NewColumnTemp.

countOccurences( List, Value, N ):-
	countOccurencesAux( List, Value, 0, N ).

countOccurencesAux( [], _, Result, Result ).
countOccurencesAux( [ Value | Tail ], Value, N, Result ):-
	N1 is N+1,
	countOccurencesAux( Tail, Value, N1, Result ).

countOccurencesAux( [ Head | Tail ], Value, N, Result ):-
	countOccurencesAux( Tail, Value, N, Result ).


checkIfAlmostDefeat(Player, Board, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp, Flag) :-
  otherPlayer(Player, P2),
  valid_moves(P2, Board, [], Ret),
  checkEachMove(P2, Board, Ret, Flag2, OR, OC, NR, NC),
  handleFlag(Flag2, Flag, OR, OC, NR, NC, OldRowTemp, OldColumnTemp, NewRowTemp, NewColumnTemp).

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

% checkVictory(Player, NewBoard, Result)

t2 :-
    board(X),
    valid_moves('Player2', X, [], Ret),
    write(Ret),
    countOccurences( Ret, [_,_,5,2], N),
    write('N: '),
    write(N).

t1 :-
    board(X),
    choose_move('Player2', X, 2, OldRow, OldColumn, NewRow, NewColumn),
    write(OldRow), nl,
    write(OldColumn), nl,
    write(NewRow), nl,
    write(NewColumn), nl.

t0 :-
    board(X),
    checkIfAlmostVictory('Player1', X, OldRow, OldColumn, NewRow, NewColumn, Flag),
    write(OldRow), nl,
    write(OldColumn), nl,
    write(NewRow), nl,
    write(NewColumn), nl,
    write('Flag final: '),
    write(Flag), nl.





board([
    [empty, white, empty, white, white, white, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, black, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, black, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, black, empty, empty, empty, empty],
    [empty, black, empty, empty , empty, empty, empty, empty]
]).

board1([
    [empty, empty, white, white, white, white, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, black, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, black, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, black, empty, empty, empty, empty],
    [empty, empty, black, empty, empty, empty, empty, empty]
]).


board2([
    [empty, empty, white, white, white, white, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, black, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, black, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, black, empty, black, empty, empty, empty]
]).

% t :-
  %  board1(X),
  %  valid_moves('Player1', X, [], Ret),
  %  twoMovesToVictory(Player, X, Ret, [[], -1000], Move, Value),
  %  write(Move), nl,
  %  write(Value), nl.

%-------------------------------------------------------
% FUNCTIONS TO EVALUATE BEST TWO MOVES TO VICTORY

twoMovesToVictory(Player, Board, [[OR, OC, NR, NC]|Moves], Record, BestMove, BestValue) :-
    makeMove(Board, Player, OR, OC, NR, NC, NewBoard),
    valid_moves(Player, NewBoard, [], Ret),
    moveToVictory(Player, NewBoard, Ret, [[], -1000], Move2, Value2),
    update_two_moves([OR, OC, NR, NC], Value2, Record, Record1),
    twoMovesToVictory(Player, Board, Moves, Record1, BestMove, BestValue).

twoMovesToVictory(Player, Board, [], [Move, Value], Move, Value).

update_two_moves(Move, Value, [Move1, Value1], [Move2, Value2]) :-
    Value > Value1,
    Move2 = Move,
    Value2 = Value;
    Move2 = Move1,
    Value2 = Value1.


%-------------------------------------------------------
% FUNCTIONS TO EVALUATE BEST MOVE TO VICTORY

moveToVictory(Player, Board, [Move|Moves], Record, BestMove, BestValue) :-
    value(Player, Board, Move, Value),
    update(Move, Value, Record, Record1),
    moveToVictory(Player, Board, Moves, Record1, BestMove, BestValue).

moveToVictory(Player, Board, [], [Move, Value], Move, Value).

update(Move, Value, [Move1, Value1], [Move2, Value2]) :-
    Value > Value1,
    Move2 = Move,
    Value2 = Value;
    Move2 = Move1,
    Value2 = Value1.

value(Player, Board, [OR, OC, NR, NC], Value) :-
    makeMove(Board, Player, OR, OC, NR, NC, NewBoard),
    checkVictory(Player, NewBoard, Value).



otherPlayer('Computer1', P2) :-
  P2 = 'Computer2'.

otherPlayer('Computer2', P2) :-
  P2 = 'Computer1'.

otherPlayer('Player1', P2) :-
  P2 = 'Player2'.

otherPlayer('Player2', P2) :-
  P2 = 'Player1'.


t :-
    board(X),
    evaluate_and_choose('Player1', X, OldRow, OldColumn, NewRow, NewColumn).


evaluate_and_choose(Player, Board, OldRow, OldColumn, NewRow, NewColumn) :-
    valid_moves(Player, Board, [], Ret),
    moveToVictory(Player, Board, Ret, [[], -1000], Move1, Value1),
    otherPlayer(Player, Player2),
    moveToAvoidLoss(Player2, Board, Ret, Move2, Value2),
    twoMovesToVictory(Player, Board, Ret, [[], -1000], Move3, Value3),
    twoMovesToAvoidLoss(Player2, Board, Ret, Move4, Value4),
    chooseFinalMove(Player, Board, OldRow, OldColumn, NewRow, NewColumn, Move1, Value1, Move2, Value2, Move3, Value3, Move4, Value4).


chooseFinalMove(Player, Board, OldRow, OldColumn, NewRow, NewColumn, [OR, OC, NR, NC], 2, Move2, Value2, Move3, Value3, Move4, Value4) :-
    OldRow = OR,
    OldColumn = OC,
    NewRow = NR,
    NewColumn = NC.

chooseFinalMove(Player, Board, OldRow, OldColumn, NewRow, NewColumn, Move1, Value1, [OR, OC, NR, NC], 2, Move3, Value3, Move4, Value4) :-
    OldRow = OR,
    OldColumn = OC,
    NewRow = NR,
    NewColumn = NC.

chooseFinalMove(Player, Board, OldRow, OldColumn, NewRow, NewColumn, Move1, Value1, Move2, Value2, [OR, OC, NR, NC], 2, Move4, Value4) :-
    OldRow = OR,
    OldColumn = OC,
    NewRow = NR,
    NewColumn = NC.

chooseFinalMove(Player, Board, OldRow, OldColumn, NewRow, NewColumn, Move1, Value1, Move2, Value2, Move3, Value3, [OR, OC, NR, NC], 2) :-
    OldRow = OR,
    OldColumn = OC,
    NewRow = NR,
    NewColumn = NC.

chooseFinalMove(Player, Board, OldRow, OldColumn, NewRow, NewColumn, Move1, Value1, Move2, Value2, Move3, Value3, Move4, Value4) :-
    choose_move(Player, Board, 1, OldRow, OldColumn, NewRow, NewColumn).


%-------------------------------------------------------
% FUNCTIONS TO EVALUATE BEST MOVE TO AVOID LOSS

moveToAvoidLoss(Player, Board, OtherPlayerMoves, BestMove, Value) :-
    valid_moves(Player, Board, [], Ret),
    moveToVictory(Player, Board, Ret, [[], -1000], Move2, Value2),
    checkIfEqualPosition(OtherPlayerMoves, Move2, Value2, BestMove, Value).

checkIfEqualPosition([], Move2, 2, Move3, Value) :-
    Value is 1.

checkIfEqualPosition([[OR, OC, NR, NC]| OtherMoves], [_, _, NR1, NC1], 2, [OR2, OC2, NR2, NC2], Value) :-
    NR == NR1,
    NC == NC1,
    OR2 = OR,
    OC2 = OC,
    NR2 = NR,
    NC2 = NC,
    Value is 2;
    checkIfEqualPosition(OtherMoves, [_, _, NR1, NC1], 2, [OR2, OC2, NR2, NC2], Value).

checkIfEqualPosition(OtherPlayerMoves, Move2, _, Move3, Value) :-
    Value is 1.

%-------------------------------------------------------
% FUNCTIONS TO EVALUATE BEST TWO MOVES TO AVOID LOSS

twoMovesToAvoidLoss(Player, Board, OtherPlayerMoves, BestMove, Value) :-
    valid_moves(Player, Board, [], Ret),
    twoMovesToVictory(Player, Board, Ret, [[], -1000], Move2, Value2),
    checkIfEqualPosition(OtherPlayerMoves, Move2, Value2, BestMove, Value).