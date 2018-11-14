:- include('menus.pl').
:- include('board.pl').
:- include('logic.pl').
:- include('player.pl').
:- include('computer.pl').
:- include('input.pl').
:- include('utils.pl').

re :-
    reconsult('src/quartetto'),
    quartetto.

q :-
  reconsult('src/quartetto'),
  mainMenu.

quartetto :-
    mainMenu.
