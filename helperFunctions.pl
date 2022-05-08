:-module(helperFunctions, [isPrime/1, fillList/5, totalCardsNumE/2, mode/1]).

isPrimeAux(N, N):-!.
isPrimeAux(N, I):- V is N mod I, V \= 0, NewI is I + 1, isPrimeAux(N, NewI).

isPrime(N):-N > 1, isPrimeAux(N, 2).


fillList(Tot, Tot, _, EsOut, EsOut):-!.
fillList(Tot, ActTot, I, EsIn, EsOut):-not(member(I, EsIn)), NewActTot is ActTot + 1, NewI is I + 1, fillList(Tot, NewActTot, NewI, [I | EsIn], EsOut), !.
fillList(Tot, ActTot, I, EsIn, EsOut):-NewI is I + 1, fillList(Tot, ActTot, NewI, EsIn, EsOut), !.

totalCardsNumE(NumE, R):- R is NumE * NumE - NumE + 1.

mode('stack').
