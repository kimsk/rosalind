import System.IO
import System.Environment
import Text.Printf

recur_count :: Int -> Int -> Int
recur_count n k =
    let recur_count_iter n k f2 f1 =
            if n <= 2 then
                f1
            else
                recur_count_iter (n-1) k f1 (f1 + k * f2)
    in
        recur_count_iter n k 1 1

main = do
  argv <- getArgs
  inputFile <- openFile (head argv) ReadMode
  line <- hGetLine inputFile
  let [n,k] = map read (words line)
  printf "%d\n" (recur_count n k)
