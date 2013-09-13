module Roselib.RNA
( rnaToProtein )
where

import Data.List
import Data.List.Split
import Data.Map

rnaToProteinMap = fromList [
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

rnaTranslater :: (String,Bool) -> String -> (String,Bool)
rnaTranslater (revAccum, xlating) codon =
    let
        xlated = findWithDefault "Stop" codon rnaToProteinMap
    in
        if (xlating) then
            if xlated == "Stop" then
                (revAccum, False)
            else
                ((head xlated) : revAccum, True)
        else
            if (xlated == "M") then
                ('M':revAccum, True)
            else
                (revAccum, False)

rnaToProtein :: String -> String
rnaToProtein rna = 
    let (revAccum, _) = Data.List.foldl' rnaTranslater ("", False) (chunksOf 3 rna) in
        reverse revAccum