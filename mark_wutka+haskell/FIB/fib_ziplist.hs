import System.IO
import System.Environment
import Text.Printf

recur_count k = 1 : 1 : zipWith recurAdd (recur_count k) (tail (recur_count k))
            where recurAdd x y = k * x + y

main = do
  argv <- getArgs
  inputFile <- openFile (head argv) ReadMode
  line <- hGetLine inputFile
  let [n,k] = map read (words line)
  printf "%d\n" ((recur_count k) !! (n-1))