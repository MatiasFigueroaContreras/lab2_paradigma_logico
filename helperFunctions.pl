:-module(helperFunctions, [isPrime/1, fillList/5, totalCardsNumE/2, mode/1, randomN/2, maxN/3]).
/*
Predicados
    isPrime(N)
        isPrimeAux(N, I)
    fillList(Total, ActualTotal, I, ElementsIn, ElementsOut)
        not(Predicado)
        member(Element, Elements)
    totalCardsNumE(NumE, R)
    mode(Mode)
    randomN(XN, XNOut)
    maxN(N, Max, Nout)

Metas
    Principales:
        isPrime
        fillList
        totalCardsNumE
        mode
        randomN
        maxN
    Secundarias:
        isPrimeAux
        not
        member
*/
%Clausulas
%Reglas
isPrimeAux(N, N):-!.
isPrimeAux(N, I):- V is N mod I, V \= 0, NewI is I + 1, isPrimeAux(N, NewI).

isPrime(N):-N > 1, isPrimeAux(N, 2).

fillList(Tot, Tot, _, EsOut, EsOut):-!.
fillList(Tot, ActTot, I, EsIn, EsOut):-
    not(member(I, EsIn)), 
    NewActTot is ActTot + 1, 
    NewI is I + 1, 
    fillList(Tot, NewActTot, NewI, [I | EsIn], EsOut), !.
fillList(Tot, ActTot, I, EsIn, EsOut):-
    NewI is I + 1, 
    fillList(Tot, ActTot, NewI, EsIn, EsOut), !.

totalCardsNumE(NumE, R):- R is NumE * NumE - NumE + 1.

randomN(XN, XNOut):-
    AXN is 1103515245 * XN, 
    AXNC is AXN + 12345, 
    XNOut is AXNC mod 2147483647.

maxN(N, Max, N):- N =< Max, !.
maxN(N, Max, Nout):- NewN is N // Max, maxN(NewN, Max, Nout).

%Hechos
mode('stack').
