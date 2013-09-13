import System.IO
import System.Environment
import Text.Printf
import Data.List

dominant :: Int -> Int -> Int -> Double
dominant k m n =
    let kd = fromIntegral k
        md = fromIntegral m
        nd = fromIntegral n
        sum = kd + md + nd
        sum1 = sum - 1
        xhomd = (kd / sum) * ((kd-1)/sum1 + md/sum1 + nd/sum1)
        xhetd = (md / sum) * (kd/sum1 + 0.75 * (md-1)/sum1 + 0.5 * nd/sum1)
        xhomr = (nd / sum) * (kd/sum1 + 0.5 * md / sum1)
    in
        xhomd + xhetd + xhomr
        
main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  let [k, m, d] = map read (words fileLines) in
    printf "%-10.5f\n" (dominant k m d)
