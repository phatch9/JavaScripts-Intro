% Suspects
suspect(professor_plum).
suspect(mrs_peacock).
suspect(mrs_white).
suspect(miss_scarlet).
suspect(colonel_mustard).
suspect(mr_green).
suspect(wadsworth).

% Victims and their murders: victim(Name, Weapon, Room)
victim(mr_boddy, candlestick, hall).
victim(cook, knife, kitchen).
victim(motorist, wrench, lounge).
victim(police_officer, lead_pipe, library).
victim(yvette, rope, billiards_room).
victim(singing_telegram, revolver, hall).

% Motives
has_motive(professor_plum, mr_boddy).
has_motive(mrs_peacock, mr_boddy).
has_motive(mrs_white, mr_boddy).
has_motive(miss_scarlet, mr_boddy).
has_motive(colonel_mustard, mr_boddy).
has_motive(mr_green, mr_boddy).

% Wadsworth has no motive for Mr. Boddy
has_motive(mrs_peacock, cook).
has_motive(colonel_mustard, motorist).
has_motive(miss_scarlet, police_officer).
has_motive(colonel_mustard, yvette).
has_motive(mrs_white, yvette).
has_motive(professor_plum, singing_telegram).
has_motive(wadsworth, singing_telegram).

% Alibis
has_alibi(mrs_white, mr_boddy).
has_alibi(mr_green, _).
has_alibi(miss_scarlet, Victim) :-
victim(Victim, revolver, Room),
victim(_, revolver, Room).

% Weapon 
cannot_use(colonel_mustard, rope).
cannot_use(professor_plum, revolver).
do_not_use(mrs_peacock, candlestick).

% Location
not_in_room(professor_plum, kitchen).
not_in_room(miss_scarlet, billiards_room).
not_in_room(colonel_mustard, hall).

% Can a suspect kill a victim?
possible_killer(Suspect, Victim) :-
    suspect(Suspect),
    victim(Victim, Weapon, Room),
    \+ has_alibi(Suspect, Victim),
    \+ (Weapon = rope, cannot_use(Suspect, rope)),
    \+ (Weapon = revolver, cannot_use(Suspect, revolver)),
    \+ (Weapon = candlestick, do_not_use(Suspect, candlestick)),
    \+ not_in_room(Suspect, Room),
    has_motive(Suspect, Victim).

% Main solver
solve :-
    Victims = [mr_boddy, cook, motorist, police_officer, yvette, singing_telegram],
    findall(Suspect, suspect(Suspect), Suspects),
    assign_killers(Victims, Suspects, []).

assign_killers([], _, Acc) :-
    reverse(Acc, Results),
    print_results(Results).

assign_killers([Victim | Rest], Suspects, Acc) :-
    possible_killer(Suspect, Victim),
    \+ memberchk((_, Suspect), Acc),
    assign_killers(Rest, Suspects, [(Victim, Suspect) | Acc]).

print_results([]).
print_results([(Victim, Suspect) | T]) :-
    format('~w killed by ~w.~n', [Victim, Suspect]),
    print_results(T).
    
===========================
% run test Prolog 
% @Random-MacPro Prolog % swipl    

Welcome to SWI-Prolog (threaded, 64 bits, version 9.2.9)
SWI-Prolog comes with ABSOLUTELY NO WARRANTY. This is free software.
Please run ?- license. for legal details.

For online help and background, visit https://www.swi-prolog.org
For built-in help, use ?- help(Topic). or ?- apropos(Word).

?- [murder_mystery].
true.

?- solve.

% output
mr_boddy killed by professor_plum.
cook killed by mrs_peacock.
motorist killed by colonel_mustard.
police_officer killed by miss_scarlet.
yvette killed by mrs_white.
singing_telegram killed by wadsworth.
true

===========================
Other Solution:
===========================
% Suspects
suspect(professor_plum).
suspect(mrs_peacock).
suspect(mrs_white).
suspect(miss_scarlet).
suspect(colonel_mustard).
suspect(mr_green).
suspect(wadsworth).

% Victims: victim(Name, Weapon, Room)
victim(mr_boddy, candlestick, hall).
victim(cook, knife, kitchen).
victim(motorist, wrench, lounge).
victim(police_officer, lead_pipe, library).
victim(yvette, rope, billiards_room).
victim(singing_telegram, revolver, hall).

% Motives
% Everyone except Wadsworth had motive to kill Mr. Boddy
has_motive(S, mr_boddy) :- suspect(S), S \= wadsworth.

has_motive(mrs_peacock, cook).
has_motive(colonel_mustard, motorist).
has_motive(miss_scarlet, police_officer).
has_motive(miss_scarlet, yvette).
has_motive(colonel_mustard, yvette).
has_motive(mrs_white, yvette).
has_motive(professor_plum, singing_telegram).
has_motive(wadsworth, singing_telegram).

% Mr. Green has an alibi for all murders → no motive needed
has_motive(mr_green, _) :- false.

% Alibis
has_alibi(mr_green, _).                % Mr. Green has an alibi for every murder
has_alibi(mrs_white, mr_boddy).        % Mrs. White has an alibi for Boddy
has_alibi(miss_scarlet, Victim) :-     % Miss Scarlet has alibi for revolver room victims
    victim(Victim, _, Room),
    victim(_, revolver, Room).

% Room Restrictions

room_banned(professor_plum, kitchen).
room_banned(colonel_mustard, hall).
room_banned(miss_scarlet, billiards_room).

% Weapon Restrictions
weapon_banned(colonel_mustard, rope).
weapon_banned(professor_plum, revolver).
weapon_banned(mrs_peacock, candlestick).

% Murder Logic. Who could commit the murder?
can_commit(Suspect, Victim) :-
    suspect(Suspect),
    victim(Victim, Weapon, Room),
    \+ has_alibi(Suspect, Victim),
    has_motive(Suspect, Victim),
    \+ weapon_banned(Suspect, Weapon),
    \+ room_banned(Suspect, Room).

% Find only one killer per victim using cut (!)
killer(Victim, Suspect) :-
    can_commit(Suspect, Victim), !.


