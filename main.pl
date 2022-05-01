:- ['tda_cardsSet.pl'].
:- use_module(tda_cardsSet).

cardsSet(Elements, NumE, MaxC, Seed, CS):-var(MaxC), totalCardsNumE(NumE, NewMaxC), cardsSet(Elements, NumE, NewMaxC, Seed, CS), !.
cardsSet(Elements, NumE, MaxC, Seed, [Elements | CS]):-firstCardGeneration(Elements, NumE, [], Cout), NewMaxC is MaxC - 1, nCardsGeneration(Elements, NumE, 1, NewMaxC, [Cout], CSout), NewMaxC2 is MaxC - NumE, n2CardsGeneration(Elements, NumE, 1, 1, NewMaxC2, CSout, CS), !.


cardsSetIsDobble([Elements | CS]):-numECardsSet(CS, NumE), elementsAppearancesCondition(Elements, CS, NumE), maxOneCommonElementAll(CS).

cardsSetNthCard([C | _], -1, C):-!.
cardsSetNthCard([_ | CS], N, C):-NewN is N - 1, cardsSetNthCard(CS, NewN, C).

cardsSetFindTotalCards(C, TotalCards):- numECardsSet([C], NumE), totalCardsNumE(NumE, TotalCards).

cardsSetMissingCards([Elements | CSin], CSout):-numECardsSet(CSin, NumE), totalCardsNumE(NumE, TotalCards), cardsLength(CSin, R), MaxC is TotalCards - R, cardsSetAux(Elements, NumE, MaxC, CSin, FullCS), subtract(FullCS, CSin, CSout).

cardsSetToString([Elements | CS], String):-cardsToString(CS, 1, String).