import System.IO
import System.Environment
import Text.Printf
import Roselib.RNA
import Data.List

main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  printf "%s\n" (head $ rnaToProteins fileLines)
