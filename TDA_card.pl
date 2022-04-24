


isInCard(E, [E | _]).
isInCard(E, [_ | NextElem]):-isInCard(E, NextElem), !.

card(C, C1):- is_list(C), C1 = C.

emptyCard([]).

firstElement([F | _], F).

nextElements([_ | N], N).

addElement(C, E, [E | C]).

