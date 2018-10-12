membro(X,L):- append(_,[X|_],L).
last(L,X):- append(_, [_|X], L).
n_membro(1, [X|_], X).
n_membro(N, [_|T], X):-
    N>1,
    N1 is N-1,
    n_membro(N1,T,X).