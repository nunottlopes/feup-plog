%-------------------------------------------------------
% COMPUTER MOVE

moveComputer(OldBoard, NewBoard, Player, Level) :-
    choose_move(Player, OldBoard, Level, OldRow, OldColumn, NewRow, NewColumn),
    makeMove(OldBoard, Player, OldRow, OldColumn, NewRow, NewColumn, NewBoard),
    clearScreen,
    printMove(Player, OldRow, OldColumn, NewRow, NewColumn).


% ------------------------------------------------------------------------------------------------------
% EASY MODE

choose_move(Player, Board, 1, OldRow, OldColumn, NewRow, NewColumn) :-
    valid_moves(Player, Board, [], Ret),
    random_member([OldRow, OldColumn, NewRow, NewColumn], Ret).


% ------------------------------------------------------------------------------------------------------
% NORMAL MODE

choose_move(Player, Board, 2, OldRow, OldColumn, NewRow, NewColumn) :-
    evaluate_and_choose_normal(Player, Board, OldRow, OldColumn, NewRow, NewColumn).

evaluate_and_choose_normal(Player, Board, OldRow, OldColumn, NewRow, NewColumn) :-
    valid_moves(Player, Board, [], Ret),
    moveToVictory(Player, Board, Ret, [[], -1000], Move1, Value1),
    otherPlayer(Player, Player2),
    moveToAvoidLoss(Player2, Board, Ret, Move2, Value2),
    chooseFinalMoveNormal(Player, Board, OldRow, OldColumn, NewRow, NewColumn, Move1, Value1, Move2, Value2).


chooseFinalMoveNormal(Player, Board, OldRow, OldColumn, NewRow, NewColumn, [OR, OC, NR, NC], 2, Move2, Value2) :-
    OldRow = OR,
    OldColumn = OC,
    NewRow = NR,
    NewColumn = NC.

chooseFinalMoveNormal(Player, Board, OldRow, OldColumn, NewRow, NewColumn, Move1, Value1, [OR, OC, NR, NC], 2) :-
    OldRow = OR,
    OldColumn = OC,
    NewRow = NR,
    NewColumn = NC.

chooseFinalMoveNormal(Player, Board, OldRow, OldColumn, NewRow, NewColumn, Move1, Value1, Move2, Value2) :-
    choose_move(Player, Board, 1, OldRow, OldColumn, NewRow, NewColumn).


% ------------------------------------------------------------------------------------------------------
% HARD MODE

choose_move(Player, Board, 3, OldRow, OldColumn, NewRow, NewColumn) :-
    evaluate_and_choose_hard(Player, Board, OldRow, OldColumn, NewRow, NewColumn).

evaluate_and_choose_hard(Player, Board, OldRow, OldColumn, NewRow, NewColumn) :-
    valid_moves(Player, Board, [], Ret),
    moveToVictory(Player, Board, Ret, [[], -1000], Move1, Value1),
    otherPlayer(Player, Player2),
    moveToAvoidLoss(Player2, Board, Ret, Move2, Value2),
    twoMovesToVictory(Player, Board, Ret, [[], -1000], Move3, Value3),
    twoMovesToAvoidLoss(Player2, Board, Ret, Move4, Value4),
    chooseFinalMoveHard(Player, Board, OldRow, OldColumn, NewRow, NewColumn, Move1, Value1, Move2, Value2, Move3, Value3, Move4, Value4).


chooseFinalMoveHard(Player, Board, OldRow, OldColumn, NewRow, NewColumn, [OR, OC, NR, NC], 2, Move2, Value2, Move3, Value3, Move4, Value4) :-
    OldRow = OR,
    OldColumn = OC,
    NewRow = NR,
    NewColumn = NC.

chooseFinalMoveHard(Player, Board, OldRow, OldColumn, NewRow, NewColumn, Move1, Value1, [OR, OC, NR, NC], 2, Move3, Value3, Move4, Value4) :-
    OldRow = OR,
    OldColumn = OC,
    NewRow = NR,
    NewColumn = NC.

chooseFinalMoveHard(Player, Board, OldRow, OldColumn, NewRow, NewColumn, Move1, Value1, Move2, Value2, [OR, OC, NR, NC], 2, Move4, Value4) :-
    OldRow = OR,
    OldColumn = OC,
    NewRow = NR,
    NewColumn = NC.

chooseFinalMoveHard(Player, Board, OldRow, OldColumn, NewRow, NewColumn, Move1, Value1, Move2, Value2, Move3, Value3, [OR, OC, NR, NC], 2) :-
    OldRow = OR,
    OldColumn = OC,
    NewRow = NR,
    NewColumn = NC.

chooseFinalMoveHard(Player, Board, OldRow, OldColumn, NewRow, NewColumn, Move1, Value1, Move2, Value2, Move3, Value3, Move4, Value4) :-
    choose_move(Player, Board, 1, OldRow, OldColumn, NewRow, NewColumn).


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
    game_over(Player, NewBoard, Value).


%-------------------------------------------------------
% FUNCTIONS TO EVALUATE BEST MOVE TO AVOID LOSS

moveToAvoidLoss(Player, Board, OtherPlayerMoves, BestMove, Value) :-
    valid_moves(Player, Board, [], Ret),
    moveToVictory(Player, Board, Ret, [[], -1000], Move2, Value2),
    checkIfEqualPosition(OtherPlayerMoves, Move2, Value2, BestMove, Value).


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
% FUNCTIONS TO EVALUATE BEST TWO MOVES TO AVOID LOSS

twoMovesToAvoidLoss(Player, Board, OtherPlayerMoves, BestMove, Value) :-
    valid_moves(Player, Board, [], Ret),
    twoMovesToVictory(Player, Board, Ret, [[], -1000], Move2, Value2),
    checkIfEqualPosition(OtherPlayerMoves, Move2, Value2, BestMove, Value).


%-------------------------------------------------------
% HELPFUL FUNCTIONS

otherPlayer('Computer1', P2) :-
  P2 = 'Computer2'.

otherPlayer('Computer2', P2) :-
  P2 = 'Computer1'.
  

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