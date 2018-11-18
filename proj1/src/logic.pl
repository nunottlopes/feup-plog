%----------------------------------------------------------------
% MAIN GAME FUNCTIONS

play('Player1', 'Player2', Board, Level) :-
    Player1 = 'Player1',
    Player2 = 'Player2',
    display_game(Board, Player1),
    player1Turn,
    move(Board, NewBoard1, Player1),
    game_over(Player1, NewBoard1, Result1),

    if(Result1 == 1,
        (
            display_game(NewBoard1, Player2),
            player2Turn,
            move(NewBoard1, NewBoard2, Player2),
            game_over(Player2, NewBoard2, Result2),

            if(Result2 == 1, play(Player1, Player2, NewBoard2, Level), player2Win(NewBoard2))

        ), player1Win(NewBoard1)).

play('Player1', 'Computer2', Board, Level) :-
    Player1 = 'Player1',
    Player2 = 'Computer2',
    display_game(Board, Player1),
    player1Turn,
    move(Board, NewBoard1, Player1),
    game_over(Player1, NewBoard1, Result1),

    if(Result1 == 1,
        (
            moveComputer(NewBoard1, NewBoard2, Player2, Level),
            game_over(Player2, NewBoard2, Result2),

            if(Result2 == 1, play(Player1, Player2, NewBoard2, Level), computer2Win(NewBoard2))

        ), player1Win(NewBoard1)).

play('Computer1', 'Computer2', Board, Level) :-
    Player1 = 'Computer1',
    Player2 = 'Computer2',
    display_game(Board, Player1),
    sleep(0.5),
    moveComputer(Board, NewBoard1, Player1, Level),
    game_over(Player1, NewBoard1, Result1),

    if(Result1 == 1,
        (
            display_game(NewBoard1, Player2),
            sleep(0.5),
            moveComputer(NewBoard1, NewBoard2, Player2, Level),
            game_over(Player2, NewBoard2, Result2),

            if(Result2 == 1, play(Player1, Player2, NewBoard2, Level), computer2Win(NewBoard2))

        ), computer1Win(NewBoard1)).


%-------------------------------------------------------
% CHECK IF THERE IS A PIECE IN THE POSITION CHOSEN

checkPieceOnPosition(_OldRow, 10, _Player, _, Valid) :-
    Valid is 1.

checkPieceOnPosition(10, _OldColumn, _Player, _, Valid) :-
    Valid is 1.

checkPieceOnPosition(1, OldColumn, Player, [H|_T], Valid) :-
    lookOnColumn(OldColumn, Player, H, Valid).

checkPieceOnPosition(OldRow, OldColumn, Player, [_H|T], Valid) :-
    OldRow1 is OldRow-1,
    checkPieceOnPosition(OldRow1, OldColumn, Player, T, Valid).

checkPieceOnPosition(_OldRow, _OldColumn, _Player, [], _Valid).

lookOnColumn(1, Player, [H|_T], Valid) :-
    checkIfCorrectPiece(H, Player, Valid).

lookOnColumn(OldColumn, Player, [_H|T], Valid) :-
    OldColumn1 is OldColumn-1,
    lookOnColumn(OldColumn1, Player, T, Valid).

checkIfCorrectPiece('black', 'Player1', Valid) :-
    Valid is 2.

checkIfCorrectPiece(_Piece, 'Player1', Valid) :-
    Valid is 1.

checkIfCorrectPiece('white', 'Player2', Valid) :-
    Valid is 2.

checkIfCorrectPiece(_Piece, 'Player2', Valid) :-
    Valid is 1.

checkIfCorrectPiece('black', 'Computer1', Valid) :-
    Valid is 2.

checkIfCorrectPiece(_Piece, 'Computer1', Valid) :-
    Valid is 1.

checkIfCorrectPiece('white', 'Computer2', Valid) :-
    Valid is 2.

checkIfCorrectPiece(_Piece, 'Computer2', Valid) :-
    Valid is 1.

checkIfCorrectPiece(_, _, Valid) :-
    Valid is 1.


%-------------------------------------------------------
% CHECK IF NEW PLACE CHOSEN IS VALID

checkValidNewPosition(_OldRow, _OldColumn, _NewRow, 10, _Board, Valid) :-
    Valid is 1.

