askColumn(NewColumn) :-
    write('> Column: '),
    get_code(Column),
    convertColumn(Column, NewColumn).

convertColumn(65, NewColumn) :-
    NewColumn = 1.

convertColumn(66, NewColumn) :-
    NewColumn = 2.

convertColumn(67, NewColumn) :-
    NewColumn = 3.

convertColumn(68, NewColumn) :-
    NewColumn = 4.

convertColumn(69, NewColumn) :-
    NewColumn = 5.

convertColumn(70, NewColumn) :-
    NewColumn = 6.

convertColumn(71, NewColumn) :-
    NewColumn = 7.

convertColumn(72, NewColumn) :-
    NewColumn = 8.

convertColumn(10, NewColumn) :-
    get_code(Column),
    convertColumn(Column, NewColumn).

convertColumn(46, NewColumn) :-
    get_code(Column),
    convertColumn(Column, NewColumn).

convertColumn(_Column, NewColumn) :-
    write('ERROR: That column is not valid!\n'),
    askColumn(NewColumn).

askRow(NewRow) :-
    write('> Row: '),
    get_code(Row),
    checkCorrectRow(Row, NewRow).

checkCorrectRow(10, NewRow) :-
    get_code(Input),
    checkCorrectRow(Input, NewRow).

checkCorrectRow(46, NewRow) :-
    get_code(Input2),
    checkCorrectRow(Input2, NewRow).

checkCorrectRow(56, NewRow) :-
    NewRow = 1.

checkCorrectRow(55, NewRow) :-
    NewRow = 2.

checkCorrectRow(54, NewRow) :-
    NewRow = 3.

checkCorrectRow(53, NewRow) :-
    NewRow = 4.

checkCorrectRow(52, NewRow) :-
    NewRow = 5.

checkCorrectRow(51, NewRow) :-
    NewRow = 6.

checkCorrectRow(50, NewRow) :-
    NewRow = 7.

checkCorrectRow(49, NewRow) :-
    NewRow = 8.

checkCorrectRow(X, NewRow) :-
    write(X),
    write('ERROR: That row is not valid!\n'),
    askRow(NewRow).

