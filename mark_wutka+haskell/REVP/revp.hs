import System.IO
import System.Environment
import Text.Printf
import Data.List
import Roselib.DNA
import Roselib.FASTA

isRevp p =
    (length p >= 4) && (p == reverseComplement p)

findRevp' _ [] = []
findRevp' n s = 
    concat [map (makePosPair n) (filter isRevp . inits $ take 12 s), findRevp' (n+1) (tail s)]
        where
            makePosPair n s = [n, length s]

findRevp s = findRevp' 1 s
    
main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  let d = dna . head $ parseFASTA (lines fileLines)
  putStr . unlines . map (\i -> unwords $ map show i) $ findRevp d
