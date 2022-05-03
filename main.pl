:- ['TDA_cardsSet.pl'], ['TDA_gamersInfo'].
:- use_module(tda_cardsSet), use_module(tda_gamersInfo).

cardsSet(Elements, NumE, MaxC, Seed, CS):-var(MaxC), totalCardsNumE(NumE, NewMaxC), cardsSet(Elements, NumE, NewMaxC, Seed, CS), !.
cardsSet(Elements, NumE, MaxC, Seed, [Elements,CS]):-not(var(MaxC)), firstCardGeneration(Elements, NumE, [], Cout), NewMaxC is MaxC - 1, nCardsGeneration(Elements, NumE, 1, NewMaxC, [Cout], CSout), NewMaxC2 is MaxC - NumE, n2CardsGeneration(Elements, NumE, 1, 1, NewMaxC2, CSout, CS), !.


cardsSetIsDobble([Elements, CS]):-numECardsSet(CS, NumE), elementsAppearancesCondition(Elements, CS, NumE), maxOneCommonElementAll(CS).

cardsSetNthCard([_,CS],N,C):-cardsSetNthCard(CS, N, C), !.
cardsSetNthCard([C | _], 0, C):-!.
cardsSetNthCard([_ | CS], N, C):-NewN is N - 1, cardsSetNthCard(CS, NewN, C).

cardsSetFindTotalCards(C, TotalCards):- numECardsSet([C], NumE), totalCardsNumE(NumE, TotalCards).

cardsSetMissingCards([Elements, CSin], CSout):-numECardsSet(CSin, NumE), totalCardsNumE(NumE, TotalCards), cardsLength(CSin, R), MaxC is TotalCards - R, cardsSetAux(Elements, NumE, MaxC, CSin, FullCS), subtract(FullCS, CSin, CSout).

cardsSetToString([_, CS], String):-cardsToString(CS, 1, String).

dobbleGame(NumP, CS, Mode, Seed, [GsI, [[], CS], "esperando cartas en mesa", Mode, Seed]):- initGamersInfo(NumP, GsI).

dobbleGameRegister(User, [GsI_in, GArea, Status, Mode, Seed], [GsI_out, GArea, Status, Mode, Seed]):- not(var(GsI_in)), totalRegisteredGamers(GsI_in, T), maxPlayersToRegist(GsI_in, MaxP), T \= MaxP, newGamer(User, GsI_in, GsI_out), !.
dobbleGameRegister(User, [GsI_in, GArea, Status, Mode, Seed], [GsI_out, GArea, Status, Mode, Seed]):- var(GsI_in), newGamer(User, GsI_in, GsI_out).

dobbleGameWhoseTurnIsIt([GsI, GArea, Status, Mode, Seed], UserName):- getGamerTurn(GsI, UserName).
