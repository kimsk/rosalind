import System.IO
import System.Environment
import Text.Printf
import Data.List
import qualified Data.Set as Set
import Roselib.FASTA

-- This is a naive solution that takes all the subsequences generated by
-- continuousSubsequences and inserts them into a set, then does repeated
-- set intersections to find the set of common substrings, at which point
-- it finds the longest member of the set. With a Rosalind data set it took
-- at least 20 minutes to find the solution. 

continuousSubsequences = filter (not . null) . concatMap inits . tails

mergeSubsequences :: Set.Set String -> String -> Set.Set String
mergeSubsequences common d =
    Set.fromList . filter (\s -> Set.member s common) $ continuousSubsequences d

makeSubstringSet :: String -> Set.Set String
makeSubstringSet d = Set.fromList (continuousSubsequences d)

longestSubstring dataset =
    maximumBy compareLengths $ Set.toList (commonSubsequences dataset)
        where
            compareLengths a b = compare (length a) (length b)
            commonSubsequences dataset = foldl' mergeSubsequences (makeSubstringSet . dna $ head dataset) $ map dna (tail dataset)

main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  let dataset = parseFASTA (lines fileLines)
  putStrLn (longestSubstring dataset) 
