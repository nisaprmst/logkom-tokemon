:-include('map_move.pl').
%:-include('battle.pl').
%:-include('dynamics.pl').
%:- include('tokemon.pl').
%:- include('inventory.pl').
%:- include('dynamics.pl').

:- dynamic(game_running/1).
game_running(0).

start :-
	nl,nl,
	write('
{___ {______    {____     {__   {__  {________{__       {__    {____     {___     {__
     {__      {__    {__  {__  {__   {__      {_ {__   {___  {__    {__  {_ {__   {__
     {__    {__        {__{__ {__    {__      {__ {__ { {__{__        {__{__ {__  {__
     {__    {__        {__{_ {_      {______  {__  {__  {__{__        {__{__  {__ {__
     {__    {__        {__{__  {__   {__      {__   {_  {__{__        {__{__   {_ {__
     {__      {__     {__ {__   {__  {__      {__       {__  {__     {__ {__    {_ __
     {__        {____     {__     {__{________{__       {__    {____     {__      {__ '),nl,
     
     	write('
                                                                                     
{__        {__    {____     {_______    {__      {_____        
{__        {__  {__    {__  {__    {__  {__      {__   {__     
{__   {_   {__{__        {__{__    {__  {__      {__    {__    
{__  {__   {__{__        {__{_ {__      {__      {__    {__    
{__ {_ {__ {__{__        {__{__  {__    {__      {__    {__ {__
{_ {_    {____  {__     {__ {__    {__  {__      {__   {__     
{__        {__    {____     {__      {__{________{_____     {__ '),nl,

	write('
                                                               
{__ {__         {_       {___ {______{___ {______{__      {________
{_    {__      {_ __          {__         {__    {__      {__      
{_     {__    {_  {__         {__         {__    {__      {__      
{___ {_      {__   {__        {__         {__    {__      {______  
{_     {__  {______ {__       {__         {__    {__      {__      
{_      {_ {__       {__      {__         {__    {__      {__      
{____ {__ {__         {__     {__         {__    {________{________ '),nl,

	write('
                                                                   
  {__ __      {____    {__     {__      {_       {_____    
{__    {__  {__    {__ {__     {__     {_ __     {__   {__ 
 {__      {__       {__{__     {__    {_  {__    {__    {__
   {__    {__       {__{__     {__   {__   {__   {__    {__
      {__ {__       {__{__     {__  {______ {__  {__    {__
{__    {__  {__ {_ {__ {__     {__ {__       {__ {__   {__ 
  {__ __      {__ __     {_____   {__         {__{_____    
                   {_                                       '),nl,nl,
                                                   
						  
	write('Welcome To The Tokemon World : Battle Squad'),nl,nl,nl,
	write('Introduce me! My name is Josh and i am on a big mission here'),nl,
	write('As a Tokemon Keeper,it is my job to protect my Tokemon at all costs.'),nl,
	write('Recently,i have 4 Tokemon,but i just realized that i lost all of my 3 Tokemon at once.'),nl,
	write('I actually knew the threat earlier because of those Legendary Monsters rumours,but i did not believe it'),nl,
	write('Now that my Tokemon has gone,i have to bring back all my Tokemon to my Ball,by going through the Legendary`s'),nl,
	write('Those Legends i heard has the name of harlilimon,infallmon,and judhimon if not mistaken.'),nl,
	write('My quests now is to go to their Headquarters and Territories,and defeat them to return back my Tokemon.'),nl,
	write('Please help me accomplish my mission,because if it fails,i would be captured alive and got killed by those Legends.'),nl,
	write('Goodluck saving me and my Tokemons! I hope i will not end up being a slave of those Prick Legend.'),nl,nl,nl,
	write('Commands: '),nl,
	write('     start. -- Start game'),nl,
	write('     help. -- Show all available commands'),nl,
	write('     quit. -- Quit Game'),nl,
	write('     up. down. left. right. -- Move Player Position'),nl,
	write('     map. -- Open Map'),nl,
	write('     heal. -- Heal your Tokemon (Available only in Gym Center)'),nl,
	write('     status. -- Show player status'),nl,
	write('     save(Filename). -- Save Game'),nl,
	write('     load(Filename). -- Load Game'),nl,nl,nl,
	write('Legends: '),nl,
	write('     X = Treasure / Gate '),nl,
	write('     P = Player '),nl,
	write('     G = Gym Center '),nl,
	retract(game_running(0)),
	assert(game_running(1)),
	restartplayer,
	restarttokemonbattle,
	assert(battletokemon(none)),
	add_to_inventory(dagomon),
	restart_legend_tokemon.

help :-
	/* If the game has not started yet */
	game_running(0),
	write('Please start the game first before using this command.'),nl,nl,!.

help :- 
	/* Rules to show help */
	nl,nl,
	write('Having a trouble finding valid commands? Here is it'),nl,nl,nl,
	write('Commands: '),nl,
	write('     start. -- Start game'),nl,
	write('     help. -- Show all available commands'),nl,
	write('     quit. -- Quit Game'),nl,
	write('     up. down. left. right. -- Move Player Position'),nl,
	write('     map. -- Open Map'),nl,
	write('     heal. -- Heal your Tokemon (Available only in Gym Center)'),nl,
	write('     status. -- Show player status'),nl,
	%write('     save(Filename). -- Save Game'),nl,
	%write('     load(Filename). -- Load Game'),nl,nl,nl,
	write('Legends: '),nl,
	write('     X = Treasure / Gate '),nl,
	write('     P = Player '),nl,
	write('     G = Gym Center '),nl.

map :-
	/* If the game has not started yet */
	game_running(0),
	write('Please start the game first before using this command.'),nl,nl,!.

map :-
	/* If the game has not started yet */
	game_running(1),
	showmap.

status :-
	/* If the game has not started yet */
	game_running(0),
	write('Please start the game first before using this command.'),nl,nl,!.

status:-
	game_running(1),
	write("+====================+"), nl,
	write('|       STATUS       |'), nl,
	write("+====================+"), nl,

	write('+====Your Tokemon====+'), nl,
	%write_tokemon_list(inventory), nl,
	player_tokemon_list(PTL),
	player_tokemon_health_list(PTHL),
	player_tokemon_enhancemnt_list(PTEL),
	write_inventory(PTL, PTHL, PTEL),
	write('+=Roaming Legendaries=+'), nl,
	legend_tokemon_list(RLL),
	write_tokemon_list(RLL), nl.

restartplayer:-
	playerloc(X, Y),
	X is 1,
	Y =\= 10,
	retract(playerloc(X,Y)).
restartplayer:-
	playerloc(X, Y),
	X =\= 1,
	Y is 10,
	retract(playerloc(X,Y)).
restartplayer:-
	playerloc(X, Y),
	X =\= 1,
	Y =\= 10,
	retract(playerloc(X,Y)).
restartplayer:-
	playerloc(X, Y),
	X is 1,
	Y is 10.

restarttokemonbattle:-
	battletokemon(X), retract(battletokemon(X)).

restart_legend_tokemon:-
	retract(legend_tokemon_list(_)),
	append([], [harlilimon], Lgd_tkmn_1),
	append(Lgd_tkmn_1, [infallmon], Lgd_tkmn_2),
	append(Lgd_tkmn_2, [judhimon], Lgd_tkmn_3),
	assertz(legend_tokemon_list(Lgd_tkmn_3)).
	
quit:-
	halt.

exit:-
	halt.