% Rosalind DNA
% 	Mendel's First Law
% http://rosalind.info/problems/dna/
% Alex Robson
% 9-10-13

-module(mendel).
-export([
	probability/3,
	combinations/2
	]).

probability( K, M, N ) ->
	Dominant = lists:duplicate(K, {a,a}),
	Recessive = lists:duplicate(N, {b,b}),
	Heterozygous = lists:duplicate(M, {b,a}),
	Population = lists:flatten([Dominant, Recessive, Heterozygous]),
	Combinations = combinations(2, Population),
	Permutations = lists:flatten([ get_offspring(X, Y) || [X,Y] <- Combinations ]),
	Total = length(Permutations),
	Count = length([ X || {A,_}=X <- Permutations, A =:= a ]) +
			length([ X || {A,B}=X <- Permutations, A =/= a, B =:= a ]),
	(Count/Total).

permutations(List)  -> [ [get_offspring(A,B)] || A <- List, B <- List--[A], B =/= [] ].

combinations(1, List) -> [[X] || X <-List];
combinations(Count, List) when Count == length(List) -> [List];
combinations(Count, [H|T]) ->
	New = [ [H|Remainder] || Remainder <- combinations(Count-1, T) ],
	New ++ combinations(Count, T).

unique( Original ) -> 
	sets:to_list(
		sets:from_list(Original)
	).

get_offspring( {A1,A2}, {B1,B2} ) -> unique( [ {A1,A2}, {A1,B2}, {B1, A2}, {B1, B2} ] ).