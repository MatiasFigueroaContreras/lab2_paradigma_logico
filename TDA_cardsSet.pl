% :- ensure_loaded(TDA_card).
% :- use_module(TDA_card).
% :- module(TDA_cardsSet, [emptyCardSet/1, firstCard/2, nextCards/2, addCard/3, maxOneCommonElementCardsSet/2, elementAppearances/3, totalCardsNumE/2, cardsSetAux/5, createValidCard/5, length/2]).
% :- module(TDA_cardsSet).
:- module(TDA_card, [isInCard/2, card/2, emptyCard/1, firstElement/2, nextElements/2, addElement/3, commonElements/3, oneCommonElement/2]).
:- ['TDA_card.pl'].

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

cardsSetAux(_, _, 0, CS, CSAux):- CS = CSAux.
cardsSetAux(Es, NumE, MaxC, CS, CSAux):- createValidCard(Es, NumE, CSAux, C, []), length(C, NumE), NewMaxC is MaxC - 1, cardsSetAux(Es, NumE, NewMaxC, CS, [C | CSAux]).

createValidCard(_, NumE, _, C, CAux):- length(CAux, NumE), C = CAux.
createValidCard([E | Es], NumE, CS, C, CAux):-elementAppearances(E, CS, R), R < NumE, maxOneCommonElementCardsSet([E | CAux], CS), createValidCard(Es, NumE, CS, C, [E | CAux]).
createValidCard([_ | Es], NumE, CS, C, CAux):-createValidCard(Es, NumE, CS, C, CAux).
