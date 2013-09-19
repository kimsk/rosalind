import System.IO
import System.Environment
import Text.Printf
import Data.List

hammingDistance :: String -> String -> Int
hammingDistance s1 s2 =
    length (filter id (zipWith (/=) s1 s2))

main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  let [line1, line2] = lines fileLines in
    printf "%d\n" (hammingDistance line1 line2)
