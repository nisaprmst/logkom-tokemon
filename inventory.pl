/*Inventory*/
%:- include("tokemon.pl").
:- include("dynamics.pl").


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


get_member_list_from_lists(N, I, Lists, Member_List):-
    N == I,
    [Head|_] = Lists,
    Member_List = Head.

get_member_list_from_lists(N, I, Lists, Member_List):-
    N \= I,
    J is (I + 1),
    [_|Tail] = Lists,
    get_member_list_from_lists(N, J, Tail, Member_List).
    %Member_List == R_Member.

get_member_list_from_lists(_, _, [], []):- !.


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

/* Make list of liss */
makeLofLs([], []):-!.
makeLofLs([Head|Tail], [H|HTail]):-
    list_to_set(Head,H), %H is a List 
    makeLofLs(Tail, HTail).
/* */


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

	player_tokemon_na_mod_list(NA_MODL),
	append(NA_MODL, [0], NEO_NA_MODL),
	retract(player_tokemon_na_mod_list(_)),
	assertz(player_tokemon_na_mod_list(NEO_NA_MODL)),

	player_tokemon_skill_mod_list(SKILL_MODL),
	append(SKILL_MODL, [0], NEO_SKILL_MODL),
	retract(player_tokemon_skill_mod_list(_)),
	assertz(player_tokemon_skill_mod_list(NEO_SKILL_MODL)),

	player_tokemon_hp_mod_list(HP_MODL),
	append(HP_MODL, [0], NEO_HP_MODL),
	retract(player_tokemon_hp_mod_list(_)),
	assertz(player_tokemon_hp_mod_list(NEO_HP_MODL)),

	player_tokemon_exp_list(EXP_MODL),
	append(EXP_MODL, [0], NEO_EXP_MODL),
	retract(player_tokemon_exp_list(_)),
	assertz(player_tokemon_exp_list(NEO_EXP_MODL)),

	player_tokemon_level_list(LVL_MODL),
	append(LVL_MODL, [1], NEO_LVL_MODL),
	retract(player_tokemon_level_list(_)),
	assertz(player_tokemon_level_list(NEO_LVL_MODL)),


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

	player_tokemon_na_mod_list(NA_MODL),
	append(NA_MODL, [0], NEO_NA_MODL),
	retract(player_tokemon_na_mod_list(_)),
	assertz(player_tokemon_na_mod_list(NEO_NA_MODL)),

	player_tokemon_skill_mod_list(SKILL_MODL),
	append(SKILL_MODL, [0], NEO_SKILL_MODL),
	retract(player_tokemon_skill_mod_list(_)),
	assertz(player_tokemon_skill_mod_list(NEO_SKILL_MODL)),

	player_tokemon_hp_mod_list(HP_MODL),
	append(HP_MODL, [0], NEO_HP_MODL),
	retract(player_tokemon_hp_mod_list(_)),
	assertz(player_tokemon_hp_mod_list(NEO_HP_MODL)),

	player_tokemon_exp_list(EXP_MODL),
	append(EXP_MODL, [0], NEO_EXP_MODL),
	retract(player_tokemon_exp_list(_)),
	assertz(player_tokemon_exp_list(NEO_EXP_MODL)),

	player_tokemon_level_list(LVL_MODL),
	append(LVL_MODL, [1], NEO_LVL_MODL),
	retract(player_tokemon_level_list(_)),
	assertz(player_tokemon_level_list(NEO_LVL_MODL)),

	append(PTEL, [0,0,0,0,0], NEO_PTEL),
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
	assertz(player_tokemon_enhancemnt_list(NEO_PTEL)),

	player_tokemon_na_mod_list(NA_MODL),
	player_tokemon_skill_mod_list(SKILL_MODL),
	player_tokemon_hp_mod_list(HP_MODL),
	player_tokemon_exp_list(EXP_MODL),
	player_tokemon_level_list(LVL_MODL),

	del_list_num(NA_MODL, TK_NUM, 1, NEO_NA_MODL),
	del_list_num(SKILL_MODL, TK_NUM, 1, NEO_SKILL_MODL),
	del_list_num(HP_MODL, TK_NUM, 1, NEO_HP_MODL),
	del_list_num(EXP_MODL, TK_NUM, 1, NEO_EXP_MODL),
	del_list_num(LVL_MODL, TK_NUM, 1, NEO_LVL_MODL),

	retract(player_tokemon_na_mod_list(_)),
	assertz(player_tokemon_na_mod_list(NEO_NA_MODL)),

	
	retract(player_tokemon_skill_mod_list(_)),
	assertz(player_tokemon_skill_mod_list(NEO_SKILL_MODL)),

	
	retract(player_tokemon_hp_mod_list(_)),
	assertz(player_tokemon_hp_mod_list(NEO_HP_MODL)),

	
	retract(player_tokemon_exp_list(_)),
	assertz(player_tokemon_exp_list(NEO_EXP_MODL)),

	
	retract(player_tokemon_level_list(_)),
	assertz(player_tokemon_level_list(NEO_LVL_MODL)).