checkValidNewPosition(_OldRow, _OldColumn, 10, _NewColumn, _Board, Valid) :-
    Valid is 1.

checkValidNewPosition(OldRow, OldColumn, NewRow, NewColumn, [H|T], Valid) :-
    OldRow == NewRow,
    (OldColumn == NewColumn,
    Valid is 1;
    checkIfRowValidNewPosition(OldRow, OldColumn, NewRow, NewColumn, [H|T], Valid));
    (OldColumn == NewColumn,
    validRow(OldRow, NewRow, OldColumn, [H|T], Valid);
    Valid is 1).

checkValidNewPosition(_OldRow, _OldColumn, _NewRow, _NewColumn, [], _Valid).

checkIfRowValidNewPosition(1, OldColumn, _NewRow, NewColumn, [H|_T], Valid) :-
    validColumn(OldColumn, NewColumn, H, Valid).

checkIfRowValidNewPosition(OldRow, OldColumn, NewRow, NewColumn, [_H|T], Valid) :-
    OldRow1 is OldRow-1,
    NewRow1 is NewRow-1,
    checkValidNewPosition(OldRow1, OldColumn, NewRow1, NewColumn, T, Valid).


%-------------------------------------------------------
% HORIZONTAL MOVES

validColumn(OldColumn, NewColumn, [H|T], Valid) :-
    checkIfColumnIterator(OldColumn, NewColumn, [H|T], Valid).

validColumn(_OldColumn, _NewColumn, [], _Valid).

checkIfColumnIterator(1, NewColumn, [_H|T], Valid) :-
    validColumnIterator(T, NewColumn, Valid).

checkIfColumnIterator(OldColumn, 1, [H|T], Valid) :-
    validColumnIterator([H|T], OldColumn, Valid).

checkIfColumnIterator(OldColumn, NewColumn, [_H|T], Valid) :-
    OldColumn1 is OldColumn-1,
    NewColumn1 is NewColumn-1,
    validColumn(OldColumn1, NewColumn1, T, Valid).

validColumnIterator([H|T], Column, Valid) :-
    checkPieceEmpty(H, T, Column, Valid).

validColumnIterator([], _Column, _Valid).

checkPieceEmpty('empty', T, Column, Valid) :-
    checkEndColumn(T, Column, Valid).

checkPieceEmpty(_H, _T, _Column, Valid) :-
    Valid is 1.

checkEndColumn(_T, 2, Valid) :-
    Valid is 2.

checkEndColumn(T, Column, Valid) :-
    Column1 is Column-1,
    validColumnIterator(T, Column1, Valid).


%-------------------------------------------------------
% VERTICAL MOVES

validRow(1, NewRow, Column, [_H|T], Valid) :-
    validRowIterator(T, NewRow, Column, Valid).

validRow(OldRow, 1, Column, [H|T], Valid) :-
    validRowIterator([H|T], OldRow, Column, Valid).

validRow(OldRow, NewRow, Column, [_H|T], Valid) :-
    OldRow1 is OldRow-1,
    NewRow1 is NewRow-1,
    validRow(OldRow1, NewRow1, Column, T, Valid).

validRow(_OldRow, _NewRow, _Column, [], _Valid).

validRowIterator([H|T], Row, Column, Valid) :-
    checkEmptySpot(H, Column, Flag),
    checkFlag(Flag, Valid, Row, T, Column).

validRowIterator([], _Row, _Column, _Valid).

checkFlag(1, Valid, _Row, _T, _Column) :-
    Valid is 1.

checkFlag(_, Valid, 2, _T, _Column) :-
    Valid is 2.

checkFlag(_, Valid, Row, T, Column) :-
    Row1 is Row-1,
    validRowIterator(T, Row1, Column, Valid).


%-------------------------------------------------------
% CHECK IF THE POSITION IS EMPTY

checkEmptySpot([H|T], Column, Flag) :-
    handleIfColumn(Column, [H|T], Flag).

checkEmptySpot([], _Column, _Flag).

handleIfColumn(1, [H|_T], Flag) :-
    handleTypePiece(H,Flag).

handleIfColumn(Column, [_H|T], Flag) :-
    Column1 is Column-1,
    checkEmptySpot(T, Column1, Flag).

handleTypePiece('empty', Flag) :-
    Flag is 2.

handleTypePiece(_,Flag) :-
    Flag is 1.


