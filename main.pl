:- ['TDA_cardsSet.pl'], ['TDA_gamersInfo.pl'], ['TDA_gameArea.pl'], ['helperFunctions.pl'].
:- use_module(tda_cardsSet), use_module(tda_gamersInfo), use_module(tda_gameArea), use_module(helperFunctions).

cardsSet(Elements, NumE, MaxC, Seed, CS):-
    var(MaxC), 
    totalCardsNumE(NumE, NewMaxC), 
    cardsSet(Elements, NumE, NewMaxC, Seed, CS), !.
cardsSet(Elements, NumE, MaxC, Seed, CS):-
    length(Elements, LenEs), 
    totalCardsNumE(NumE, R), LenEs < R, 
    fillList(R, LenEs, 1, Elements, NewElements), 
    cardsSet(NewElements, NumE, MaxC, Seed, CS), !. 
cardsSet(Elements, NumE, MaxC, Seed, CS):-
    N is NumE - 1, 
    isPrime(N), 
    not(var(MaxC)),
    MaxC > 0,
    firstCardGeneration(Elements, NumE, [], Cout), 
    NewMaxC is MaxC - 1, 
    nCardsGeneration(Elements, NumE, 1, NewMaxC, [Cout], CSnC), 
    NewMaxC2 is MaxC - NumE, 
    n2CardsGeneration(Elements, NumE, 1, 1, NewMaxC2, CSnC, CSn2C),
    Num is NumE * NumE * MaxC * 18 * Seed,
    totalCardsNumE(NumE, RnE),
    RnE2 is RnE * NumE,
    randomN(Num, Rn),
    maxN(Rn, RnE2, X),
    mixCardsSetXtimes([Elements, CSn2C], X, CS), !.

cardsSetIsDobble([Elements, CS]):-
    numECardsSet([_,CS], NumE),
    cardsSet(Elements, NumE, _, 1, [_, FullCS]),
    subsetCards(CS, FullCS), !.

cardsSetIsDobble([Elements, CS]):-
    numECardsSet([_,CS], NumE),
    N is NumE - 1,
    isPrime(N),
    elementsAppearancesCondition(Elements, CS, NumE).
    maxOneCommonElementAll(CS).

cardsSetNthCard([_,CS],N,C):-cardsSetNthCard(CS, N, C), !.
cardsSetNthCard([C | _], 0, C):-!.
cardsSetNthCard([_ | CS], N, C):-
    NewN is N - 1, 
    cardsSetNthCard(CS, NewN, C).

cardsSetFindTotalCards(C, TotalCards):- 
    numECardsSet([_, [C]], NumE), 
    totalCardsNumE(NumE, TotalCards).

cardsSetMissingCards([Elements, CSin], [Elements, CSout]):-
    numECardsSet([_, CSin], NumE),
    cardsSet(Elements, NumE, _, 1, [_, FullCS]),
    subtractCards(FullCS, CSin, CSout), !.

cardsSetMissingCards([Elements, CSin], [Elements, CSout]):-
    numECardsSet([_, CSin], NumE),
    totalCardsNumE(NumE, TotalCards), 
    cardsLength(CSin, R), 
    MaxC is TotalCards - R,
    elementsAppearancesList(Elements, CSin, NaEs),
    cardsSetAux(Elements, NaEs, NumE, MaxC, CSin, FullCS), 
    subtract(FullCS, CSin, CSout).

cardsSetToString([_, CS], String):-cardsToString(CS, 1, String).

dobbleGame(NumP, CS, Mode, Seed, [GsI, [[], MixedCS], 'esperando cartas en mesa', Mode, Seed]):- 
    mode(Mode),
    initGamersInfo(NumP, GsI), 
    N is NumP * Seed // 2 + 1234,
    randomN(N, Rn),
    Max is 31 * NumP,
    maxN(Rn, Max, X),
    mixCardsSetXtimes(CS, X, MixedCS).

dobbleGameRegister(User, [GsI_in, GArea, Status, Mode, Seed], [GsI_out, GArea, Status, Mode, Seed]):- 
    not(var(GsI_in)), 
    totalRegisteredGamers(GsI_in, T), 
    maxPlayersToRegist(GsI_in, MaxP), T \= MaxP, 
    newGamer(User, GsI_in, GsI_out), !.
dobbleGameRegister(User, [GsI_in, GArea, Status, Mode, Seed], [GsI_out, GArea, Status, Mode, Seed]):- 
    var(GsI_in), 
    newGamer(User, GsI_in, GsI_out).

dobbleGameWhoseTurnIsIt([GsI, _, _, _, _], UserName):- getGamerTurn(GsI, UserName).

% dobbleGamePlay([GsI, GArea, Status, Mode, Seed], Action, GameOut).

dobbleGamePlay([GsI, GArea, 'esperando cartas en mesa', Mode, Seed], null, [GsI, NewGArea, 'cartas en mesa', Mode, Seed]):-modeSetCardsInPlay(GArea, Mode, NewGArea), !.
dobbleGamePlay([GsI, GArea, 'esperando cartas en mesa', Mode, Seed], null, [GsI, GArea, 'terminado', Mode, Seed]).
dobbleGamePlay([GsI, GArea, 'cartas en mesa', Mode, Seed], [spotIt, null, Element], [GsI, GArea, NewStatus, Mode, Seed]):-spotIt(Element, GArea, NewStatus), !.
dobbleGamePlay([GsI, GArea, 'cartas en mesa', Mode, Seed], [spotIt, User, Element], [NewGsI, GArea, NewStatus, Mode, Seed]):-spotIt(Element, GArea, NewStatus), setGamerTurn(User, GsI, NewGsI).
dobbleGamePlay([GsI, GArea, 'spotIt', Mode, Seed], [pass], [NewGsI, NewGArea, 'esperando cartas en mesa', Mode, Seed]):-
    withdrawCardsInPlay(GArea, NewGArea), 
    cardsInPlayLength(GArea, Score), 
    addScore(Score, GsI, GsI2), 
    nextTurn(GsI2, NewGsI), !.
dobbleGamePlay([GsI, GArea, 'notSpotIt', Mode, Seed], [pass], [NewGsI, NewGArea, 'esperando cartas en mesa', Mode, Seed]):-getBackCardsInPlay(GArea, NewGArea), nextTurn(GsI, NewGsI).
dobbleGamePlay([GsI, GArea, _, Mode, Seed], [finish], [GsI, GArea, 'terminado', Mode, Seed]).

dobbleGameStatus([_, _, Status | _], Status).

dobbleGameScore([GsI | _], UserName, Score):- not(var(Score)), getGamerScore(UserName, GsI, Score).

dobbleGameToString([GsI, _, 'terminado', Mode, _], String):- 
    gamersInfoToString(GsI, GsIStr), 
    winnersLosersToString(GsI, WLS), 
    atomics_to_string(['Estado del juego: Terminado', '\nModo de juego: ', Mode, '\n----', WLS, '\n----\n', GsIStr], '', String), !.
dobbleGameToString([GsI, [CsP, _], 'cartas en mesa', Mode, _], String):-
    gamersInfoToString(GsI, GsIStr), 
    cardsToString(CsP, 1, CsPStr), 
    atomics_to_string(['Estado del juego: Cartas en mesa', '\nModo de juego: ', Mode, '\n---\nCartas en juego:\n\n', CsPStr, '---\n', GsIStr], '', String), !.
dobbleGameToString([GsI, _, Status, Mode, _], String):-
    gamersInfoToString(GsI, GsIStr), 
    atomics_to_string(['Estado del juego: ', Status, '\nModo de juego: ', Mode, '\n', GsIStr], '', String), !.
