:-module(tda_gamers, [emptyGamers/1, isGamer/2, registerGamer/3, nthGamer/3, totalGamers/2, gamerPos/3]).

emptyGamers([]).

isGamer(Nick, [Nick | _]):-!.
isGamer(Nick, [_ | Gs]):-isGamer(Nick, Gs), !.

registerGamer(Nick, Gsin, Gsout):-var(Gsout), isGamer(Nick, Gsin), Gsout is Gsin, !.
registerGamer(Nick, Gsin, Gsout):-registerGamerAux(Nick, Gsin, Gsout), !.

registerGamerAux(Nick, [], [Nick]):-!.
registerGamerAux(Nick, [G | Gs1], [G | Gs2]):-registerGamerAux(Nick, Gs1, Gs2).

nthGamer([G | _], 1, G):-!.
nthGamer([_ | Gs], N, G):- NewN is N - 1, nthGamer(Gs, NewN, G).

totalGamers([], 0).
totalGamers([_ | Gs], T):-totalGamers(Gs, SubT),T is SubT + 1.

gamerPos(Nick, [Nick | _], 1):-!.
gamerPos(Nick, [_ | Gs], Pos):-gamerPos(Nick, Gs, SubPos), Pos is SubPos + 1. 