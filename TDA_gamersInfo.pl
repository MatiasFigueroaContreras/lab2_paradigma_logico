:-['TDA_gamers.pl'], ['TDA_gamersPoints.pl'].
:-use_module(tda_gamers), use_module(tda_gamersPoints).

initGamersInfo(NumG, [NumG, 1, [], []]).

getGamerScore(Nick, [_,_, Gs, GPs], Score):-gamerPos(Nick, Gs, Pos), nthPoint(GPs, Pos, Score).

getGamerTurn([_, Turn, Gs,_], G):-nthGamer(Gs, Turn, G).

totalRegisteredGamers([_,_, Gs,_], T):-totalGamers(Gs, T).

setNextTurn([NumG, Turn, Gs, GPs], [NumG, 1, Gs, GPs]):- totalGamers(Gs, Turn); totalGamers(Gs, 0).
setNextTurn([NumG, Turn, Gs, GPs], [NumG, NewTurn, Gs, GPs]):- NewTurn is Turn + 1.

setNewGamer(Nick, [NumG, Turn, Gs, GPs], [NumG, Turn, NewGs, NewGPs]):- registerGamer(Nick, Gs, NewGs), registerNewGamerPoint(Nick, GPs, NewGPs).

addScore(ScoreAdd, [NumG, Turn, Gs, GPs], [NumG, Turn, Gs, NewGPs]):- addPoints(Turn, ScoreAdd, GPs, NewGPs).

getWinners([_, _, Gs, GPs], Winners):-maxPoints(GPs, -1, MaxScore), getWinnersAux(MaxScore, Gs, GPs, [], Winners).

getWinnersAux(_, [], [], Gin, Gin):-!.
getWinnersAux(MaxScore, [G | Gs], [MaxScore | GPs], Gin, Gout):-getWinnersAux(MaxScore, Gs, GPs, [G | Gin], Gout), !.
getWinnersAux(MaxScore, [_ | Gs], [_ | GPs], Gin, Gout):-getWinnersAux(MaxScore, Gs, GPs, Gin, Gout), !.

getLosers([_, _, Gs, GPs], Losers):-getWinners([_, _, Gs, GPs], Winners), subtract(Gs, Winners, Losers).
