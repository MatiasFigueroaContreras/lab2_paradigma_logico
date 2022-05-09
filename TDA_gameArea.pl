:- module(tda_gameArea, [spotIt/3, withdrawCardsInPlay/2, getBackCardsInPlay/2, cardsInPlayLength/2, modeSetCardsInPlay/3]).
:- ['TDA_cardsSet.pl'].
:- use_module(tda_cardsSet).

spotIt(Element, [CsP, _], 'spotIt'):-elementAppearances(Element, CsP, Total), Total >= 2, !.
spotIt(_, _, 'notSpotIt').

withdrawCardsInPlay([_, CS], [[], CS]).

getBackCardsInPlay([CsP, CS], GA):-union(CS, CsP, CSout), withdrawCardsInPlay([CsP, CSout], GA).

cardsInPlayLength([CsP, _], Length):-cardsLength(CsP, Length).

modeSetCardsInPlay([CsP, CS], 'stack', [NewCsP, NewCS]):-
    firstCard(CS, C1), 
    nextCards(CS, CS2), 
    firstCard(CS2, C2), 
    nextCards(CS2, NewCS), 
    addCard(CsP, C1, CsP2), 
    addCard(CsP2, C2, NewCsP).
