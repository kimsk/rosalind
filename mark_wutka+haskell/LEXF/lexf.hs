import System.IO
import System.Environment
import Text.Printf
import Data.List

enumerateStrings lexOrder len =
    if len == 0 then 
        [""]
    else
        concat $ map (addLexChar $ enumerateStrings lexOrder (len-1)) lexOrder

    where
        addLexChar suffixes c =
            map (c :) suffixes
main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  let inputLines = lines fileLines
  let lexOrder = map head (words $ head inputLines)
  let lexLen = read . head $ tail inputLines
  putStr . unlines $ enumerateStrings lexOrder lexLen
