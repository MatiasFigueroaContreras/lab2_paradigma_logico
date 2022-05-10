:- ['TDA_cardsSet.pl'], ['TDA_gamersInfo.pl'], ['TDA_gameArea.pl'], ['helperFunctions.pl'].
:- use_module(tda_cardsSet), use_module(tda_gamersInfo), use_module(tda_gameArea), use_module(helperFunctions).
/*
Dominios
    Elements, ElementsOut: Lista de atom
    Element: atom
    NumE, MaxC, Seed, R, N, X, T, Max, Largo, Partida, TotalCards, NumP, Score: Entero Positivo
    CS, CSin, CSout: cardsSet
    Card, C: card
    CardsIn, CardsOut: Lista de card/s
    String, Mode, User, Status: String
    Game, GameIn, GameOut: game (o dobbleGame)
    User: Lista de atom/s | null
    NaEs: Lista de enteros (representa la cantidad de elementos)
    GsI, GsI_in, GsI_out: GamersInfo
    GArea, GAreaOut: GameArea
Predicados
    cardsSet(Elements, NumE, MaxC, Seed, CS)
        var(MaxC)
        totalCardsNumE(NumE, R)
        length(Elements, Largo)
        fillList(R, Largo, Partida, Elements, ElementsOut)
        isPrime(N)
        firstCardGeneration(Elements, NumE, Card)
        nCardsGeneration(Elements, NumE, I, MaxC, CardsIn, CardsOut)
        n2CardsGeneration(Elements, NumE, I, J, MaxC, CardsIn, CardsOut)
        randomN(N, R)
        maxN(N, Max, R)
        mixCardsSetXtimes(CSin, X, CSout)
    cardsSetIsDobble(CS) desc.: verifica si un conjunto de cartas, es un conjunto valido del juego dobble
        numECardsSet(CS, NumE)
        subsetCards(CS, CS)
        isPrime(N)
        elementsAppearancesCondition(Elements, CS, NumE)
        maxOneCommonElementAll(CS)
    cardsSetNthCard(CS, N, C) -> desc.: Obtiene la nth carta de un conjunto de cartas
    cardsSetFindTotalCards(C, TotalCards) -> desc.: calcula la cantidad total de cartas que se deben producir para construir un conjunto completo de cartas
    cardsSetMissingCards(CSin, CSout) desc.: Busca las cartas que faltan para que un conjunto de cartas sea completo
        subtractCards(CS, CSin, CSout)
        cardsLength(CSin, R)
        elementsAppearancesList(Elements, CSin, NaEs)
        cardsSetAux(Elements, NaEs, NumE, MaxC, CSin, CSout)
        subtract(CS, CSin, CSout)
    cardsSetToString(CS, String) -> desc.: convierte un conjunto de cartas a una representacion en strings
        cardsToString(CS, Partida, String)
    dobbleGame(NumP, CS, Mode, Seed, Game) -> desc.:Crea un game (tablero de juego con: gamersInfo, gameArea, estatus, modo de juego, semilla para la "aleatorizacion")
        mode(Mode)
        initGamersInfo(NumP, GsI)
    dobbleGameRegister(User, GameIn, GameOut)
        totalRegisteredGamers(GsI, T)
        maxPlayersToRegist(GsI, Max)
        newGamer(User, GsI_in, GsI_out)
    dobbleGameWhoseTurnIsIt(Game, User)
        getGamerTurn(GsI, User)
    dobbleGamePlay(GameIn, Play, GameOut)
        modeSetCardsInPlay(GArea, Mode, GAreaOut)
        spotIt(Element, GArea, Status)
        setGamerTurn(User, GsI, GsI_out)
        withdrawCardsInPlay(GArea, GAreaOut)
        cardsInPlayLength(GArea, Score)
        addScore(Score, GsI, GsI_out)
        getBackCardsInPlay(GArea, GAreaOut)
    dobbleGameStatus(Game, Status)
    dobbleGameScore(Game, User, Score)
    dobbleGameToString(Game, String)
        gamersInfoToString(GsI, String)
        winnersLosersToString(GsI, String)
        atomics_to_string(Elements, String)

Metas
    Principales:
        (todas en este archivo)
        cardsSet
        cardsSetIsDobble
        cardsSetNthCard
        cardsSetNthCard
        cardsSetFindTotalCards
        cardsSetMissingCards
        cardsSetToString
        dobbleGame
        dobbleGameRegister
        dobbleGameWhoseTurnIsIt
        dobbleGamePlay
        dobbleGameStatus
        dobbleGameScore
        dobbleGameToString
    Secundarias:
        var             -> Prolog
        totalCardsNumE  -> helperFunctions.pl 
        length          -> Prolog
        fillList        -> helperFunctions.pl
        isPrime         -> helperFunctions.pl 
        firstCardGeneration  -> TDA_cardsSet.pl
        nCardsGeneration     -> TDA_cardsSet.pl
        n2CardsGeneration    -> TDA_cardsSet.pl
        randomN            -> helperFunctions.pl
        maxN               -> helperFunctions.pl
        mixCardsSetXtimes    -> TDA_cardsSet.pl
        numECardsSet
        subsetCards         -> TDA_cardsSet.pl
        isPrime             -> helperFunctions.pl 
        elementsAppearancesCondition    -> TDA_cardsSet.pl
        maxOneCommonElementAll          -> TDA_cardsSet.pl
        subtractCards                   -> TDA_cardsSet.pl
        cardsLength                     -> TDA_cardsSet.pl
        elementsAppearancesList         -> TDA_cardsSet.pl
        cardsSetAux                     -> TDA_cardsSet.pl
        subtract            -> Prolog
        cardsToString           -> TDA_cardsSet.pl
        mode        -> helperFunctions.pl
        initGamersInfo          ->TDA_gamersInfo.pl
        totalRegisteredGamers   ->TDA_gamersInfo.pl
        maxPlayersToRegist      ->TDA_gamersInfo.pl
        newGamer                ->TDA_gamersInfo.pl
        getGamerTurn            ->TDA_gamersInfo.pl
        modeSetCardsInPlay      ->TDA_gameArea.pl   
        spotIt                  ->TDA_gameArea.pl  
        withdrawCardsInPlay     ->TDA_gameArea.pl
        cardsInPlayLength       ->TDA_gameArea.pl
        getBackCardsInPlay      ->TDA_gameArea.pl
        setGamerTurn            ->TDA_gamersInfo.pl
        addScore                ->TDA_gamersInfo.pl
        gamersInfoToString      ->TDA_gamersInfo.pl
        winnersLosersToString   ->TDA_gamersInfo.pl
        atomics_to_string   -> Prolog
*/
%Clausulas
%Reglas
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

