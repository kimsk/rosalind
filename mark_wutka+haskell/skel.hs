import System.IO
import System.Environment
import Text.Printf
import Data.List

main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
