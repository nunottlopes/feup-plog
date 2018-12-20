% checks if two lists with the same size have the same elements
same_elements_list([], _).
same_elements_list([A|Rest], ListB) :-
    element(_, ListB, A),
    same_elements_list(Rest, ListB).


% checks if two lists with the same size have the same elements in a different order
% different_lists(ListA, ListB, ListLength) :-
%     different_lists_iterator(ListA, ListB, Counter),
%     count(1, Counter, #<, 4).

% different_lists_iterator([A|ListA], [B|ListB], [X|Xs]) :-
%     (A #= B) #<=> X,
%     different_lists_iterator(ListA, ListB, Xs).
% different_lists_iterator([], [], []).

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