%Reglas
cardsSetIsDobble([Elements, CS]):-
    numECardsSet([_,CS], NumE),
    length(Elements, RealNumE),
    totalCardsNumE(NumE, RealNumE),
    cardsSet(Elements, NumE, _, 1, [_, FullCS]),
    subsetCards(CS, FullCS), !.

cardsSetIsDobble([Elements, CS]):-
    numECardsSet([_,CS], NumE),
    length(Elements, RealNumE),
    totalCardsNumE(NumE, RealNumE),
    N is NumE - 1,
    isPrime(N),
    elementsAppearancesCondition(Elements, CS, NumE),
    maxOneCommonElementAll(CS).

%Reglas
cardsSetNthCard([_,CS],N,C):-cardsSetNthCard(CS, N, C), !.
cardsSetNthCard([C | _], 0, C):-!.
cardsSetNthCard([_ | CS], N, C):-
    NewN is N - 1, 
    cardsSetNthCard(CS, NewN, C).

%Reglas
cardsSetFindTotalCards(C, TotalCards):- 
    numECardsSet([_, [C]], NumE), 
    totalCardsNumE(NumE, TotalCards), !.

%Reglas
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

%Reglas
cardsSetToString([_, CS], String):-cardsToString(CS, 1, String).

%Reglas
dobbleGame(NumP, CS, Mode, Seed, [GsI, [[], MixedCS], 'esperando cartas en mesa', Mode, Seed]):- 
    mode(Mode),
    initGamersInfo(NumP, GsI), 
    N is NumP * Seed // 2 + 1234,
    randomN(N, Rn),
    Max is 31 * NumP,
    maxN(Rn, Max, X),
    mixCardsSetXtimes(CS, X, MixedCS).

