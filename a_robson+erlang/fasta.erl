% Rosalind DNA
% 	Computing GC Content / FASTA format
%	Consensus and Profile
% http://rosalind.info/problems/dna/
% Alex Robson
% 9-9-13

-module(fasta).
-export([
	get_highest_GC_content/1
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