change_modifier(TK_NUM, NA_MODIF, SKILL_MODIF, HEALTH_MODIF, EXP, LEVEL):-
	%PTEL[na modif, skill modif, health, exp, level]
	player_tokemon_na_mod_list(NA_MODL),
	player_tokemon_skill_mod_list(SKILL_MODL),
	player_tokemon_hp_mod_list(HP_MODL),
	player_tokemon_exp_list(EXP_MODL),
	player_tokemon_level_list(LVL_MODL),

	get_item_num(NA_MODL, TK_NUM, 1, OLD_NA_MODIF),
	get_item_num(SKILL_MODL, TK_NUM, 1, OLD_SKILL_MODIF),
	get_item_num(HP_MODL, TK_NUM, 1, OLD_HEALTH_MODIF),
	get_item_num(EXP_MODL, TK_NUM, 1, OLD_EXP),
	get_item_num(LVL_MODL, TK_NUM, 1, OLD_LEVEL),

	NEO_NA_MODIF = (OLD_NA_MODIF + NA_MODIF),
	NEO_SKILL_MODIF = (OLD_SKILL_MODIF + SKILL_MODIF),
	NEO_HEALTH_MODIF = (OLD_HEALTH_MODIF + HEALTH_MODIF),
	NEO_EXP = (OLD_EXP + EXP),
	NEO_LEVEL = (OLD_LEVEL + LEVEL),
	
	replace(TK_NUM, 1, NEO_NA_MODIF, NA_MODL, NEO_NA_MODL),
	replace(TK_NUM, 1, NEO_SKILL_MODIF, SKILL_MODL, NEO_SKILL_MODL),
	replace(TK_NUM, 1, NEO_HEALTH_MODIF, HP_MODL, NEO_HP_MODL),
	replace(TK_NUM, 1, NEO_EXP, EXP_MODL, NEO_EXP_MODL),
	replace(TK_NUM, 1, NEO_LEVEL, LVL_MODL, NEO_LVL_MODL),

	retract(player_tokemon_na_mod_list(_)),
	assertz(player_tokemon_na_mod_list(NEO_NA_MODL)),

	
	retract(player_tokemon_skill_mod_list(_)),
	assertz(player_tokemon_skill_mod_list(NEO_SKILL_MODL)),

	
	retract(player_tokemon_hp_mod_list(_)),
	assertz(player_tokemon_hp_mod_list(NEO_HP_MODL)),

	
	retract(player_tokemon_exp_list(_)),
	assertz(player_tokemon_exp_list(NEO_EXP_MODL)),

	
	retract(player_tokemon_level_list(_)),
	assertz(player_tokemon_level_list(NEO_LVL_MODL)).
	
	/*replace(TK_NUM, 1, TK_ENHANCE_5, PTEL, PTEL_NEO),
	retract(player_tokemon_enhancemnt_list(_)),
	assertz(player_tokemon_enhancemnt_list(PTEL_NEO)). */
	
	%PTEL[na modif, skill modif, health, exp, level]