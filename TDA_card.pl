:- module(tda_card, [isInCard/2, card/2, emptyCard/1, firstElement/2, nextElements/2, addElement/3, commonElements/3, oneCommonElement/2, cardLenght/2]).

isInCard(E, [E | _]):-!.
isInCard(E, [_ | NextElem]):-isInCard(E, NextElem).

card(C, C1):- is_list(C), C1 = C.

emptyCard([]).

firstElement([F | _], F).

nextElements([_ | N], N).

addElement(C, E, [E | C]):- not(isInCard(E, C)).

commonElements([], _, 0):-!.
commonElements(_, [], 0):-!.
commonElements([E1 | C1], C2, R):-commonElements(C1, C2, R1), isInCard(E1, C2), R is R1 + 1, !.
commonElements([_ | C1], C2, R):-commonElements(C1, C2, R).

oneCommonElement(C1, C2):- commonElements(C1, C2, R), R = 1.

cardLenght([], 0).
cardLenght([_ | Es], R):- cardLenght(Es, R2), R is R2 + 1.