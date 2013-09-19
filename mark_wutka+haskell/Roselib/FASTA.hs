module Roselib.FASTA
( FASTAInfo(..), parseFASTA)
where

import Data.List

data FASTAInfo = FASTA { name :: String, dna :: String }
    deriving (Show)

parseFASTA :: [String] -> [FASTAInfo]
parseFASTA [] = []
parseFASTA (name:strs) =
    let (fastaBlock, fs) = span (\s -> (head s) /= '>') strs
    in
        FASTA (tail name) (concat fastaBlock) : parseFASTA fs
