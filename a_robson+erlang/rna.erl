% Rosalind DNA
% 	Translating RNA into Protein
% http://rosalind.info/problems/dna/
% Alex Robson
% 9-10-13

-module(rna).
-export([
		to_protein/1,
		combine_bitstrings/1,
		combine_bitstrings/2
	]).

to_protein( DNA ) when is_list(DNA) -> 
	Proteins = to_protein(list_to_bitstring(DNA), get_table(), []),
	combine_bitstrings(lists:reverse(Proteins)).

to_protein( <<A:8,B:8,C:8,T/bitstring>>, Table, List) -> 
	Key=string:join(io_lib:format("~c~c~c",[A,B,C]),""),
	case dict:find(Key,Table) of
		{ok, stop} -> List;
		error -> 
			X = list_to_bitstring([A]),
			Y = list_to_bitstring([B]),
			Z = list_to_bitstring([C]),
			to_protein(<<Y/bitstring,Z/bitstring,T/bitstring>>, Table, [X|List]);
		{ok, Value} ->
			to_protein(T, Table, [list_to_bitstring(Value)|List])
	end.

combine_bitstrings( X ) -> bitstring_to_list(combine_bitstrings( X, <<>> )).
combine_bitstrings( [], List ) -> List;
combine_bitstrings( [H|T], List ) -> combine_bitstrings(T,<<List/bitstring,H:8/bitstring>>).

get_table() ->
	dict:from_list(
		[{"UUU", "F"} ,{"CUU", "L"}, {"AUU", "I"}, {"GUU", "V"},
		{"UUC", "F"} ,{"CUC", "L"}, {"AUC", "I"}, {"GUC", "V"},
		{"UUA", "L"} ,{"CUA", "L"}, {"AUA", "I"}, {"GUA", "V"},
		{"UUG", "L"} ,{"CUG", "L"}, {"AUG", "M"}, {"GUG", "V"},
		{"UCU", "S"} ,{"CCU", "P"}, {"ACU", "T"}, {"GCU", "A"},
		{"UCC", "S"} ,{"CCC", "P"}, {"ACC", "T"}, {"GCC", "A"},
		{"UCA", "S"} ,{"CCA", "P"}, {"ACA", "T"}, {"GCA", "A"},
		{"UCG", "S"} ,{"CCG", "P"}, {"ACG", "T"}, {"GCG", "A"},
		{"UAU", "Y"} ,{"CAU", "H"}, {"AAU", "N"}, {"GAU", "D"},
		{"UAC", "Y"} ,{"CAC", "H"}, {"AAC", "N"}, {"GAC", "D"},
		{"UAA", stop} ,{"CAA", "Q"}, {"AAA", "K"}, {"GAA", "E"},
		{"UAG", stop} ,{"CAG", "Q"}, {"AAG", "K"}, {"GAG", "E"},
		{"UGU", "C"} ,{"CGU", "R"}, {"AGU", "S"}, {"GGU", "G"},
		{"UGC", "C"} ,{"CGC", "R"}, {"AGC", "S"}, {"GGC", "G"},
		{"UGA", stop} ,{"CGA", "R"}, {"AGA", "R"}, {"GGA", "G"},
		{"UGG", "W"} ,{"CGG", "R"}, {"AGG", "R"}, {"GGG", "G"} ]
	).