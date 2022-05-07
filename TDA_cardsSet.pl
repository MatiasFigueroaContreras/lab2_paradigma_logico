:- module(tda_cardsSet, [emptyCardSet/1, firstCard/2, nextCards/2, addCard/3, cardsLength/2, numECardsSet/2, maxOneCommonElementCardsSet/2, elementAppearances/3, totalCardsNumE/2, cardsSetAux/5, createValidCard/5, firstCardGeneration/4, nCardsGeneration/6, n2CardsGeneration/7, elementsAppearancesCondition/3, maxOneCommonElementAll/1, cardsToString/3]).
:- ['TDA_card.pl'].
:- use_module(tda_card).

emptyCardSet([]).

firstCard([F | _], F).

nextCards([_ | N], N).

addCard(Cset, C, [C | Cset]).

cardsLength([], 0).
cardsLength([_ | Cs], R):- cardsLength(Cs, R2), R is R2 + 1.

numECardsSet(CS, NumE):-firstCard(CS, C), cardLength(C, NumE).

maxOneCommonElementCardsSet(_, []):-!.
maxOneCommonElementCardsSet(C, [C2 | SubCset]):- commonElements(C, C2, R), R =< 1, maxOneCommonElementCardsSet(C, SubCset).

elementAppearances(_, [], 0):-!.
elementAppearances(E, [C1 | SubCset], R):- elementAppearances(E, SubCset, R1), isInCard(E, C1), R is R1 + 1, !.
elementAppearances(E, [_ | SubCset], R):- elementAppearances(E, SubCset, R).

totalCardsNumE(NumE, R):- R is NumE * NumE - NumE + 1.

cardsSetAux(_, _, 0, CSin, CSin):- !.
cardsSetAux(Es, NumE, MaxC, CSin, CSout):- createValidCard(Es, NumE, CSin, [], C), cardLength(C, NumE), NewMaxC is MaxC - 1, cardsSetAux(Es, NumE, NewMaxC, [C | CSin], CSout), !.

createValidCard(_, NumE, _, Cin, Cin):- cardLength(Cin, NumE), !.
createValidCard(Es, NumE, _, Cin, _):- cardLength(Cin, R), cardLength(Es, R1), R1 < R - NumE, !.
createValidCard([E | Es], NumE, CS, Cin, Cout):-elementAppearances(E, CS, R), R < NumE, maxOneCommonElementCardsSet([E | Cin], CS), createValidCard(Es, NumE, CS, [E | Cin], Cout).
createValidCard([_ | Es], NumE, CS, Cin, Cout):-createValidCard(Es, NumE, CS, Cin, Cout).


firstCardGeneration(_, 0, Cin, Cin):-!.
firstCardGeneration([E | Es], NumE, Cin, Cout):- MNumE is NumE - 1, firstCardGeneration(Es, MNumE, [E | Cin], Cout).

nCardGeneration(_, NumE, _, NumE, Cin, Cin):-!.
nCardGeneration(Es, NumE, I, J, Cin, Cout):-Nth is (NumE-1)*I + J+1, nth1(Nth, Es, E), NewJ is J + 1, nCardGeneration(Es, NumE, I, NewJ, [E | Cin], Cout).

nCardsGeneration(_, NumE, NumE, _, CSin, CSin):-!.
nCardsGeneration(_, _, _, 0, CSin, CSin):-!.
nCardsGeneration([E | Es], NumE, I, MaxC, CSin, CSout):-nCardGeneration([E | Es], NumE, I, 1, [E], Cout), NewI is I + 1, NewMaxC is MaxC - 1, nCardsGeneration([E | Es], NumE, NewI, NewMaxC, [Cout | CSin], CSout).



%n2CardGeneration(Elements, NumE, I, J, K, Cin, Cout)
%n2CardsGeneration(Elements, NumE, I, J, MaxC, Cin, Cout)
n2CardGeneration(_, NumE, _, _, NumE, Cin, Cin):-!.
n2CardGeneration(Es, NumE, I, J, K, Cin, Cout):-N is NumE-1, Nth is (N+2+N*(K-1) + (((I-1)*(K-1)+J-1) mod N)), nth1(Nth, Es, E), NewK is K + 1, n2CardGeneration(Es, NumE, I, J, NewK, [E | Cin], Cout), !.


n2CardsGeneration(_, _, _, _, MaxC, CSin, CSin):- MaxC =< 0, !.
n2CardsGeneration(_, NumE, NumE, _, _, CSin, CSin):-!.
n2CardsGeneration(Es, NumE, I, NumE, MaxC, CSin, CSout):- NewI is I + 1, n2CardsGeneration(Es, NumE, NewI, 1, MaxC, CSin, CSout), !.
n2CardsGeneration(Es, NumE, I, J, MaxC, CSin, CSout):-Nth is I + 1, nth1(Nth, Es, E), n2CardGeneration(Es, NumE, I, J, 1, [E], Cout), NewJ is J + 1, NewMaxC is MaxC - 1, n2CardsGeneration(Es, NumE, I, NewJ, NewMaxC, [Cout | CSin], CSout).


elementsAppearancesCondition([], _, _).
elementsAppearancesCondition([E | Es], CS, NumE):-elementAppearances(E, CS, R), R =< NumE, elementsAppearancesCondition(Es, CS, NumE).

maxOneCommonElementAll([]).
maxOneCommonElementAll([C | CS]):- maxOneCommonElementCardsSet(C, CS), maxOneCommonElementAll(CS).

cardsToString([], _, ""):-!.
cardsToString([C | CS], I, Str):-cardToString(C, I, S1), string_concat(S1, '\n', S2), NewI is I + 1, cardsToString(CS, NewI, S3), string_concat(S2, S3, Str).