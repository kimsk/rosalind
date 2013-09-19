import System.IO
import System.Environment
import Text.Printf
import Roselib.FASTA
import Data.List

gcContent :: String -> Double
gcContent dna =
    100.0 * (fromIntegral . length $ (filter (\ch -> (ch == 'C') || (ch == 'G')) dna)) /
        (fromIntegral . length $ dna)

maxGCContent :: [FASTAInfo] -> FASTAInfo
maxGCContent fastas =
    maximumBy compareGCContent fastas
        where
            compareGCContent (FASTA _ f1) (FASTA _ f2) =
                compare (gcContent f1) (gcContent f2)

main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  let FASTA nmax fmax = maxGCContent . parseFASTA $ (lines fileLines) in
    printf "%s\n%-10.6f\n" nmax (gcContent fmax)
