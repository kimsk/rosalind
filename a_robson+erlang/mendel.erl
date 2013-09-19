% Rosalind DNA
% Mendel's First Law
% http://rosalind.info/problems/dna/
% Alex Robson
% 9-10-13

-module(mendel).
-export([
		get_dominant_probability/3
	]).
-compile([export_all]).

get_dominant_probability( K, M, N ) ->
	Dominant = lists:duplicate(K, {a,a}),
	Recessive = lists:duplicate(N, {b,b}),
	Heterozygous = lists:duplicate(M, {a,b}),
	Population = lists:flatten([Dominant, Recessive, Heterozygous]),
	Combinations = combinations(2, Population),
	{X,Y} = get_probabilities(Combinations, Population),
	X/Y.

combinations( _, [] ) -> [];
combinations( 1, List ) -> [[X] || X <-List];
combinations( Count, List ) when Count == length(List) -> [List];
combinations( Count, [H|T] ) ->
	New = [ [H|Remainder] || Remainder <- combinations(Count-1, T) ],
	Remove = lists:duplicate(count(T, H), H),
	New ++ combinations(Count, T--Remove).

count(List, Item) -> length([ X || X <- List, X =:= Item ]).

get_offspring( [{A1,A2}, {B1,B2}] ) -> [ {A1, B1}, {A1, B2}, {A2, B1}, {A2, B2} ].

get_probabilities( Pairs, Population ) -> get_probabilities( Pairs, Population, [], [] ).

get_probabilities( [], _, Probabilities, _ ) -> 
	lists:foldl( fun({W,X}, {Y,_}) -> {W+Y,X} end, {0,0}, Probabilities );
get_probabilities( [[A,B]=Pair|Pairs], Population, Probabilities, Processed ) ->
	case lists:member( Pair, Processed ) of
		true -> get_probabilities( Pairs, Population, Probabilities, Processed );
		_ ->
			{Y,Z} = get_dominant_probability(Pair),
			NewProbabilities = [ {W*Y, X*Z} || {W,X} <- get_pair_probability( A, B, Population) ],
			get_probabilities( Pairs, Population, Probabilities ++ NewProbabilities, [Pair|Processed])
	end.

get_pair_probability( A, A, Population ) ->
	[ get_selection_probability( [A,A], Population ) ];
get_pair_probability( A, B, Population ) ->
	[ get_selection_probability(P, Population) || P <- [[A,B],[B,A]]].
	
get_selection_probability( [A,B], Population ) ->
	Total = length(Population),
	Count1 = count(Population, A),
	Count2 = count(Population--[A], B),
	{Count1 * Count2, Total*(Total-1)}.

get_dominant_probability( Pair ) -> 
	{length([ {A,B} || {A,B} <- get_offspring( Pair ), A =:= a orelse B =:= a ]), 4}.
