:- module(tda_gameArea, [spotIt/3, withdrawCardsInPlay/2, getBackCardsInPlay/2, cardsInPlayLength/2, modeSetCardsInPlay/3]).
:- ['TDA_cardsSet.pl'].
:- use_module(tda_cardsSet).
/*
Predicados
    spotIt(Element, GameArea, String)
        elementAppearances(Element, Cards, Total)
    withdrawCardsInPlay(GameAreaIn, GameAreaOut)
    getBackCardsInPlay(GameAreaIn, GameAreOut)
        union(Cards, Cards)
    cardsInPlayLength(GameArea, Length)
        cardsLength(Cards, Length)
    modeSetCardsInPlay(GameAreaIn, String, GameAreaOut)
        firstCard(CardsSet, Card)
        nextCards(CardsSetIn, CardsSetOut)
        addCard(CardsSetIn, Card, CardsSetOut)}

Metas
    Principales:
        spotIt
        withdrawCardsInPlay
        getBackCardsInPlay
        cardsInPlayLength
        modeSetCardsInPlay
    Secundarias:
        elementAppearances
        union
        cardsLength
        firstCard
        nextCards
        addCard
*/

%Clausulas
%Reglas
spotIt(Element, [CsP, _], 'spotIt'):-elementAppearances(Element, CsP, Total), Total >= 2, !.
%Hechos
spotIt(_, _, 'notSpotIt').

%Hechos
withdrawCardsInPlay([_, CS], [[], CS]).

%Reglas
getBackCardsInPlay([CsP, [Elements, CS]], GA):-union(CS, CsP, CSout), withdrawCardsInPlay([CsP, [Elements, CSout]], GA).

%Reglas
cardsInPlayLength([CsP, _], Length):-cardsLength(CsP, Length).

%Reglas
modeSetCardsInPlay([CsP, CS], 'stack', [NewCsP, NewCS]):-
    firstCard(CS, C1), 
    nextCards(CS, CS2), 
    firstCard(CS2, C2), 
    nextCards(CS2, NewCS), 
    addCard(CsP, C1, CsP2), 
    addCard(CsP2, C2, NewCsP).
