:- include('menus.pl').
:- include('board.pl').
:- include('logic.pl').
:- include('player.pl').
:- include('computer.pl').
:- include('input.pl').
:- include('utils.pl').

:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(system)).

re :-
    reconsult('src/quartetto'), play.
    
play :-
    mainMenu.
