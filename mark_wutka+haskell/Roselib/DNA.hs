module Roselib.DNA
( complement, reverseComplement, dnaToRna)
where

import Data.List
import Data.Map

complementMap = fromList [ ('A','T'), ('C','G'), ('G','C'), ('T','A') ]

complement :: String -> String
complement dna = Data.List.map ((!) complementMap) dna

reverseComplement :: String -> String
reverseComplement = reverse . complement

dnaToRna:: String -> String
dnaToRna dna =
  map (\c -> if c == 'T' then 'U' else c) dna
