dados(um).
dados(dois).
dados(tres). 

cut_teste_a(X) :-
    dados(X).
cut_teste_a('ultima_clausula'). 

cut_teste_b(X):-
    dados(X), !.
cut_teste_b('ultima_clausula'). 

cut_teste_c(X,Y) :-
    dados(X), 
    !,
    dados(Y).
cut_teste_c('ultima_clausula'). 