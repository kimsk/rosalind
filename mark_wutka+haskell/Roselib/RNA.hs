module Roselib.RNA
( rnaToProteins )
where

import Data.List
import Data.List.Split
import qualified Data.Map as Map

rnaToProteinMap = Map.fromList [
    ("UUU","F"),      ("CUU","L"),      ("AUU","I"),      ("GUU","V"),
    ("UUC","F"),      ("CUC","L"),      ("AUC","I"),      ("GUC","V"),
    ("UUA","L"),      ("CUA","L"),      ("AUA","I"),      ("GUA","V"),
    ("UUG","L"),      ("CUG","L"),      ("AUG","M"),      ("GUG","V"),
    ("UCU","S"),      ("CCU","P"),      ("ACU","T"),      ("GCU","A"),
    ("UCC","S"),      ("CCC","P"),      ("ACC","T"),      ("GCC","A"),
    ("UCA","S"),      ("CCA","P"),      ("ACA","T"),      ("GCA","A"),
    ("UCG","S"),      ("CCG","P"),      ("ACG","T"),      ("GCG","A"),
    ("UAU","Y"),      ("CAU","H"),      ("AAU","N"),      ("GAU","D"),
    ("UAC","Y"),      ("CAC","H"),      ("AAC","N"),      ("GAC","D"),
    ("UAA","Stop"),   ("CAA","Q"),      ("AAA","K"),      ("GAA","E"),
    ("UAG","Stop"),   ("CAG","Q"),      ("AAG","K"),      ("GAG","E"),
    ("UGU","C"),      ("CGU","R"),      ("AGU","S"),      ("GGU","G"),
    ("UGC","C"),      ("CGC","R"),      ("AGC","S"),      ("GGC","G"),
    ("UGA","Stop"),   ("CGA","R"),      ("AGA","R"),      ("GGA","G"),
    ("UGG","W"),      ("CGG","R"),      ("AGG","R"),      ("GGG","G") ]

rnaTranslater :: ([String],String,Bool) -> String -> ([String],String,Bool)
rnaTranslater (revAllAccum, revCurrAccum, xlating) codon =
    let
        xlated = Map.findWithDefault "Stop" codon rnaToProteinMap
    in
        if (xlating) then
            if xlated == "Stop" then
                if not $ null revCurrAccum then
                    ((reverse revCurrAccum) : revAllAccum, [], False)
                else
                    (revAllAccum, [], False)
            else
                (revAllAccum, (head xlated) : revCurrAccum, True)
        else
            if (xlated == "M") then
                (revAllAccum, ['M'], True)
            else
                (revAllAccum, [], False)

rnaToProteins :: String -> [String]
rnaToProteins rna = 
    let (revAccum, _, _) = foldl' rnaTranslater ([], [], False) (filter (\s -> length s == 3) (chunksOf 3 rna)) in
        reverse revAccum