%Reglas
dobbleGameRegister(User, [GsI_in, GArea, Status, Mode, Seed], [GsI_out, GArea, Status, Mode, Seed]):- 
    not(var(GsI_in)), 
    totalRegisteredGamers(GsI_in, T), 
    maxPlayersToRegist(GsI_in, MaxP), 
    T \= MaxP, 
    newGamer(User, GsI_in, GsI_out), !.
dobbleGameRegister(User, [GsI_in, GArea, Status, Mode, Seed], [GsI_out, GArea, Status, Mode, Seed]):- 
    var(GsI_in), 
    newGamer(User, GsI_in, GsI_out).

%Reglas
dobbleGameWhoseTurnIsIt([GsI, _, _, _, _], UserName):- getGamerTurn(GsI, UserName).

%Reglas
dobbleGamePlay([GsI, GArea, 'esperando cartas en mesa', Mode, Seed], null, [GsI, NewGArea, 'cartas en mesa', Mode, Seed]):-modeSetCardsInPlay(GArea, Mode, NewGArea), !.
dobbleGamePlay([GsI, GArea, 'esperando cartas en mesa', Mode, Seed], null, [GsI, GArea, 'terminado', Mode, Seed]).
dobbleGamePlay([GsI, GArea, 'cartas en mesa', Mode, Seed], [spotIt, null, Element], [GsI, GArea, NewStatus, Mode, Seed]):-spotIt(Element, GArea, NewStatus), !.
dobbleGamePlay([GsI, GArea, 'cartas en mesa', Mode, Seed], [spotIt, User, Element], [NewGsI, GArea, NewStatus, Mode, Seed]):-spotIt(Element, GArea, NewStatus), setGamerTurn(User, GsI, NewGsI).
dobbleGamePlay([GsI, GArea, 'spotIt', Mode, Seed], [pass], [NewGsI, NewGArea, 'esperando cartas en mesa', Mode, Seed]):-
    withdrawCardsInPlay(GArea, NewGArea), 
    cardsInPlayLength(GArea, Score), 
    addScore(Score, GsI, GsI2), 
    nextTurn(GsI2, NewGsI), !.
dobbleGamePlay([GsI, GArea, 'notSpotIt', Mode, Seed], [pass], [NewGsI, NewGArea, 'esperando cartas en mesa', Mode, Seed]):-getBackCardsInPlay(GArea, NewGArea), nextTurn(GsI, NewGsI), !.
dobbleGamePlay([GsI, GArea, 'cartas en mesa', Mode, Seed], [pass], [NewGsI, NewGArea, 'esperando cartas en mesa', Mode, Seed]):-getBackCardsInPlay(GArea, NewGArea), nextTurn(GsI, NewGsI).
%Hechos
dobbleGamePlay([GsI, GArea, _, Mode, Seed], [finish], [GsI, GArea, 'terminado', Mode, Seed]).

%Hechos
dobbleGameStatus([_, _, Status | _], Status).

%Reglas
dobbleGameScore([GsI | _], UserName, Score):- var(Score), getGamerScore(UserName, GsI, Score).

%Reglas
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

