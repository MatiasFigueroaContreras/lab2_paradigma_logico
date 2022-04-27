:- use_module(TDA_card).
:- module(TDA_cardsSet, emptyCardSet/1, firstCard/2, nextCards/2, addCard/3, maxOneCommonElementCardsSet/2, elementAppearances/3, totalCardsNumE/2).

emptyCardSet([]).

firstCard([F | _], F).

nextCards([_ | N], N).

addCard(Cset, C, [C | Cset]).


maxOneCommonElementCardsSet(_, []):-!.
maxOneCommonElementCardsSet(C, [C2 | SubCset]):- commonElements(C, C2, R), R =< 1, maxOneCommonElementCardsSet(C, SubCset).

elementAppearances(_, [], 0):-!.
elementAppearances(E, [C1 | SubCset], R):- elementAppearances(E, SubCset, R1), isInCard(E, C1), R is R1 + 1, !.
elementAppearances(E, [_ | SubCset], R):- elementAppearances(E, SubCset, R).

totalCardsNumE(NumE, R):- R is NumE * NumE - NumE + 1.