%-------------------------------------------------------
% ACTUAL MOVE ON BOARD

makeMove(OldBoard, Player,OldRow, OldColumn, NewRow, NewColumn, NewBoard):-
    isWithinLimits(NewRow),
	isWithinLimits(NewColumn),
    getColor(Player, Type),
    
    % REMOVES THE PIECE FROM PREVIOUS POSITION
    makeMoveAux(OldBoard, 1, empty, OldRow, OldColumn, [], TempBoard ),

    % PLACES THE PIECE IN THE NEW POSITION
    makeMoveAux(TempBoard, 1, Type, NewRow, NewColumn, [], NewBoard ).

makeMoveAux([], _, _, _, _, InvertedBoard, FinalBoard) :-
    reverse(InvertedBoard, FinalBoard).

makeMoveAux( [H|T], N, Type, NewRow, NewColumn, TempBoard, FinalBoard ):-
  N == NewRow,(
    replace(H, NewColumn, Type, NewLine),
    N1 is NewRow+1,
    makeMoveAux(T, N1, Type, NewRow, NewColumn, [NewLine|TempBoard], FinalBoard)
  );(
    N1 is N+1,
    makeMoveAux(T, N1, Type, NewRow, NewColumn, [H|TempBoard], FinalBoard)
  ).


%-------------------------------------------------------
% CHECK VICTORY

game_over(Player, Board, Result) :-
    getColor(Player, Type),
    getPiecesList(Type, Board, Ret),
    checkIfSquare(Ret, Square),
    checkIfRotate(Ret, Square, Rotate),
    checkIfMinSize(Ret, Rotate, Result).


%-------------------------------------------------------
% FUNCTIONS TO GET THE PIECES POSITION

getPiecesList(Player, Board, ListOfPieces) :-
    getPositionPlayer(Player, Board, 0, 0, [], ListOfPieces).

getPositionPlayerLine(_, _, _, 9, List, Ret) :- Ret = List.

getPositionPlayerLine(Player, Board, Row, Col, List, Ret) :-
    matrix(Board, Row, Col, Value),
    Value = Player,
    append(List, [[Row, Col]], Ret1),
    Col1 is Col + 1,
    getPositionPlayerLine(Player, Board, Row, Col1, Ret1, Ret);
    Col1 is Col + 1,
    getPositionPlayerLine(Player, Board, Row, Col1, List, Ret).

getPositionPlayer(_, _, 9, _, List, Ret) :- Ret = List.

getPositionPlayer(Player, Board, Row, Col, List, Ret) :-
  getPositionPlayerLine(Player, Board, Row, Col, List, Ret1),
  Row1 is Row + 1,
  getPositionPlayer(Player, Board, Row1, Col, Ret1, Ret).

matrix(Matrix, I, J, Value) :-
    nth0(I, Matrix, Row),
    nth0(J, Row, Value).


%-------------------------------------------------------
% FUNCTIONS TO GET A LIST WITH ALL THE PLAYER VALID MOVES

valid_moves(Player, Board, ListOfMoves) :-
  getColor(Player, Type),
  getPiecesList(Type, Board, [[P1X,P1Y],[P2X,P2Y],[P3X,P3Y],[P4X,P4Y]]),
  getMovesList(Player, Board, P1X, P1Y, 0, 0, [], Temp1),
  getMovesList(Player, Board, P2X, P2Y, 0, 0, Temp1, Temp2),
  getMovesList(Player, Board, P3X, P3Y, 0, 0, Temp2, Temp3),
  getMovesList(Player, Board, P4X, P4Y, 0, 0, Temp3, ListOfMoves).

getMovesLineList(_, _, _, _, _, 9, List, Ret) :-
  Ret = List.

getMovesLineList(Player, Board,OldRow, OldColumn, Row, Col, List, Ret) :-
  increment(OldRow, OldRowTemp),
  increment(OldColumn, OldColumnTemp),
  increment(Row, RowTemp),
  increment(Col, ColTemp),
  checkValidNewPosition(OldRowTemp, OldColumnTemp, RowTemp, ColTemp, Board, Valid),
  validMoveHandler(Player, Board, OldRow, OldColumn, Row, Col, OldRowTemp, OldColumnTemp, RowTemp, ColTemp, List, Ret, Valid).

