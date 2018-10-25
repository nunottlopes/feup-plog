unificavel([],_,[]).
unificavel([L1|L], Termo, L2) :-
    \+(L1=Termo), !,
    unificavel(L, Termo, L2).

unificavel([L1|L], Termo, [L1|L2]) :-
    unificavel(L, Termo, L2).