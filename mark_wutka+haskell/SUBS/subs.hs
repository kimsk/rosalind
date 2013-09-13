import System.IO
import System.Environment
import Text.Printf
import Roselib.KMP
import Data.List

main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  let [s,t] = lines fileLines in
    putStrLn . unwords $ map show (substringOffsets t s)
