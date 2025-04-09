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

% A suspect can kill a victim
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
