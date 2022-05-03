:-module(tda_gamersInfo, [initGamersInfo/2, getGamerScore/3, getGamerTurn/2, maxPlayersToRegist/2, totalRegisteredGamers/2, nextTurn/2, newGamer/3, addScore/3, getWinners/2, getLosers/2]).
:-['TDA_gamers.pl'], ['TDA_gamersPoints.pl'].
:-use_module(tda_gamers), use_module(tda_gamersPoints).

initGamersInfo(NumG, [NumG, 1, [], []]).

getGamerScore(Nick, [_,_, Gs, GPs], Score):-gamerPos(Nick, Gs, Pos), nthPoint(GPs, Pos, Score).

getGamerTurn([_, Turn, Gs,_], G):-nthGamer(Gs, Turn, G).

maxPlayersToRegist([MaxP, _, _, _], MaxP).

totalRegisteredGamers([_,_, Gs,_], T):-totalGamers(Gs, T).

nextTurn([NumG, Turn, Gs, GPs], [NumG, 1, Gs, GPs]):- totalGamers(Gs, Turn); totalGamers(Gs, 0).
nextTurn([NumG, Turn, Gs, GPs], [NumG, NewTurn, Gs, GPs]):- NewTurn is Turn + 1.

newGamer(Nick, [NumG, Turn, Gs, GPs], [NumG, Turn, NewGs, NewGPs]):- registerGamer(Nick, Gs, NewGs), NewGs \= Gs, registerNewGamerPoint(GPs, NewGPs).

addScore(ScoreAdd, [NumG, Turn, Gs, GPs], [NumG, Turn, Gs, NewGPs]):- addPoints(Turn, ScoreAdd, GPs, NewGPs).

getWinners([_, _, Gs, GPs], Winners):-maxPoints(GPs, -1, MaxScore), getWinnersAux(MaxScore, Gs, GPs, [], Winners).

getWinnersAux(_, [], [], Gin, Gin):-!.
getWinnersAux(MaxScore, [G | Gs], [MaxScore | GPs], Gin, Gout):-getWinnersAux(MaxScore, Gs, GPs, [G | Gin], Gout), !.
getWinnersAux(MaxScore, [_ | Gs], [_ | GPs], Gin, Gout):-getWinnersAux(MaxScore, Gs, GPs, Gin, Gout), !.

getLosers([_, _, Gs, GPs], Losers):-getWinners([_, _, Gs, GPs], Winners), subtract(Gs, Winners, Losers).
