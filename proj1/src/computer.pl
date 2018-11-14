moveComputer(OldBoard, NewBoard, Player, Level) :-
    choose_move(OldBoard, Level, Move), % escolher a jogada aqui, colocar em Move, depois é só realizar a jogada 
    write('função makeMove depois aqui').


choose_move(Board, Level, Move) :-
    write('chamar aqui a função que gera todas as Moves possiveis').