delete_one(X,L1,L2):-
    append(La,[X|Lb], L1),
    append(La,Lb,L2).

delete_all(X,[X|Xs],Ys):-
    delete_all(X,Xs,Ys).

delete_all(X, [Y|Ys], [Y|Zs]):-
    X\=Y,
    delete_all(X,Ys,Zs).

delete_all(_,[],[]).

delete_all_list([X|L2], L1, L):-
    delete_all(X, L1, L4),
    delete_all_list(L2, L4, L).

delete_all_list([],_L,_L).