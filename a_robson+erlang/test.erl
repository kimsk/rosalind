% Rosalind DNA
% 	Counting DNA Nucleotides
%	Transcribing DNA to RNA
%	Complimenting a Strand of DNA
% http://rosalind.info/problems/dna/
% Alex Robson
% 9-10-13

-module(test).
-compile([export_all]).
-include_lib("eunit/include/eunit.hrl").

dna_count_test() ->
	?assertMatch( 
		"20 12 17 21", 
		dna:count_nucleotides( "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC" )
	).

dna_to_rna_test() ->
	?assertMatch( 
		"GAUGGAACUUGACUACGUAAAUU",
		dna:to_rna( "GATGGAACTTGACTACGTAAATT" )
	).

dna_compliment_test() ->
	?assertMatch( 
		"AAAACCCGGT",
		dna:compliment( "ACCGGGTTTT" )
	).

get_highest_GC_test() ->
	FASTA = ">Rosalind_6404\nCCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCC\nTCCCACTAATAATTCTGAGG\n>Rosalind_5959\nCCATCGGTAGCGCATCCTTAGTCCAATTAAGTCCCTATCCAGGCGCTCCGCCGAAGGTCT\nATATCCATTTGTCAGCAGACACGC\n>Rosalind_0808\nCCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGAC\nTGGGAACCTGCGGGCAGTAGGTGGAAT",
	?assertMatch(
		"Rosalind_0808\n60.919540",
		fasta:get_highest_GC_content( FASTA )
	).

rabbit_test() ->
	?assertMatch( 19, rabbit:calculate_pairs(5, 3) ).

mutation_count_test() ->
	DNA1 = "GAGCCTACTAACGGGAT",
	DNA2 = "CATCGTAATGACGGCCT",
	?assertMatch( 7, dna:count_mutations( DNA1, DNA2 ) ).

mendels_first_law_test() ->
	Probability = mendel:get_dominant_probability(2,2,2),
	?assertMatch( 0.7833333333333333, Probability ).

rna_to_protein_test() ->
	Protein = rna:to_protein("AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA"),
	?assertMatch( "MAMAPRTEINSTRING" ,Protein ).

dna_combing_test() ->
	Locations = dna:find_positions_of( "ATAT", "GATATATGCATATACTT" ),
	?assertMatch( "2 4 10", Locations ).

consensus_profile_test() ->
	FASTA = ">Rosalind_1\nATCCAGCT\n>Rosalind_2\nGGGCAACT\n>Rosalind_3\nATGGATCT\n>Rosalind_4\nAAGCAACC\n>Rosalind_5\nTTGGAACT\n>Rosalind_6\nATGCCATT\n>Rosalind_7\nATGGCACT",
	?assertMatch( 
		"ATGCAACT\nA: 5 1 0 0 5 5 0 0\nC: 0 0 1 4 2 0 6 1\nG: 1 1 6 3 0 1 0 0\nT: 1 5 0 0 0 1 1 6\n", 
		consensus:profile(FASTA)
	).

test() -> eunit:test(test).