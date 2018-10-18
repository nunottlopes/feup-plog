/* Pesquisa em Profundidade */
pp(Ef, _, Ef, [Ef]).
pp(E, V, Ef, [E|Es]) :-
    ligado(E, E2),
    \+ member(E2, V),
    pp(E2, [E2|V], Ef, Es).

/* Pesquisa em Largura */
pl([[Ef|Cam]|_], Ef, S) :-
    reverse([Ef|Cam], S).

pl([[E|Cam]|Es], Ef, S) :-
    findall([E2|[E|Cam]], ligado(E,E2), LE),
    append(Es, LE, LEs),
    pl(LEs, Ef, S).

ligado(a,b). ligado(f,i).
ligado(a,c). ligado(f,j).
ligado(b,d). ligado(f,k).
ligado(b,e). ligado(g,l).
ligado(b,f). ligado(g,m).
ligado(c,g). ligado(k,n).
ligado(d,h). ligado(l,o).
ligado(d,i). ligado(i,f). 