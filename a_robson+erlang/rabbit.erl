% Rosalind DNA
% 	Rabbits & Recurrence Relations
% http://rosalind.info/problems/dna/
% Alex Robson
% 9-10-13

-module(rabbit).
-export([
		calculate_pairs/2
	]).

calculate_pairs( Months, LitterSize ) -> calculate( Months, LitterSize, 0, 1 ).

calculate( 0, _, LastGen, _ ) -> LastGen;
calculate( Months, LitterSize, LastGen, NextGen ) ->
	Total = LastGen + NextGen,
	New = LastGen*LitterSize,
	io:format( "Last: ~p, Next: ~p, Total: ~p, New: ~p~n", [LastGen, NextGen, Total, New] ),
	calculate( Months-1, LitterSize, Total, New ).