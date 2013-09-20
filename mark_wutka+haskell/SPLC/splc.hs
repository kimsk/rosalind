import System.IO
import System.Environment
import Text.Printf
import Data.List
import Data.List.Utils
import Roselib.FASTA
import Roselib.RNA
import Roselib.DNA

-- Requires MissingH cabal package for Data.List.Utils.replace function

replaceIntron d i = replace i "" d

main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  let dnas = map (dnaToRna . dna) $ parseFASTA (lines fileLines)
  putStrLn . concat . rnaToProteins $ foldl' replaceIntron (head dnas) (tail dnas)
