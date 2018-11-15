:- use_module(library(lists)).

increment(Old, New) :-
	New is Old + 1.

clearScreen:
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

listLength(Xs, L) :- 
    listLength(Xs, 0, L).

listLength( [], L, L).

listLength([_|Xs], T, L) :-
  T1 is T+1,
  listLength(Xs, T1, L).