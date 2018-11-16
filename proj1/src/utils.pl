clearScreen :-
	addNL(65).
	
addNL(A) :-
	A > 0, nl,
	A1 is A-1,
	addNL(A1).
	
addNL(_).

increment(Old, New) :-
	New is Old + 1.

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


% GET THE LENGTH FROM A LIST

listLength(Xs, L) :- 
    listLength(Xs, 0, L).

listLength( [], L, L).

listLength([_|Xs], T, L) :-
  T1 is T+1,
  listLength(Xs, T1, L).


% GET THE MAX NUMBER FROM A LIST

maxList([], Max, Max).

maxList([H|T], Max0, Max) :-
    H >  Max0,
    maxList(T, H, Max).

maxList([H|T], Max0, Max) :-
    H =< Max0,
    maxList(T, Max0, Max).

maxList([H|T], Max):-
    maxList(T, H, Max).


% GET THE MIN NUMBER FROM A LIST

minList([], Min, Min).

minList([H|T], Min0, Min) :-
    Min1 is min(H, Min0),
    minList(T, Min1, Min).

minList([H|T], Min) :-
    minList(T, H, Min).