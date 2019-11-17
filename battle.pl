:- debug.
:- include('tokemon.pl').
:- include('inventory.pl').

% some dynamic variables
:- dynamic(game_state/1). game_state(battle).


:- dynamic(player_tokemon_list/1). player_tokemon_list([]).
:- dynamic(player_tokemon_health_list/1). player_tokemon_health_list([]).
:- dynamic(player_tokemon_enhancemnt_list/1). player_tokemon_enhancemnt_list([]).

:- dynamic(player_inventory/3).  	player_inventory([player_tokemon_list, player_tokemon_health_list, player_tokemon_enhancemnt_list]).

:- dynamic(player_battle_tokemon/1).  	player_battle_tokemon(none).
:- dynamic(picked_tokemon_num/1). picked_tokemon_num(0).
:- dynamic(picked_tokemon_health/1). picked_tokemon_health(0).
:- dynamic(picked_tokemon_enhancment/1). picked_tokemon_enhancment([]).
:- dynamic(picked_tokemon_used_skill/1). picked_tokemon_used_skill(0).

:- dynamic(opposing_tokemon/1). opposing_tokemon.
:- dynamic(opposing_tokemon_health/1). opposing_tokemon_health(0).
:- dynamic(wild_encountered_tokemon/1). wild_encountered_tokemon(none).
:- dynamic(opposing_tokemon_used_skill/1). opposing_tokemon_used_skill(0).

:- dynamic(enemy_waiting_list/1). enemy_waiting_list([]).


%player_inventory(Tokemon_List, Tokemon_Health_List, Tokemon_Enhancement_List)

% These commands are exposed (used by the player in the game).

specialAttack:-
    picked_tokemon_used_skill(PT_skill),
    PT_skill is 0, !,
    player_battle_tokemon(PBT),
    format("~p used its skill!", [PBT]);
    player_skill.

specialAttack:-
    picked_tokemon_used_skill(PT_skill),
    PT_skill \== 0, !,
    player_battle_tokemon(PBT),
    format("~p is too tired to use another skill!", [PBT]).

pick(Tokemon):-
    player_tokemon_list(PTL),
    tokemon_picker(Tokemon, PTL, 1).








encounter_tokemon(Wild_tokemon, Waiting_list):-
    retract(wild_encountered_tokemon(_)),
    retract(enemy_waiting_list(_)),
    assertz(wild_encountered_tokemon(Wild_tokemon)),
    assertz(enemy_waiting_list(Waiting_list)),
    retract(game_state(_)),
    assertz(game_state(encounter)).
    
    


get_tokemon_list_from_inventory(Tokemon_List):-
    player_inventory([TK_List_1|TK_List_2], [HL_List_1|HL_List_2], [EN_List_1|EN_List_2]),
    append([TK_List_1], TK_List_2, Tokemon_List).
    

get_health_list_from_inventory(Health_List):-
    player_inventory([TK_List_1|TK_List_2], [HL_List_1|HL_List_2], [EN_List_1|EN_List_2]),
    append([HL_List_1], HL_List_2, Health_List).

get_enhancement_list_from_inventory(Enhancement_List):-
    player_inventory([TK_List_1|TK_List_2], [HL_List_1|HL_List_2], [EN_List_1|EN_List_2]),
    append([EN_List_1], EN_List_2, Enhancement_List).


initalize_battle(PTOKEMON, Enemy_tokemon):-
    retract(player_battle_tokemon(_)),
    assertz(player_battle_tokemon(PTOKEMON)),
    retract(picked_tokemon_health(_)),
    health(PTHEALTH, PTOKEMON),
    format("PHealth    : ~p~n", [PTHEALTH]),
    assertz(picked_tokemon_health(PTHEALTH)),
    retract(opposing_tokemon(_)),
    write("ROT"),
    assertz(opposing_tokemon(Enemy_tokemon)),
    retract(opposing_tokemon_health(_)),
    health(EHEALTH, Enemy_tokemon),
    format("EHealth    : ~p~n", [EHEALTH]),
    assertz(opposing_tokemon_health(EHEALTH)).
	
			   
												 

tokemon_picker(Tokemon, [], N):- %Reached end of Tokemon List
    write("You do not have that Tokemon."), nl, !.

