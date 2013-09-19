import System.IO
import System.Environment
import Text.Printf
import Data.List
import Roselib.Combinations

main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  let [k, n] = map read (words fileLines)
  putStrLn (show (at_least_r_in_n n (2 ^ k) 0.25))
