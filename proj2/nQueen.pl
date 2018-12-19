% Para aprender

% Colocar, num tabuleiro com NxN casas, N rainhas (de xadrez), sem que nenhuma
% rainha ataque nenhuma outra (não podem estar na mesma linha horizontal,
% vertical ou diagonal)

:- use_module(library(clpfd)).

re :-
    reconsult(nQueen).
    
n_queens(N, Cols) :-
    % A lista Cols vai retornar uma lista em que o indice representa a Column e o valor dentro desse indice a Row
    length(Cols, N),
    domain(Cols, 1, N),
    all_distinct(Cols), 
    % Ate aqui ja restringimos as Columns e as Rows a serem todas diferentes, faltam as diagonais
    verify_diagonals(Cols),
    % Agora restringimos as diagonais
    labeling([], Cols).

verify_diagonals([]).

verify_diagonals([H | T]) :-
    % Esta funcao restringe todas as diagonais de todas as pecas relativamente a todas as pecas
    verify_diagonal_element(H, T, 1),
    verify_diagonals(T).

verify_diagonal_element(_, [], _).

verify_diagonal_element(X, [Y | T], Diff) :-
    % Esta funcao restringe todas as diagonais de uma peca relativamente as outras
    no_diagonal_atack(X, Y, Diff),
    IncDiff is Diff + 1,
    verify_diagonal_element(X, T, IncDiff).

no_diagonal_atack(X, Y, Diff) :-
    % Esta funcao verifica se uma peca esta na diagonal de outra consoante a sua differenca de colunas  
    % (Exemplo: Se uma peca estiver a 2 colunas de outra peca, a diagonal pode ser verificada por Linha1 = Linha2 + Diff ou Linha1 = Linha2 - Diff)
    X #\= Y + Diff,
    X #\= Y - Diff.