validMoveHandler(Player, Board, OldRow, OldColumn, Row, Col, _OldRowTemp, _OldColumnTemp, _RowTemp, _ColTemp, List, Ret, 1) :-
  Col1 is Col + 1,
  getMovesLineList(Player, Board, OldRow, OldColumn, Row, Col1, List, Ret).

validMoveHandler(Player, Board, OldRow, OldColumn, Row, Col, OldRowTemp, OldColumnTemp, RowTemp, ColTemp, List, Ret, _) :-
  append(List, [[OldRowTemp, OldColumnTemp, RowTemp, ColTemp]], Ret1),
  Col1 is Col + 1,
  getMovesLineList(Player, Board,OldRow, OldColumn, Row, Col1, Ret1, Ret).

getMovesList(_, _, _, _, 9, _, List, Ret) :-
  Ret = List.

getMovesList(Player, Board, OldRow, OldColumn, Row, Col, List, Ret) :-
  getMovesLineList(Player, Board,OldRow, OldColumn, Row, Col, List, Ret1),
  Row1 is Row + 1,
  getMovesList(Player, Board, OldRow, OldColumn, Row1, Col, Ret1, Ret).


%-------------------------------------------------------
% FUNCTIONS TO SEE IF THE PIECES FORM A SQUARE

distPoints([[P1X,P1Y],[P2X,P2Y]], Result) :-
    Result is ((P1X - P2X) * (P1X - P2X) + (P1Y - P2Y) * (P1Y - P2Y)).

checkIfSquare([[P1X,P1Y],[P2X,P2Y],[P3X,P3Y],[P4X,P4Y]], Square) :-
    distPoints([[P1X,P1Y],[P2X,P2Y]], D2),
    distPoints([[P1X,P1Y],[P3X,P3Y]], D3),
    distPoints([[P1X,P1Y],[P4X,P4Y]], D4),
    distPoints([[P2X,P2Y],[P3X,P3Y]], D5),
    distPoints([[P2X,P2Y],[P4X,P4Y]], D6),
    distPoints([[P3X,P3Y],[P4X,P4Y]], D7),
    R1 is (2 * D2),
    R2 is (2 * D3),
    checkValues(D2, D3, D4, D5, D6, D7, R1, R2, Square).

checkValues(D2, D3, D4, D5, D6, D7, R1, R2, Square) :-
    (D2 == D3, R1 == D4, R1 == D5),(
        (D6 == D7, D6 == D2),(Square is 2);(Square is 1)
    );(
        (D3 == D4, R2 == D2, R2 == D7),(
            (D5 == D6, D5 == D3),(Square is 2);(Square is 1)
        );(
            (D2 == D4, R1 == D3, R1 == D6),(
                (D5 == D7, D5 == D2),(Square is 2);(Square is 1)
            );(
                Square is 1
            )
        )
    ).


%-------------------------------------------------------
% FUNCTIONS TO CHECK IF SQUARE IS ROTATED

checkIfRotate(_Ret, 1, Rotate) :-
    Rotate is 1.

checkIfRotate([[P1X,_P1Y],[P2X,_P2Y],[P3X,_P3Y],[P4X,_P4Y]], _, Rotate) :-
    (P1X == P2X, P3X == P4X), (
        Rotate is 1
    );(
        (P1X == P3X, P2X == P4X), (
            Rotate is 1
        );(
            (P1X == P4X, P2X == P3X), (
                Rotate is 1
            );(
                Rotate is 2
            )
        )
    ).


%-------------------------------------------------------
% FUNCTIONS TO CHECK IF SQUARE HAS MIN SIZE

checkIfMinSize(_Ret, 1, Result) :-
    Result is 1.

checkIfMinSize([[P1X,_P1Y],[P2X,_P2Y],[P3X,_P3Y],[P4X,_P4Y]], _Rotate, Result) :-
    maxList([P1X,P2X,P3X,P4X], MaxRow),
    minList([P1X,P2X,P3X,P4X], MinRow),
    Dif is (MaxRow - MinRow),
    (Dif > 3), (
        Result is 2
    );(
        Result is 1
    ).


%-------------------------------------------------------
% FUNCTION THAT INITIALIZES GAME

initializeGame(Player1, Player2, Level) :-
    clearScreen,
    initialBoard(Board),
    play(Player1, Player2, Board, Level).
