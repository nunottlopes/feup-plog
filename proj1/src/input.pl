askColumn(NewColumn) :-
    write('> Column: '),
    read(Column),
    convertColumn(Column, NewColumn).

convertColumn('A', NewColumn) :-
    NewColumn = 1.

convertColumn('B', NewColumn) :-
    NewColumn = 2.

convertColumn('C', NewColumn) :-
    NewColumn = 3.

convertColumn('D', NewColumn) :-
    NewColumn = 4.

convertColumn('E', NewColumn) :-
    NewColumn = 5.

convertColumn('F', NewColumn) :-
    NewColumn = 6.

convertColumn('G', NewColumn) :-
    NewColumn = 7.

convertColumn('H', NewColumn) :-
    NewColumn = 8.

convertColumn(_, NewColumn) :-
    write('ERROR: That column is not valid!\n'),
    askColumn(NewColumn).

askRow(NewRow) :-
    write('> Row: '),
    read(Row),
    checkCorrectRow(Row, NewRow).

checkCorrectRow(1, NewRow) :-
    NewRow = 1.

checkCorrectRow(2, NewRow) :-
    NewRow = 2.

checkCorrectRow(3, NewRow) :-
    NewRow = 3.

checkCorrectRow(4, NewRow) :-
    NewRow = 4.

checkCorrectRow(5, NewRow) :-
    NewRow = 5.

checkCorrectRow(6, NewRow) :-
    NewRow = 6.

checkCorrectRow(7, NewRow) :-
    NewRow = 7.

checkCorrectRow(8, NewRow) :-
    NewRow = 8.

checkCorrectRow(_, NewRow) :-
    write('ERROR: That row is not valid!\n'),
    askRow(NewRow).

