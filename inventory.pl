/*Inventory*/
:- include("tokemon.pl"). 
%:- include("dynamics.pl").


add_to_back_of_list([], TK, [TK]) :- !.
	/* Basis */

add_to_back_of_list([Head|Tail], TK, [Head|Tail2]) :- add_to_back_of_list(Tail, TK, Tail2).
	/* Recurrens */
	
list_count([], X) :- X is 0, !.
	/* Basis */

list_count([_|TAIL], X) :- list_count(TAIL, Y), X is Y + 1.
	/* Recurrens */

inv_full(Inventory) :- list_count(Inventory, X), !, X > 5.

delTokemon([], _, []) :- !.
	/* Del object from list : basis */

delTokemon([A|B], C, B) :- C == A, !.
	/* Del object from list : recursive - found */

delTokemon([A|B], C, [A|D]) :- C \== A, delTokemon(B, C, D).
	/* Del object from list : recursive - not found */

del_list_num([A|B], N, I, [A|BB]) :- I \== N, J is I + 1, del_list_num(B, N, J, BB).
	/* Del idx N from a list , not found and continuing */

del_list_num([_|B], N, I, B) :- I == N, !.
	/* Del idx N from a list , found and stopping */

del_list_num([], _, _, []) :- !.
	/* Del idx N from a list , not found*/

get_item_num([], _, _, none) :- !.
get_item_num([H|_], N, I, H) :- I == N.
get_item_num([_|T], N, I, X) :- I \= N, J is I + 1, get_item_num(T, N, J, X).


/* replaces the info of idx N in list to R*/
replace(_, _, _, [], []).
replace(N, I, R, [_|T], [R|T2]) :- I == N, replace(N, 999, R, T, T2).
replace(N, I, R, [H|T], [H|T2]) :- I \= N, J is I + 1, replace(N, J, R, T, T2).

schTK_num([], _, N) :- N is -96,!.
	%Searches tokemon number in list, not found, returns negatives.

schTK_num([A|_], C, N) :- A == C, N is 1,!.
	%Searches tokemon number in list, found, returns.

schTK_num([_|B], C, N) :- schTK_num(B, C, M), N is M + 1.
	%Searches tokemon number in list, not found, continues searching.

list_writer([]) :- !.
list_writer([A|B]) :- format("~p, ", [A]), list_writer(B).

add_to_inventory(TOKEMON) :-
	tokemon(_,TOKEMON),
	player_tokemon_list(PTL),
	player_tokemon_health_list(PTHL),
	player_tokemon_enhancemnt_list(PTEL),
	append(PTL, [TOKEMON], NEO_PTL),
	%write("NEO PTL : "),
	%list_writer(NEO_PTL),
	retract(player_tokemon_list(_)),
	assertz(player_tokemon_list(NEO_PTL)),
	health(TKHEL, TOKEMON),
	append(PTHL, [TKHEL], NEO_PTHL),
	retract(player_tokemon_health_list(_)),
	assertz(player_tokemon_health_list(NEO_PTHL)),
	append(PTEL, [0, 0, 0, 0, 0], NEO_PTEL),
	%PTEL[na modif, skill modif, health, exp, level]
	retract(player_tokemon_enhancemnt_list(_)),
	assertz(player_tokemon_enhancemnt_list(NEO_PTEL)).

add_to_inventory(TOKEMON) :-
	legendtokemon(_,TOKEMON),
	player_tokemon_list(PTL),
	player_tokemon_health_list(PTHL),
	player_tokemon_enhancemnt_list(PTEL),
	append(PTL, [TOKEMON], NEO_PTL),
	%write("NEO PTL : "),
	%list_writer(NEO_PTL),
	retract(player_tokemon_list(_)),
	assertz(player_tokemon_list(NEO_PTL)),
	health(TKHEL, TOKEMON),
	append(PTHL, [TKHEL], NEO_PTHL),
	retract(player_tokemon_health_list(_)),
	assertz(player_tokemon_health_list(NEO_PTHL)),
	append(PTEL, [0, 0, 0], NEO_PTEL),
	retract(player_tokemon_enhancemnt_list(_)),
	assertz(player_tokemon_enhancemnt_list(NEO_PTEL)).

remove_TK_num_from_inventory(TK_NUM) :-
	player_tokemon_list(PTL),
	player_tokemon_health_list(PTHL),
	player_tokemon_enhancemnt_list(PTEL),
	del_list_num(PTL, TK_NUM, 1, NEO_PTL),
	retract(player_tokemon_list(_)),
	assertz(player_tokemon_list(NEO_PTL)),
	del_list_num(PTHL, TK_NUM, 1, NEO_PTHL),
	retract(player_tokemon_health_list(_)),
	assertz(player_tokemon_health_list(NEO_PTHL)),
	del_list_num(PTEL, TK_NUM, 1, NEO_PTEL),
	retract(player_tokemon_enhancemnt_list(_)),
	assertz(player_tokemon_enhancemnt_list(NEO_PTEL)).

change_modifier(TK_NUM, NA_MODIF, SKILL_MODIF, HEALTH_MODIF, EXP, LEVEL):-
	player_tokemon_enhancemnt_list(PTEL),
	format("TK_NUM IS ~p~n", [TK_NUM]),

	get_item_num(PTEL, TK_NUM, 1, TK_ENHANCE),
	/*get_item_num(TK_ENHANCE, TK_NUM, 1, OLD_NA_MODIF),
	get_item_num(TK_ENHANCE, TK_NUM, 1, OLD_SKILL_MODIF),
	get_item_num(TK_ENHANCE, TK_NUM, 1, OLD_HEALTH_MODIF),
	get_item_num(TK_ENHANCE, TK_NUM, 1, OLD_EXP),
	get_item_num(TK_ENHANCE, TK_NUM, 1, OLD_LEVEL),*/

	[OLD_NA_MODIF|B] = TK_ENHANCE,
	OLD_SKILL_MODIF
	OLD_HEALTH_MODIF
	OLD_EXP
	OLD_LEVEL

	NEO_NA_MODIF = OLD_NA_MODIF + NA_MODIF,
	NEO_SKILL_MODIF = OLD_SKILL_MODIF + SKILL_MODIF,
	NEO_HEALTH_MODIF = OLD_HEALTH_MODIF + HEALTH_MODIF,
	NEO_EXP = OLD_EXP + EXP,
	NEO_LEVEL = OLD_LEVEL + LEVEL,

	replace(1, 1, NEO_NA_MODIF, TK_ENHANCE, TK_ENHANCE_1),
	replace(2, 1, NEO_SKILL_MODIF, TK_ENHANCE_1, TK_ENHANCE_2),
	replace(3, 1, NEO_HEALTH_MODIF, TK_ENHANCE_2, TK_ENHANCE_3),
	replace(4, 1, NEO_EXP, TK_ENHANCE_3, TK_ENHANCE_4),
	replace(5, 1, NEO_LEVEL, TK_ENHANCE_4, TK_ENHANCE_5),
	
	replace(TK_NUM, 1, TK_ENHANCE_5, PTEL, PTEL_NEO),
	retract(player_tokemon_enhancemnt_list(_)),
	assertz(player_tokemon_enhancemnt_list(PTEL_NEO)).
	
	%PTEL[na modif, skill modif, health, exp, level]