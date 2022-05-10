:- module(tda_card, [isInCard/2, equalsCards/2, commonElements/3, cardLength/2, cardToString/3]).
/*
Predicados
    isInCard(E, Elements)
    equalsCards(Card1, Card2)
    commonElements(Card1, Card2, NumCommonElements)
    cardLength(Card, Length)
    cardToString(Card, Index, String)
        atomics_to_string(List, Divider, String)
        number_string(Number, String)
        string_concat(String1, String2, StringOut)

Metas
    Principales:
        isInCard
        equalsCards
        commonElements
        cardLength
        cardToString
    Secundarias:
        atomics_to_string -> Prolog
        number_string     -> Prolog
        string_concat     -> Prolog
*/

%Clausulas
%Reglas
isInCard(E, [E | _]):-!.
isInCard(E, [_ | NextElem]):-isInCard(E, NextElem).

%Reglas
equalsCards(C1, C2):-commonElements(C1, C2, R), cardLength(C1, R). 

%Reglas
commonElements([], _, 0):-!.
commonElements(_, [], 0):-!.
commonElements([E1 | C1], C2, R):-
    commonElements(C1, C2, R1), 
    isInCard(E1, C2), 
    R is R1 + 1, !.
commonElements([_ | C1], C2, R):-commonElements(C1, C2, R).

%Hechos
cardLength([], 0).
%Reglas
cardLength([_ | Es], R):- cardLength(Es, R2), R is R2 + 1.

%Reglas
cardToString(C, I, S):-
    atomics_to_string(C, ', ', ES), 
    number_string(I, IS), 
    string_concat('card n', IS, CNS), 
    string_concat(CNS, ': ', CNS2), 
    string_concat(CNS2, ES, S).