import System.IO
import System.Environment
import Text.Printf
import Data.List
import qualified Data.Set as Set
import qualified Data.Map as Map
import Roselib.FASTA
import Debug.Trace

data StringTreeInfo = StringTree { visited :: Bool, children :: (Map.Map Char StringTreeInfo) } deriving (Show)

makeDNATree (StringTree _ nodes) [] = StringTree False nodes
makeDNATree (StringTree _ nodes) (c:cs) =
    if Map.member c nodes  then
        StringTree False (Map.insert c (makeDNATree (Map.findWithDefault (StringTree False Map.empty) c nodes) cs) nodes)
    else
        StringTree False (Map.insert c (makeDNATree (StringTree False Map.empty) cs) nodes)

overlayString tree [] = tree
overlayString (StringTree _ nodes) (c:cs) =
    if Map.member c nodes then
        StringTree True (Map.insert c (overlayString (Map.findWithDefault (StringTree False Map.empty) c nodes) cs) nodes)
    else
        StringTree True nodes

pruneTree (StringTree _ nodes) =
    StringTree False (Map.map pruneTree (Map.filter visited nodes))
    
overlayDNA tree s =
    pruneTree (foldl' overlayString tree (tails s))

getSubstrings (StringTree _ nodes) =
    if Map.null nodes then [] else
        concat (map makeSubstrings (Map.toList nodes))
            where
                makeSubstrings (ch, tree) =
                    [[ch]] ++ (map (\s -> ch : s) (getSubstrings tree))

longestSubstring subs = maximumBy longestLength subs
    where
        longestLength a b = compare (length a) (length b)

continuousSubsequences = filter (not . null) . concatMap inits . tails

main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  let dataset = parseFASTA (lines fileLines)
  let initialTree = foldl' makeDNATree (StringTree False Map.empty) (continuousSubsequences . dna . head $ dataset)
  let commonSubstrings = foldl' overlayDNA initialTree (map dna (tail dataset))
  putStrLn (longestSubstring (getSubstrings commonSubstrings))
