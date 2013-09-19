import System.IO
import System.Environment
import Text.Printf
import Data.List

readInt :: String -> Int
readInt = read

intToDouble :: Int -> Double
intToDouble = fromIntegral
main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  let [nAA_AA, nAA_Aa, nAA_aa, nAa_Aa, nAa_aa, naa_aa] = map (intToDouble . readInt) (words fileLines)
  printf "%-10.5f\n" (2.0 * (nAA_AA + nAA_Aa + nAA_aa + 0.75 * nAa_Aa + 0.5 * nAa_aa))
