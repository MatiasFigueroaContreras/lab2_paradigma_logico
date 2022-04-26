emptyCardSet([]).

firstCard([F | _], F).

nextCards([_ | N], N).

addCard(Cset, C, [C | Cset]).