:- use_module(library(lists)).

clearScreen:-
	nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl.

% replace element at Index with New
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

% get element at index
elementAt(N, List, Element):- nth0(N, List, Element).

isWithinLimits(N):-
	N >= 1,
	N < 9.
