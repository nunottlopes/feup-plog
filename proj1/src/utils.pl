:- use_module(library(lists)).

clearScreen:-
	nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl.

% Replace element at Index with New
replace([_|T], 1, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > 0, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

% Get element at index
elementAt(N, List, Element):- nth0(N, List, Element).

isWithinLimits(N):-
	N > 0,
	N < 9.

reverseAllBoard([], []) :- !.

reverseAllBoard([H|T], X) :-
    !,
    reverseAllBoard(H, NewH),
    reverseAllBoard(T, NewT),
    append(NewT, [NewH], X).

reverseAllBoard(X, X).