tokemon_picker(Tokemon, Inventory_List, N):- %Head is the picked tokemon
    [Head|Tail] = Inventory_List,
    Tokemon == Head, !,
    retract(picked_tokemon_num(M)),
    assertz(picked_tokemon_num(N)),
    wild_encountered_tokemon(Current_Foekemon),
    initalize_battle(Tokemon,Current_Foekemon).

tokemon_picker(Tokemon, Inventory_List, N):- %Head is NOT the picked tokemon
    [Head|Tail] = Inventory_List,
    Tokemon \== Head,
    NeoN is N + 1,
    tokemon_picker(Tokemon, Tail, NeoN).

get_type_modifier(Attacker, Attackee, Modifier):-
    tipe(TAR, Attacker), tipe(TAE, Attackee), lawan(TAR, TAE),!, Modifier is rational(1.5); Modifier is rational(1).

player_attack:-
    player_battle_tokemon(PBT),
    opposing_tokemon(OT),
    na(PBT, PNA),
    format("PNA    : ~p~n", [PNA]),
    %insert enhancment modifier getter here pls

    get_type_modifier(PBT, OT, Type_Mod),
    format("Type Mod    : ~p~n", [Type_Mod]),
    DMG is floor(PNA * Type_Mod),
    format("DMG    : ~p~n", [DMG]),
    opposing_tokemon_health(Old_o_hl),
    Neo_o_hl is (Old_o_hl - DMG),
    format("Neo_o_hl    : ~p~n", [Neo_o_hl]),
    retract(opposing_tokemon_health(_)),
    assertz(opposing_tokemon_health(Neo_o_hl)),
    check_enemy.

player_skill:-
    picked_tokemon_used_skill(PTSS),
    PTSS == 0,
    player_battle_tokemon(PBT),
    opposing_tokemon(OT),
    skill(PBT, PSA),
    format("PSA    : ~p~n", [PSA]),
    format("~p used skill!~n", [PBT]),
    %insert enhancment modifier getter here pls

    get_type_modifier(PBT, OT, Type_Mod),
    format("Type Mod    : ~p~n", [Type_Mod]),
    DMG is floor(PSA * Type_Mod),
    format("DMG    : ~p~n", [DMG]),
    opposing_tokemon_health(Old_o_hl),
    Neo_o_hl is (Old_o_hl - DMG),
    format("Neo_o_hl    : ~p~n", [Neo_o_hl]),
    retract(opposing_tokemon_health(_)),
    assertz(opposing_tokemon_health(Neo_o_hl)),
    picked_tokemon_used_skill(_),
    picked_tokemon_used_skill(1),
    check_enemy.

check_enemy:-
    opposing_tokemon_health(Enemy_Health),
    Enemy_Health > 0,
    random_between(0, 11, Rando),
    format("Rando    : ~p~n", [Rando]),
    write("RANDOMISASI"), nl,
    check_enemy_skill(Rando).

check_player_battle_tokemon :-
    picked_tokemon_health(Player_Battle_Health),
    Player_Battle_Health < 1,
    kill_player_tokemon.

check_enemy:-
    opposing_tokemon_health(Enemy_Health),
    Enemy_Health =< 0,
    kill_enemy.

check_enemy_skill(Random_Number):-
    Random_Number > 8,
    opposing_tokemon_used_skill(OTSS),
    OTSS == 0,
    enemy_skill,
    retract(opposing_tokemon_used_skill(_)),
    assertz(opposing_tokemon_used_skill(1)).

check_enemy_skill(Random_Number):-
    enemy_attack.

enemy_attack:-
    player_battle_tokemon(PBT),
    opposing_tokemon(OT),
    na(OT, OTNA),
    format("OTNA    : ~p~n", [OTNA]),
    %insert enhancment modifier getter here pls

    get_type_modifier(OT, PBT, Type_Mod),
    format("Type Mod    : ~p~n", [Type_Mod]),
    DMG is floor(OTNA * Type_Mod),
    format("DMG    : ~p~n", [DMG]),
    picked_tokemon_health(Old_p_hl),
    Neo_p_hl is (Old_p_hl - DMG),
    format("Neo_p_hl    : ~p~n", [Neo_p_hl]),
    retract(picked_tokemon_health(_)),
    assertz(picked_tokemon_health(Neo_p_hl)).

