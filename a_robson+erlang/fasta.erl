% Rosalind DNA
% 	Computing GC Content / FASTA format
%	Consensus and Profile
% http://rosalind.info/problems/dna/
% Alex Robson
% 9-9-13

-module(fasta).
-export([
	get_highest_GC_content/1,
	consensus_profile/1
	]).

-compile([export_all]).


get_highest_GC_content( Fasta ) ->
	Lines = string:tokens( Fasta, ">" ),
	Contents = get_lines_GC( Lines, [] ),
	{Id, Content} = hd( lists:sort( fun( {_, A}, {_, B} ) -> A > B end, Contents ) ),
	string:join( io_lib:format( "~s~n~f", [Id, Content] ), "").

get_lines_GC( [], LinesByGC ) ->
	LinesByGC;
get_lines_GC( [H|T], LinesByGC ) ->
	Tokens = string:tokens( H, "\n" ),
	Id = hd( Tokens ),
	DNA = string:join( tl( Tokens ), "" ),
	NewLines = [ {Id, dna:get_GC_content(DNA)} | LinesByGC ],
	get_lines_GC( T, NewLines ).

consensus_profile( Fasta ) ->
	Lines = string:tokens( Fasta, ">" ),
	Strings = [ {Id,DNA} || [Id,DNA] <- [ string:tokens(Line, "\n") || Line <- Lines ] ],
	Profiles = build_profile(Strings),
	Profile = collapse_profiles(Profiles),
	String = get_DNA_string(Profile),
	Grid = string:join([String|get_profile_grid(Profile)], "\n").

build_profile( Strings ) -> build_profile( Strings, [] ).
build_profile( [], Profile ) -> Profile;
build_profile( [{_,DNA}|Lines], Profile ) -> build_profile(Lines, [get_counts(DNA)|Profile]).

get_counts( DNA ) -> get_counts( DNA, [] ).
get_counts( [], Counts ) -> lists:reverse(Counts);
get_counts( [$A|DNA], Counts ) -> get_counts(DNA, [[ 1, 0, 0, 0 ]|Counts]);
get_counts( [$C|DNA], Counts ) -> get_counts(DNA, [[ 0, 1, 0, 0 ]|Counts]);
get_counts( [$G|DNA], Counts ) -> get_counts(DNA, [[ 0, 0, 1, 0 ]|Counts]);
get_counts( [$T|DNA], Counts ) -> get_counts(DNA, [[ 0, 0, 0, 1 ]|Counts]).

collapse_profiles( List ) -> collapse_profiles( List, [], [], [] ).

collapse_profiles( [[]|_], _, [], Collapsed ) -> lists:reverse(Collapsed);
collapse_profiles( [], TupleList, Remainders, Collapsed ) -> 
	collapse_profiles( Remainders, [], [], [collapse_counts(TupleList)|Collapsed] );
collapse_profiles( [[Count|Remainder]|T], TupleList, Remainders, Collapsed ) ->
	collapse_profiles( T, [Count|TupleList], [Remainder|Remainders], Collapsed).

collapse_counts( Counts ) -> collapse_counts( Counts, 0, [], [] ).

collapse_counts( [[]|_], _, [], Totals ) -> lists:reverse(Totals);
collapse_counts( [], Acc, Remaining, Totals ) -> collapse_counts(Remaining, 0, [], [Acc|Totals]);
collapse_counts( [[H|T]|Counts], Acc, Remaining, Totals ) ->
	collapse_counts( Counts, Acc+H, [T|Remaining], Totals ).

get_profile_grid( Profile ) -> get_profile_grid( Profile, [], [], ["A:","C:","G:","T:"], [] ).

get_profile_grid( [[]|_], _, [], [], Lines ) -> lists:reverse(Lines);
get_profile_grid( [], List, Remaining, [Letter|Letters], Lines ) -> 
	Line = [Letter|lists:reverse(lists:map(fun erlang:integer_to_list/1, List))],
	get_profile_grid(lists:reverse(Remaining), [], [], Letters, [string:join(Line," ")|Lines]);
get_profile_grid( [[H|T]|Counts], List, Remaining, Letters, Lines ) -> 
	get_profile_grid( Counts, [H|List], [T|Remaining], Letters, Lines ).

get_DNA_string( List ) -> get_DNA_string(List, []).

get_DNA_string( [], DNA ) -> string:join(lists:reverse(DNA),"");
get_DNA_string( [H|T], DNA ) ->
	{_,N} = lists:last(lists:keysort(1,lists:zip(H,["A","C","G","T"]))),
	get_DNA_string(T, [N|DNA]).
