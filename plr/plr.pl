:- use_module(library(clpfd)).

re :-
    reconsult('src/plr').

cripto(L) :-
    L = [C, R, O, S, A, D, N, G, E],
    domain(L, 0 , 9),

    C#>0, R#>0, D#>0,
    all_different(L),
    C*10000 + R*1000 + O*100 + S*10 + S
    + R*10000 + O*1000 + A*100 + D*10 + S #=
    D*100000 + A*10000 + N*1000 + G*100 + E*10+ R,
    
    labeling([],L).


fechadura(L) :-
    L = [A, B, C],
    domain(L, 1, 50),

    B #= A*2,
    C #= B+10,
    A + B #> 10,
    A #= A1*10 + A2, A1 in 0..5, A2 in 0..9,
    A1 mod 2 #\= A2 mod 2,
    B #= B1*10 + B2, B1 in 0..5, B2 in 0..9,
    B1 mod 2 #= B2 mod 2,

    labeling([],L).


forte(L) :-
    length(L,12),
    domain(L, 1, 12),

    count(1, L, #=, S1),
    count(2, L, #=, S2),
    count(3, L, #=, S3),
    count(4, L, #=, S4),
    S1+S2+S3+S4 #= 5,
    count(5, L, #=, S5),
    count(6, L, #=, S6),
    count(7, L, #=, S7),
    S4+S5+S6+S7 #= 5,
    count(8, L, #=, S8),
    count(9, L, #=, S9),
    count(10, L, #=, S10),
    S7+S8+S9+S10 #= 5,
    count(11, L, #=, S11),
    count(12, L, #=, S12),
    S1+S12+S11+S10 #= 5,

    labeling([],L).

forte2(L) :-
    L=[S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12],
    domain(L,0,5),
    sum(L, #=, 12),
    sum([S1,S2,S3,S4], #=, 5),
    sum([S4,S5,S6,S7], #=, 5),
    sum([S7,S8,S9,S10], #=, 5),
    sum([S10,S11,S12,S1], #=, 5),

    labeling([], L).

pls5(Cores, Tamanhos) :-
    length(Cores, 4),
    domain(Cores, 1, 4), Amarelo = 1, Verde = 2, Azul = 3, Preto = 4,
    length(Tamanhos, 4),
    domain(Tamanhos, 1, 4),
    all_different(Cores),
    all_different(Tamanhos),

    element(PosAzul, Cores, Azul),
    PosAntesAzul #= PosAzul - 1,
    PosDepoisAzul #= PosAzul + 1,

    element(PosAntesAzul, Tamanhos, TamanhoAntesAzul),
    element(PosDepoisAzul, Tamanhos, TamanhoDepoisAzul),
    TamanhoAntesAzul #< TamanhoDepoisAzul,

    element(PosVerde, Cores, Verde),
    element(PosVerde, Tamanhos, TamanhoCarroVerde),
    TamanhoCarroVerde #= 1,

    PosAzul #< PosVerde,

    element(PosAmarelo, Cores, Amarelo),
    element(PosPreto, Cores, Preto),
    PosPreto #< PosAmarelo,

    append(Cores, Tamanhos, Total),

    labeling([], Total).

automoveis(Carros) :-
    length(Carros, 12),
    domain(Carros, 1, 4), Amarelo = 1, Verde = 2, Vermelho = 3, Azul = 4,

    global_cardinality(Carros, [Amarelo-4, Verde-2, Vermelho-3, Azul-3]),

    element(1, Carros, CorIgual),
    element(12, Carros, CorIgual),

    element(2, Carros, CorIgual2),
    element(11, Carros, CorIgual2),

    element(5, Carros, Azul),

    trios(Carros),

    quadras(Carros, Contador),
    count(1, Contador, #=, 1),

    labeling([], Carros).

trios([A,B,C|R]) :-
    all_different([A,B,C]),
    trios([B,C|R]).
trios([_,_]).

quadras([A,B,C,D|R], [X|Xs]) :-
    (A #= 1 #/\ B #= 2 #/\ C #= 3 #/\ D #= 4) #<=> X,
    quadras([B,C,D|R], Xs).
quadras([_,_,_], []).


carteiro(N, L, Dist) :-
    length(L, N),
    domain(L, 1, N),
    all_different(L),
    soma_dist(L, Dist),
    circuit(L),
    labeling([maximize(Dist)], L).

soma_dist([X,Y|R], D) :-
    D #= abs(X-Y) + Contador,
    soma_dist([Y|R], Contador).
soma_dist([_], 0).


tarefas(Ss, Es) :-
    % task(StartTime, Duração, EndTime, Recursos, Identificador)
    Tasks = [task(S1, 16, E1, 2, 1),
            task(S2, 6, E2, 9, 2),
            task(S3, 13, E3, 3, 3),
            task(S4, 7, E4, 7, 4),
            task(S5, 5, E5, 10, 5),
            task(S6, 18, E6, 1, 6),
            task(S7, 4, E7, 11, 7)],
    Ss = [S1, S2, S3, S4, S5, S6, S7],
    Es = [E1, E2, E3, E4, E5, E6 ,E7],
    domain(Ss, 1, 50),
    domain(Es, 1, 50),
    % limite de recursos = 13
    cumulative(Tasks, [limit(13)]),
    % minimizar o maior EndTime
    maximum(End, Es),
    labeling([minimize(End)], Ss).
    