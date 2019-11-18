/* dynamics */


:- include('status.pl').


% some dynamic variables
:- dynamic(game_battle/1). game_battle(0).
:- dynamic(game_state/1). game_state(battle).


:- dynamic(player_tokemon_list/1). player_tokemon_list([]).
:- dynamic(player_tokemon_health_list/1). player_tokemon_health_list([]).
:- dynamic(player_tokemon_enhancemnt_list/1). player_tokemon_enhancemnt_list([]).
:- dynamic(player_tokemon_na_mod_list/1). player_tokemon_na_mod_list([]).
:- dynamic(player_tokemon_skill_mod_list/1). player_tokemon_skill_mod_list([]).
:- dynamic(player_tokemon_hp_mod_list/1). player_tokemon_hp_mod_list([]).
:- dynamic(player_tokemon_exp_list/1). player_tokemon_exp_list([]).
:- dynamic(player_tokemon_level_list/1). player_tokemon_level_list([]).

:- dynamic(player_inventory/3).  	player_inventory([], [], []).

:- dynamic(player_battle_tokemon/1).  	player_battle_tokemon(none).
:- dynamic(picked_tokemon_num/1). picked_tokemon_num(0).
:- dynamic(picked_tokemon_health/1). picked_tokemon_health(0).
:- dynamic(picked_tokemon_enhancment/1). picked_tokemon_enhancment([]).
:- dynamic(picked_tokemon_used_skill/1). picked_tokemon_used_skill(0).

:- dynamic(opposing_tokemon/1). opposing_tokemon(none).
:- dynamic(opposing_tokemon_health/1). opposing_tokemon_health(0).
:- dynamic(wild_encountered_tokemon/1). wild_encountered_tokemon(none).
:- dynamic(opposing_tokemon_used_skill/1). opposing_tokemon_used_skill(0).

:- dynamic(enemy_waiting_list/1). enemy_waiting_list([]).
:- dynamic(capturable/1). capturable(none).

:- dynamic(legend_tokemon_list/1). legend_tokemon_list([]).

%player_inventory(Tokemon_List, Tokemon_Health_List, Tokemon_Enhancement_List)

:- multifile(game_state/1).

:- multifile(player_tokemon_list/1).
:- multifile(player_tokemon_health_list/1).
:- multifile(player_tokemon_enhancemnt_list/1).

:- multifile(player_tokemon_na_mod_list/1).
:- multifile(player_tokemon_skill_mod_list/1).
:- multifile(player_tokemon_hp_mod_list/1).
:- multifile(player_tokemon_exp_list/1).
:- multifile(player_tokemon_level_list/1).

:- multifile(player_inventory/3).

:- multifile(player_battle_tokemon/1).  
:- multifile(picked_tokemon_num/1).
:- multifile(picked_tokemon_health/1). 
:- multifile(picked_tokemon_enhancment/1). 
:- multifile(picked_tokemon_used_skill/1). 

:- multifile(opposing_tokemon/1). 
:- multifile(opposing_tokemon_health/1). 
:- multifile(wild_encountered_tokemon/1). 
:- multifile(opposing_tokemon_used_skill/1). 

:- multifile(enemy_waiting_list/1).
:- multifile(capturable/1).

:- multifile(legend_tokemon_list/1).
