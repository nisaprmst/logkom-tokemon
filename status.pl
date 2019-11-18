:- include('tokemon.pl').
%:- include('dynamics.pl').

/* Tokemon List writers */

/* Basis */
write_tokemon_list(Tokemon_List):-
	Tokemon_List = [], !.

/* Recurrens */
write_tokemon_list(Tokemon_List):-
	[Head|Tail] = Tokemon_List,
	write_tokemon_info(Head), nl,
	write_tokemon_list(Tail).


/* Tokemon info writer */

write_tokemon_info(Tokemon):-

	health(HEALTH, Tokemon),
	tipe(TYPE, Tokemon),

	format("~p~n", [Tokemon]),
	format("Health    : ~p~n", [HEALTH]),
	format("Type      : ~p~n", [TYPE]), nl.


write_inventory([], _, _) :- !.

write_inventory(Tokemon_List, Tokemon_health_list, Tokemon_en_list):-
	%player_tokemon_list(PTL),
	[PTL_H|PTL_T] = Tokemon_List,
	%player_tokemon_health_list(PTHL),
	[PTHL_H|PTHL_T] = Tokemon_health_list,
	%player_tokemon_enhancemnt_list(PTEL),
	%[PTEL_H|PTEL_T] = Tokemon_en_list,
	tipe(TYPE, PTL_H),

	format("~p~n", [PTL_H]),
	format("Health    : ~p~n", [PTHL_H]),
	format("Type      : ~p~n", [TYPE]), nl,

	write_inventory(PTL_T, PTHL_T, []).




