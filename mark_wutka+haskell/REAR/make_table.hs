import System.IO
import Data.List
import qualified Data.Map as Map
import Debug.Trace

-- Constructs a lookup table with a permutation and the number of
-- reversals needed to get from 0123456789 to that permutation.
-- We start with just ("0123456789",0) in the table, then try every
-- reversal on it, and add the resulting permutations with a reversal
-- count of 1. Then we take all the permutations with a reversal count of 1,
-- apply all the reversals on them to generate the ones with a count of 2.
-- We continue this until we look for reversals with a particular count
-- and there aren't any.

doReversal s start length =
    (take start s) ++ (reverse (take length (drop start s))) ++ (drop (start+length) s)

computeReversalsTable reversalTable depth =
    trace ("At depth "++(show depth)++" want to try "++(show $ length reversalsToTry)++" reversals")
    (if length reversalsToTry > 0 then
        computeReversalsTable (foldl' tryReversals reversalTable reversalsToTry) (depth+1)
    else
        reversalTable)
    where
        reversalsToTry = filter (compareReversalDepth depth) $ Map.toList reversalTable
        compareReversalDepth depth (k,v) = depth == v
        tryReversals reversalTable (reversal, revDepth) =
            foldl' tryNewReversal reversalTable [doReversal reversal s l | l <- [2..10], s <- [0..(10-l)]]
        tryNewReversal reversalTable attemptedReversal =
            if not $ Map.member attemptedReversal reversalTable then
                Map.insert attemptedReversal (depth+1) reversalTable
            else
                reversalTable

makeTableLines reversalTable =
    map makeTableLine $ Map.toList reversalTable
    where
        makeTableLine (reversal, depth) = reversal ++ " " ++ (show depth)

main = do
    writeFile "reversal_table.txt" . unlines $ makeTableLines (computeReversalsTable (Map.fromList [ ("0123456789", 0) ]) 0)
