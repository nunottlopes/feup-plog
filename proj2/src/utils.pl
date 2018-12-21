% checks if two lists with the same size have the same elements
same_elements_list([], _).
same_elements_list([A|Rest], ListB) :-
    element(_, ListB, A),
    same_elements_list(Rest, ListB).


% checks if two lists with the same size have the same elements in a different order
different_lists(ListA, ListB, ListLength) :-
    different_lists_iterator(ListA, ListB, Counter),
    MaxValue #= ListLength-1,
    count(1, Counter, #<, MaxValue).

different_lists_iterator([A|ListA], [B|ListB], [X|Xs]) :-
    (A #= B) #<=> X,
    different_lists_iterator(ListA, ListB, Xs).
different_lists_iterator([], [], []).


% Makes sure if a List is in ascending order
sorted([A,B|R]) :-
    A #< B,
    sorted([B|R]).
sorted([_]).

% Replaces the element in index I on a List by the element X
replace([_|T], 1, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > 0, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).