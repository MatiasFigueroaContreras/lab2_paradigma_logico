:- module(tda_card, [isInCard/2, card/2, emptyCard/1, firstElement/2, nextElements/2, addElement/3, equalsCards/2, commonElements/3, oneCommonElement/2, cardLength/2, cardToString/3]).

isInCard(E, [E | _]):-!.
isInCard(E, [_ | NextElem]):-isInCard(E, NextElem).

card(C, C1):- is_list(C), C1 = C.

emptyCard([]).

firstElement([F | _], F).

nextElements([_ | N], N).

addElement(C, E, [E | C]):- not(isInCard(E, C)).

equalsCards(C1, C2):-commonElements(C1, C2, R), cardLength(C1, R). 

commonElements([], _, 0):-!.
commonElements(_, [], 0):-!.
commonElements([E1 | C1], C2, R):-commonElements(C1, C2, R1), isInCard(E1, C2), R is R1 + 1, !.
commonElements([_ | C1], C2, R):-commonElements(C1, C2, R).

oneCommonElement(C1, C2):- commonElements(C1, C2, R), R = 1.

cardLength([], 0).
cardLength([_ | Es], R):- cardLength(Es, R2), R is R2 + 1.

cardToString(C, I, S):-atomics_to_string(C, ', ', ES), number_string(I, IS), string_concat('card n', IS, CNS), string_concat(CNS, ': ', CNS2), string_concat(CNS2, ES, S).