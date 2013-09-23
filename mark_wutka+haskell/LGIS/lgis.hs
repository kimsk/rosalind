import System.IO
import System.Environment
import Text.Printf
import Data.List


compareLengths (y1len,y1) (y2len,y2) = compare y1len y2len

longestSubsequence' compareFunc [] longestChildren = longestChildren
longestSubsequence' compareFunc (x:xs) longestChildren =
    longestSubsequence' compareFunc xs (seq longest (longest:longestChildren))
    where
        longest = maximumBy compareLengths $ (1, [x]) : map (addPrefix x) (filter (canAdd x) longestChildren)
        canAdd x (_, []) = True
        canAdd x (ylen, y:ys) = compareFunc y x
        addPrefix x (ylen,[]) = (1+ylen, [x])
        addPrefix x (ylen,(y:ys)) = (ylen+1, x:y:ys)
        
longestSubsequence compareFunc p = 
    snd $ maximumBy compareLengths longest
    where
        longest = longestSubsequence' compareFunc (reverse p) [(0, [])]

readInt :: String->Int
readInt = read

main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  let inputLines = lines fileLines
  let perm = map (readInt) (words . head $ tail inputLines)
  putStrLn . unwords $ map show (longestSubsequence (>) perm)
  putStrLn . unwords $ map show (longestSubsequence (<) perm)