enemy_skill:-
    player_battle_tokemon(PBT),
    opposing_tokemon(OT),
    skill(OT, OTSA),
    format("OTSA    : ~p~n", [OTSA]),
    format("~p used skill!~n", [OT]),
    %insert enhancment modifier getter here pls

    get_type_modifier(OT, PBT, Type_Mod),
    format("Type Mod    : ~p~n", [Type_Mod]),
    DMG is floor(OTSA * Type_Mod),
    format("DMG    : ~p~n", [DMG]),
    picked_tokemon_health(Old_p_hl),
    Neo_p_hl is (Old_p_hl - DMG),
    format("Neo_p_hl    : ~p~n", [Neo_p_hl]),
    retract(picked_tokemon_health(_)),
    assertz(picked_tokemon_health(Neo_p_hl)).
    
kill_enemy:-
    enemy_waiting_list(EWL),
    EWL == [],
    write("YOU WON!"), nl,
    player_wins_battle.

kill_enemy:-
    enemy_waiting_list(EWL),
    EWL,
    [Next_Foekemon|Rest_of_Waiting] is EWL,
    format("~p leaped out of its hiding place after its friend was felled!~n", [Next_Foekemon]),
    enemy_go_to_next_tokemon.

player_wins_battle:-
    write("YOU CUKCKING WON!"), nl.

player_set_battle_tokemon_to_inventory:-
    player_tokemon_health_list(PTHL),
    picked_tokemon_health(PTH),
    picked_tokemon_num(TK_NUM),
    player_tokemon_enhancemnt_list(PTEL),
    replace(TK_NUM, 1, PTH, PTHL, NEO_PTHL),
    retract(player_tokemon_health_list(_)),
    assertz(player_tokemon_health_list(NEO_PTHL)),
    
    replace(TK_NUM, 1, [], PTEL, NEO_PTEL),
    retract(player_tokemon_enhancemnt_list(_)),
    assertz(player_tokemon_enhancemnt_list(NEO_PTEL)).

player_switch_tokemon(NEO_TKMN_NUMBER):-
    player_tokemon_list(PTL),
    player_tokemon_health_list(PTHL),
    player_tokemon_enhancemnt_list(PTEL),

    get_item_num(PTL, NEO_TKMN_NUMBER, 1, PTOKEMON),

    retract(player_battle_tokemon(_)),
    assertz(player_battle_tokemon(PTOKEMON)),

    get_item_num(PTHL, NEO_TKMN_NUMBER, 1, PTHEALTH),
    retract(picked_tokemon_health(_)),
    format("PHealth    : ~p~n", [PTHEALTH]),
    assertz(picked_tokemon_health(PTHEALTH)),

    get_item_num(PTEL, NEO_TKMN_NUMBER, 1, PENHANCEMNT),
    retract(picked_tokemon_enhancment(_)),
    assertz(picked_tokemon_enhancment(PENHANCEMNT)).

enemy_go_to_next_tokemon:-
    enemy_waiting_list(EWL),
    [Head|Tail] is EWL,
    
    retract(opposing_tokemon(_)),
    assertz(opposing_tokemon(Head)),

    health(OTHealth, Head),
    retract(opposing_tokemon_health(_)),
    assertz(opposing_tokemon_health(OTHealth)),

    retract(opposing_tokemon_used_skill(_)),
    assertz(opposing_tokemon_used_skill(0)).

kill_player_tokemon:-
    picked_tokemon_num(TK_NUM),
    remove_TK_num_from_inventory(TK_NUM),
    
    list_count(player_tokemon_list, NUM_OF_TOKEMON_LEFT),
    NUM_OF_TOKEMON_LEFT > 0 -> force_player_pick; player_die.

player_die:-
    retract(opposing_tokemon(_)),
    retract(opposing_tokemon_health(_)),
    retract(opposing_tokemon_used_skill(_)),
    retract(player_battle_tokemon(_)),
    retract(picked_tokemon_health(_)),
    retract(picked_tokemon_enhancment(_)).

force_player_pick:- !.

player_ran:- !.