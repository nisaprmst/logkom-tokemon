:- debug.
:- include('tokemon.pl').

% some dynamic variables
:- dynamic(player_tokemon_list/1). player_tokemon_list([]).
:- dynamic(player_tokemon_health_list/1). player_tokemon_health_list([]).
:- dynamic(player_tokemon_enhancemnt_list/1). player_tokemon_enhancemnt_list([]).

:- dynamic(player_inventory/3).  	player_inventory([player_tokemon_list, player_tokemon_health_list, player_tokemon_enhancemnt_list]).
:- dynamic(player_battle_tokemon/1).  	player_battle_tokemon(none).
:- dynamic(picked_tokemon_num/1). picked_tokemon_num(0).
:- dynamic(picked_tokemon_health/1). picked_tokemon_health(0).
:- dynamic(picked_tokemon_used_skill/1). picked_tokemon_used_skill(0).

:- dynamic(opposing_tokemon/1). opposing_tokemon(none).
:- dynamic(opposing_tokemon_health/1). opposing_tokemon_health(0).
:- dynamic(wild_encountered_tokemon/1). wild_encountered_tokemon(none).
:- dynamic(opposing_tokemon_used_skill/1). opposing_tokemon_used_skill(0).



%player_inventory(Tokemon_List, Tokemon_Health_List, Tokemon_Enhancement_List)

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
    assert(player_battle_tokemon(PTOKEMON)),
    retract(picked_tokemon_health(_)),
    health(PTHEALTH, PTOKEMON),
    format("PHealth    : ~p~n", [PTHEALTH]),
    assert(picked_tokemon_health(PTHEALTH)),
    retract(opposing_tokemon(_)),
    assert(opposing_tokemon(Enemy_tokemon)),
    retract(opposing_tokemon_health(_)),
    health(EHEALTH, Enemy_tokemon),
    format("EHealth    : ~p~n", [EHEALTH]),
    assert(opposing_tokemon_health(EHEALTH)).
    
pick(Tokemon):-
    tokemon_picker(Tokemon, player_inventory, 1).

tokemon_picker(Tokemon, [], N):- %Reached end of Tokemon List
    write("You do not have that Tokemon."), nl, !.

tokemon_picker(Tokemon, Inventory_List, N):- %Head is the picked tokemon
    [Head|Tail] = Inventory_List,
    Tokemon == Head, !,
    retract(picked_tokemon_num(M)),
    assert(picked_tokemon_num(N)),
    wild_encountered_tokemon(Current_Foekemon),
    initalize_battle(Tokemon,Current_Foekemon).

tokemon_picker(Tokemon, Inventory_List, N):- %Head is NOT the picked tokemon
    [Head|Tail] = Inventory_List,
    Tokemon \== Head,
    NeoN is N + 1,
    tokemon_picker(Tokemon, Tail, NeoN).

get_type_modifier(Attacker, Attackee, Modifier):-
    tipe(TAR, Attacker), tipe(TAE, Attackee), lawan(TAR, TAE),!, Modifier is rational(1.5); Modifier is rational(1).

player_attack():-
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
    assert(opposing_tokemon_health(Neo_o_hl)).

player_skill():-
    player_battle_tokemon(PBT),
    opposing_tokemon(OT),
    skill(PBT, PSA),
    format("PSA    : ~p~n", [PSA]),
    %insert enhancment modifier getter here pls

    get_type_modifier(PBT, OT, Type_Mod),
    format("Type Mod    : ~p~n", [Type_Mod]),
    DMG is floor(PSA * Type_Mod),
    format("DMG    : ~p~n", [DMG]),
    opposing_tokemon_health(Old_o_hl),
    Neo_o_hl is (Old_o_hl - DMG),
    format("Neo_o_hl    : ~p~n", [Neo_o_hl]),
    retract(opposing_tokemon_health(_)),
    assert(opposing_tokemon_health(Neo_o_hl)).

check_enemy():-
    opposing_tokemon_health(Enemy_Health),
    Enemy_Health > 0, !,
    random_between(0, 11, Rando),
    Rando > 9, !,
    (opposing_tokemon_used_skill == 0,
        enemy_skill();
        enemy_attack());
    (enemy_attack()).

enemy_attack():-
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
    assert(picked_tokemon_health(Neo_p_hl)).

enemy_skill():-
    player_battle_tokemon(PBT),
    opposing_tokemon(OT),
    skill(OT, OTSA),
    format("OTSA    : ~p~n", [OTSA]),
    %insert enhancment modifier getter here pls

    get_type_modifier(OT, PBT, Type_Mod),
    format("Type Mod    : ~p~n", [Type_Mod]),
    DMG is floor(OTSA * Type_Mod),
    format("DMG    : ~p~n", [DMG]),
    picked_tokemon_health(Old_p_hl),
    Neo_p_hl is (Old_p_hl - DMG),
    format("Neo_p_hl    : ~p~n", [Neo_p_hl]),
    retract(picked_tokemon_health(_)),
    assert(picked_tokemon_health(Neo_p_hl)).
    
