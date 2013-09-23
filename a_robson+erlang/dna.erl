% Rosalind DNA
% 	Counting DNA Nucleotides
%	Transcribing DNA to RNA
%	Complimenting a Strand of DNA
%	Combing Through the Haystack
% http://rosalind.info/problems/dna/
% Alex Robson
% 9-8-13

-module(dna).
-export([
	compliment/1,
	count_mutations/2,
	count_nucleotides/1,
	find_positions_of/2,
	get_GC_content/1,
	to_rna/1]).

count_nucleotides( DNAString ) ->
	dna_count( DNAString, {0,0,0,0} ).

dna_count( [], Result ) -> string:join(io_lib:format( "~p~p~p~p", tuple_to_list( Result ) )," ");
dna_count( [$A|DNA], {A,C,G,T} ) -> dna_count(DNA, {A+1,C,G,T});
dna_count( [$C|DNA], {A,C,G,T} ) -> dna_count(DNA, {A,C+1,G,T});
dna_count( [$G|DNA], {A,C,G,T} ) -> dna_count(DNA, {A,C,G+1,T});
dna_count( [$T|DNA], {A,C,G,T} ) -> dna_count(DNA, {A,C,G,T+1}).

to_rna( DNAString ) -> to_rna( DNAString, [] ).
to_rna( [], RNA ) -> string:join( lists:reverse( RNA ), "" );
to_rna( [$T|DNA], RNA ) -> to_rna(DNA, ["U"|RNA]);
to_rna( [X|DNA], RNA ) -> 
	[Char] = io_lib:format("~c",[X]),
	to_rna(DNA, [Char|RNA]).


compliment( DNAString ) -> compliment( DNAString, [] ).
compliment( [], Compliment ) -> string:join( Compliment, "" );
compliment( [$T|DNA], Compliment ) -> compliment(DNA, ["A"|Compliment]);
compliment( [$A|DNA], Compliment ) -> compliment(DNA, ["T"|Compliment]);
compliment( [$C|DNA], Compliment ) -> compliment(DNA, ["G"|Compliment]);
compliment( [$G|DNA], Compliment ) -> compliment(DNA, ["C"|Compliment]).

get_GC_content( DNAString ) -> ( count_GC( DNAString, 0 ) / length( DNAString ) ) * 100.

count_GC( [], Count ) -> Count;
count_GC( [$C|DNA], Count ) -> count_GC(DNA, Count + 1);
count_GC( [$G|DNA], Count ) -> count_GC(DNA, Count + 1);
count_GC( [_|DNA], Count ) -> count_GC(DNA, Count).

count_mutations( DNA1, DNA2 ) ->
	length([ X || {A,B}=X <- lists:zip(DNA1, DNA2), A =/= B ]).

find_positions_of( Sub, DNA ) ->
	Index = string:str( DNA, Sub ),
	List = find(Index, Sub, DNA, 0, [] ),
	string:join( lists:map( fun erlang:integer_to_list/1, lists:reverse( List ) ), " ").

find( 0, _, _, _, List ) -> List;
find( Index, Sub, DNA, Offset, List ) ->
	Remaining = string:sub_string(DNA, Index+1),
	Next = string:str(Remaining, Sub),
	find(Next, Sub, Remaining, Offset+Index, [Index+Offset|List]).


