% Edges
edge(a, b, 2).
edge(b, a, 2).
edge(a, c, 3).
edge(c, a, 3).
edge(a, f, 4).
edge(f, a, 4).
edge(b, c, 2).
edge(c, b, 2).
edge(c, d, 3).
edge(d, c, 3).
edge(c, e, 1).
edge(e, c, 1).
edge(d, f, 5).
edge(f, d, 5).

% Public interface: starts with an empty Visited list
find_path(Start, End, Cost, Path) :-
    find_path(Start, End, Cost, Path, []).

% Base case: direct edge from Start to End, and neither has been visited
find_path(Start, End, Cost, [Start, End], Visited) :-
    \+ member(Start, Visited),
    edge(Start, End, Cost),
    \+ member(End, Visited).

% Recursive case: move from Start to some X, then continue from X to End
find_path(Start, End, TotalCost, [Start | TailPath], Visited) :-
    \+ member(Start, Visited),
    edge(Start, X, InitCost),
    \+ member(X, Visited),
    find_path(X, End, RestCost, TailPath, [Start | Visited]),
    TotalCost is InitCost + RestCost.