/*
Ejemplos

cardsSet:
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1).
    cardsSet([], 8, 55, 25883, CS2).
    cardsSet([1,2,3,a,b,c], 4, 234, 32, CS3).

cardsSetIsDobble:
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), cardsSetIsDobble(CS1).
    cardsSet([], 8, 55, 25883, CS2), cardsSetIsDobble(CS2).
    cardsSetIsDobble([[1,2,3,4,5,6,7],[[3,1,2]]]).
    cardsSet([1,2,3,a,b,c], 4, 234, 32, CS3), cardsSetIsDobble(CS3).
    cardsSetIsDobble([[1,2,3,4,5,6,7],[[3,1,2,4]]]).

cardsSetNthCard:
    cardsSet([], 8, 55, 25883, CS2), cardsSetNthCard(CS2, 15, C1).
    cardsSet([1,2,3,a,b,c], 4, 234, 32, CS3), cardsSetNthCard(CS3, 4, C2).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), cardsSetNthCard(CS1, -1, C3).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), cardsSetNthCard(CS1, 0, C4).
    cardsSet([1,2,3,a,b,c], 4, 234, 32, CS3), cardsSetNthCard(CS3, 150, C5).

cardsSetFindTotalCards:
    cardsSet([], 8, 55, 25883, CS2), cardsSetNthCard(CS2, 15, C1), cardsSetFindTotalCards(C1, T1).
    cardsSet([1,2,3,a,b,c], 4, 234, 32, CS3), cardsSetNthCard(CS3, 4, C2), cardsSetFindTotalCards(C2, T2).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), cardsSetNthCard(CS1, 0, C4), cardsSetFindTotalCards(C4, T3).

cardsSetMissingCards:
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), cardsSetMissingCards(CS1, MC1).
    cardsSet([], 8, 55, 25883, CS2), cardsSetMissingCards(CS2, MC2).
    cardsSetMissingCards([[1,2,3,4,5,6,7],[[3,1,2]]], MC3).

cardsSetToString:
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), cardsSetToString(CS1, SCS1).
    cardsSet([], 8, 55, 25883, CS2), cardsSetToString(CS2, SCS2).
    cardsSet([1,2,3,a,b,c], 4, 234, 32, CS3), cardsSetToString(CS3, SCS3).
    cardsSetMissingCards([[1,2,3,4,5,6,7],[[3,1,2]]], MC3), cardsSetToString(MC3, SCS4).

dobbleGame:
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1).
    cardsSet([], 8, 55, 25883, CS2), dobbleGame(6, CS2, 'stack',  123, GM2).
    cardsSet([1,2,3,a,b,c], 4, 234, 32, CS3), dobbleGame(4, CS3, 'stack',  182, GM3).
    cardsSet([1,2,3,a,b,c], 4, 234, 32, CS3), dobbleGame(4, CS3, 'modoNoRegistrado',  182, GM3).

dobbleGameRegister:
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13), dobbleGameRegister("user1", GM13, GM14).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13), dobbleGameRegister("user3", GM13, GM14).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("A", GM1, GM12), dobbleGameRegister("C", GM12, GM13), dobbleGameRegister("B", GM13, GM14), dobbleGameRegister("user4", GM14, GM15).

dobbleGameWhoseTurnIsIt:
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13), dobbleGameWhoseTurnIsIt(GM13, R1).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("A", GM1, GM12), dobbleGameRegister("C", GM12, GM13), dobbleGameRegister("B", GM13, GM14), dobbleGameWhoseTurnIsIt(GM14, R2).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13), dobbleGameRegister("user3", GM13, GM14), dobbleGamePlay(GM14, null, GM15), dobbleGamePlay(GM15, [spotIt, "user2", a], GM16), dobbleGamePlay(GM16, [pass], GM17), dobbleGameWhoseTurnIsIt(GM17, R3).

dobbleGamePlay:
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13), dobbleGameRegister("user3", GM13, GM14), dobbleGamePlay(GM14, null, GM15), dobbleGamePlay(GM15, [spotIt, "user2", a], GM16), dobbleGamePlay(GM16, [pass], GM17).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13), dobbleGameRegister("user3", GM13, GM14), dobbleGamePlay(GM14, null, GM15), dobbleGamePlay(GM15, [spotIt, "user2", d], GM16), dobbleGamePlay(GM16, [pass], GM17).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13), dobbleGameRegister("user3", GM13, GM14), dobbleGamePlay(GM14, null, GM15), dobbleGamePlay(GM15, [spotIt, "user1", a], GM16), dobbleGamePlay(GM16, [pass], GM17), dobbleGamePlay(GM17, null, GM18), dobbleGamePlay(GM18, [spotIt, "user2", d], GM19), dobbleGamePlay(GM19, [pass], GM20), dobbleGamePlay(GM20, [finish], GM21).

dobbleGameStatus:
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameStatus(GM1, St).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13), dobbleGameRegister("user3", GM13, GM14), dobbleGamePlay(GM14, null, GM15), dobbleGamePlay(GM15, [spotIt, "user2", a], GM16), dobbleGameStatus(GM16, St).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13), dobbleGameRegister("user3", GM13, GM14), dobbleGamePlay(GM14, null, GM15), dobbleGamePlay(GM15, [spotIt, "user2", d], GM16), dobbleGameStatus(GM16, St).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13), dobbleGameRegister("user3", GM13, GM14), dobbleGamePlay(GM14, null, GM15), dobbleGameStatus(GM15, St).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13), dobbleGameRegister("user3", GM13, GM14), dobbleGamePlay(GM14, [finish], GM15), dobbleGameStatus(GM15, St).

dobbleGameScore:
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13), dobbleGameRegister("user3", GM13, GM14), dobbleGamePlay(GM14, null, GM15), dobbleGamePlay(GM15, [spotIt, "user1", a], GM16), dobbleGamePlay(GM16, [pass], GM17), dobbleGamePlay(GM17, null, GM18), dobbleGamePlay(GM18, [spotIt, "user2", d], GM19), dobbleGamePlay(GM19, [pass], GM20), dobbleGameScore(GM20, "user2", Score).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13), dobbleGameRegister("user3", GM13, GM14), dobbleGamePlay(GM14, null, GM15), dobbleGamePlay(GM15, [spotIt, "user1", d], GM16), dobbleGamePlay(GM16, [pass], GM17), dobbleGamePlay(GM17, null, GM18), dobbleGamePlay(GM18, [spotIt, "user2", c], GM19), dobbleGamePlay(GM19, [pass], GM20), dobbleGameScore(GM20, "user1", Score).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13), dobbleGameRegister("user3", GM13, GM14), dobbleGamePlay(GM14, null, GM15), dobbleGamePlay(GM15, [spotIt, "user3", d], GM16), dobbleGamePlay(GM16, [pass], GM17), dobbleGamePlay(GM17, null, GM18), dobbleGamePlay(GM18, [spotIt, "user3", c], GM19), dobbleGamePlay(GM19, [pass], GM20), dobbleGameScore(GM20, "user3", Score).

dobbleGameToString:
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13), dobbleGameRegister("user3", GM13, GM14), dobbleGamePlay(GM14, null, GM15), dobbleGameToString(GM15, String).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13), dobbleGameRegister("user3", GM13, GM14), dobbleGamePlay(GM14, null, GM15), dobbleGamePlay(GM15, [spotIt, "user2", d], GM16), dobbleGamePlay(GM16, [pass], GM17), dobbleGameToString(GM17, String).
    cardsSet([a,b,c,d,e,f,g], 3, Max, 14, CS1), dobbleGame(3, CS1, 'stack',  527, GM1), dobbleGameRegister("user1", GM1, GM12), dobbleGameRegister("user2", GM12, GM13), dobbleGameRegister("user3", GM13, GM14), dobbleGamePlay(GM14, null, GM15), dobbleGamePlay(GM15, [spotIt, "user1", d], GM16), dobbleGamePlay(GM16, [pass], GM17), dobbleGamePlay(GM17, null, GM18), dobbleGamePlay(GM18, [spotIt, "user2", d], GM19), dobbleGamePlay(GM19, [pass], GM20), dobbleGamePlay(GM20, [finish], GM21), dobbleGameToString(GM21, String).
    
*/