import System.IO
import System.Environment
import Text.Printf
import Data.List
import qualified Data.Map as Map
import Roselib.FASTA

makeSuffixTable n dataset =
    Map.fromListWith (++) (map makeSuffixEntry dataset)
        where
            makeSuffixEntry (FASTA name dna) =
                ( take n dna, [ FASTA name dna ] )

getPairs :: Int -> [FASTAInfo] -> [String]
getPairs n dataset =
    concatMap findSuffixes dataset
        where
            findSuffixes (FASTA nm d) =
                map (makeNamePair nm) 
                    (filter (excludeDupNames nm) (Map.findWithDefault [] (makeSuffix d n) suffixTable))
            makeSuffix d n = reverse (take n (reverse d))
            suffixTable = makeSuffixTable n dataset
            makeNamePair name1 (FASTA name2 _) = name1 ++ " " ++ name2
            excludeDupNames name1 (FASTA name2 _) = name1 /= name2

main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  let dataset = parseFASTA (lines fileLines)
  putStrLn (unlines (getPairs 3 dataset))
    
