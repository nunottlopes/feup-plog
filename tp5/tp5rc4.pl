max(X, Y, Z, X) :- X>=Y, X>=Z, !.
max(X, Y, Z, Y) :- Y>=Z, !.
max(_, _, Z, Z). 