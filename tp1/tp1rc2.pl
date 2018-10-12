piloto(lamb).
piloto(besenyei).
piloto(chambliss).
piloto(macLean).
piloto(mangold).
piloto(jones).
piloto(bonhomme).
equipa(breitling,lamb).
equipa('red bull',besenyei).
equipa('red bull',chambliss).
equipa('mediterranean racing team', macLean).
equipa(cobra,mangold).
equipa(matador,jones).
equipa(matador,bonhomme).
aviao(lamb,mx2).
aviao(besenyei,edge540).
aviao(chambliss,edge540).
aviao(macLean,edge540).
aviao(mangold,edge540).
aviao(jones,edge540).
aviao(bonhomme,edge540).
circuito(istanbul).
circuito(budapest).
circuito(porto).
vencedor(jones,porto).
vencedor(mangold,budapest).
vencedor(mangold,istanbul).
gates(istanbul,9).
gates(budapest,6).
gates(porto,5).
equipavencedora(E,C):-
    equipa(E,P),
    vencedor(P,C).
multivencedor(P):-
    vencedor(P,C1),
    vencedor(P,C2),
    C1@<C2.
maisgates(C,G):-
    gates(C,G2),
    G2>G.
naopilota(P,A):-
    aviao(P,A1),
    A\=A1.


%a)vencedor(P,porto).
%b)equipavencedora(E,porto). 
%c)multivencedor(P).
%d)maisgates(G,8).
%e)naopilota(P,edge540).