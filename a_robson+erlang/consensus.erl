% Rosalind DNA
%	Consensus and Profile
% http://rosalind.info/problems/dna/
% Alex Robson
% 9-9-13

-module(consensus).
-export([
	profile/1
	]).

-compile([export_all]).

profile( Fasta ) ->
	Lines = string:tokens( Fasta, ">" ),
	Strings = [ {Id,DNA} || [Id,DNA] <- [ string:tokens(Line, "\n") || Line <- Lines ] ],
	Profiles = build_profile(Strings),
	Profile = add_profiles(Profiles),
	String = get_DNA_string(turn(Profile)),
	Grid = get_grid(Profile),
	io:format( "~s~n~s~n", [String, Grid] ),
	string:join(io_lib:format( "~s~n~s~n", [String, Grid]), "").

build_profile( Strings ) -> build_profile( Strings, [] ).
build_profile( [], Profile ) -> Profile;
build_profile( [{_,DNA}|Lines], Profile ) -> build_profile(Lines, [get_counts(DNA)|Profile]).

get_counts( DNA ) -> get_counts( DNA, [] ).
get_counts( [], Counts ) -> turn(lists:reverse(Counts));
get_counts( [$A|DNA], Counts ) -> get_counts(DNA, [[ 1, 0, 0, 0 ]|Counts]);
get_counts( [$C|DNA], Counts ) -> get_counts(DNA, [[ 0, 1, 0, 0 ]|Counts]);
get_counts( [$G|DNA], Counts ) -> get_counts(DNA, [[ 0, 0, 1, 0 ]|Counts]);
get_counts( [$T|DNA], Counts ) -> get_counts(DNA, [[ 0, 0, 0, 1 ]|Counts]).

get_DNA_string( List ) -> get_DNA_string(List, []).

get_DNA_string( [], DNA ) -> string:join(lists:reverse(DNA),"");
get_DNA_string( [H|T], DNA ) ->
	{_,N} = lists:last(lists:keysort(1,lists:zip(H,["A","C","G","T"]))),
	get_DNA_string(T, [N|DNA]).

get_grid( Grid ) -> 
	string:join(
		lists:map( fun(X) -> string:join(X, " ") end,
			lists:zipwith( 
				fun(X,Y) -> [X]++Y end, 
				["A:","C:","G:","T:"],
				lists:map( fun convert_line/1, Grid )
			)
		), "\n"
	).

get_line( Line ) -> string:join(lists:map( fun(X) -> integer_to_list(X) end, Line), " ").

convert_line( Line ) -> lists:map( fun(X) -> integer_to_list(X) end, Line).

turn( Matrix ) -> turn( Matrix, [], [], [] ).
turn( [[]|_], _, [], Lines ) -> lists:reverse(Lines);
turn( [], List, Remaining, Lines ) -> turn( lists:reverse(Remaining), [], [], [lists:reverse(List)|Lines]);
turn( [[H|T]|R], List, Remaining, Lines ) -> turn( R, [H|List], [T|Remaining], Lines ).

add_profiles( Matrices ) -> 
	Blank = lists:duplicate(4, lists:duplicate(length(hd(hd(Matrices))), 0)),
	add_profiles(Matrices, Blank).
add_profiles( [], Cumulative ) -> Cumulative;
add_profiles( [Matrix|Matrices], Cumulative ) -> add_profiles(Matrices, add_matrices(Matrix, Cumulative)).
	
add_line( L1, L2 ) -> lists:zipwith(fun(X,Y) -> X+Y end, L1, L2 ).
add_matrices( M1, M2 ) -> lists:zipwith( fun add_line/2, M1, M2 ).