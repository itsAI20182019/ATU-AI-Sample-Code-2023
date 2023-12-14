% Example of how to carry out multiple goals in sequence

:- dynamic at/2.
% Goals in terms of going to locations
goals([r117,canteen,r101]).

% Example for executing goals in order usng a search
% assume robot is at location
at(r2d2,c01).

run :-
   goals(Goals),
   at(r2d2,Start),
   carry_out_goal_list(Start,Goals).

% Note bfsc would be satisfied by the stopping condition
% bfsc(Goal,Goal,Cost,Path). Costs are accumulated through connect_to rules
% note the results of the bfcs search are simulated here
% for demonstartion purposes

bfsc(_,r117,12,[c01,all,the,way,to,r117]).
bfsc(_,canteen,4,[r117,all,the,way,to,canteen]).
bfsc(_,r101,10,[canteen,all,the,way,to,r101]).


follow([Start,all,the,way,to,GoalLocationReached]) :-
    format('Travelled from ~w ~w ~w ~w ~w ~w ~n',[Start,all,the,way,to,GoalLocationReached]),
    retract(at(r2d2,Start)),
    assert(at(r2d2,GoalLocationReached)).

% all goals complete
carry_out_goal_list(Location,[]) :-
	format('finished and at location ~w',Location).

carry_out_goal_list(CurrentLocation,[CurrentGoal|T]) :-
		% find the best path
        bfsc(CurrentLocation,CurrentGoal,_,Path),
        follow(Path),
        carry_out_goal_list(CurrentGoal,T).