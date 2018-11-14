:- include('menus.pl').
:- include('board.pl').
:- include('logic.pl').
:- include('player.pl').
:- include('computer.pl').
:- include('input.pl').
:- include('utils.pl').

re :-
    reconsult('src/quartetto'),
    play.

q :-
  reconsult('src/quartetto'),
  mainMenu.

play :-
    mainMenu.
