module Roselib.DNA
( complement, reverseComplement, dnaToRna)
where

import Data.List
import qualified Data.Map as Map

complementMap = Map.fromList [ ('A','T'), ('C','G'), ('G','C'), ('T','A') ]

complement :: String -> String
complement dna = map ((Map.!) complementMap) dna

reverseComplement :: String -> String
reverseComplement = reverse . complement

dnaToRna:: String -> String
dnaToRna dna =
  map (\c -> if c == 'T' then 'U' else c) dna
