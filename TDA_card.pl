isInCard(E, [E | _]).
isInCard(E, [_ | NextElem]):-isInCard(E, NextElem), !.

card(C, C1):- is_list(C), C1 = C.

emptyCard([]).

firstElement([F | _], F).

nextElements([_ | N], N).

addElement(C, E, [E | C]).



isInCardValue(E, C, R):- isInCard(E, C), R is 1.
isInCardValue(E, C, R):- not(isInCard(E, C)), R is 0.

commonElements([], _, 0):-!.
commonElements(_, [], 0):-!.
commonElements(C1, C2, R):- firstElement(C1, E1), nextElements(C1, CSub1), commonElements(CSub1, C2, R1), isInCardValue(E1, C2, R2), R is R1 + R2, !.

oneCommonElement(C1, C2):- commonElements(C1, C2, R), R = 1.
