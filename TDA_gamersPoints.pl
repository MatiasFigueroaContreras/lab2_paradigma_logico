:-module(tda_gamersPoints, [emptyGamersPoints/1, registerNewGamerPoint/2, nthPoint/3, maxPoints/3, addPoints/4]).

emptyGamersPoints([]).

registerNewGamerPoint([], [0]):-!.
registerNewGamerPoint([GP | GPs1], [GP | GPs2]):-registerNewGamerPoint(GPs1, GPs2).

nthPoint([GP | _], 1, GP):-!.
nthPoint([_ | GPs], N, GP):- NewN is N - 1, nthPoint(GPs, NewN, GP).

maxPoints([], Max, Max):-!.
maxPoints([GP | GPs], Max, MaxOut):-GP > Max, maxPoints(GPs, GP, MaxOut), !.
maxPoints([_ | GPs], Max, MaxOut):-maxPoints(GPs, Max, MaxOut), !.

addPoints(1, P, [GP | GPs1], [NewGP | GPs1]):-NewGP is GP + P, !.
addPoints(N, P, [GP | GPs1], [GP | GPs2]):- NewN is N - 1, addPoints(NewN, P, GPs1, GPs2).