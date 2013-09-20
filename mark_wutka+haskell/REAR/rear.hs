import System.IO
import System.Environment
import Text.Printf
import Data.List
import Data.List.Split
import qualified Data.Map as Map
import Debug.Trace

-- This solution uses a pre-computed reversal table that contains all
-- permutations of 01234567890 and the number of reversals it takes to
-- get from 0123456789 to that permutation.
--
-- To find the reversals from any arbitrary list of 10 elements to
-- another list of the same elements, we just have to map those elements
-- into 0123456789. Specifically, we create a map from the target
-- elements into 0123456789 using the "from" list, and then apply the
-- map to the elements of the "to" list. This returns the permutation
-- of 0123456789 that we need to look for in the table.

makeReversalTable tableLines =
    Map.fromList $ map (makeTableEntries . words) tableLines
    where
        makeTableEntries [perm,depth] = (perm,depth)

findReversal :: Map.Map String String -> [String] -> String
findReversal reversalTable [fromStr, toStr] =
    (Map.findWithDefault "-1" computeTarget reversalTable)
    where
        from = words fromStr
        to = words toStr
        computeTarget = map getTargetChar to
        getTargetChar ch = Map.findWithDefault '?' ch targetMapping
        targetMapping = Map.fromList (zip from "0123456789")

main = do
  argv <- getArgs
  reversalTableContents <- readFile "reversal_table.txt"
  let reversalTable = makeReversalTable $ lines reversalTableContents
  fileLines <- readFile (head argv)
  putStrLn . unwords $ map (findReversal reversalTable) (chunksOf 2 (filter (not . null) (lines fileLines)))
