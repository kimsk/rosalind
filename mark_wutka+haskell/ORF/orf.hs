import System.IO
import System.Environment
import Text.Printf
import Data.List
import Roselib.RNA
import Roselib.DNA
import Roselib.FASTA

main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  let dnaSeq = dna . head . parseFASTA $ lines fileLines
  let protSeqs = nub . concat . map rnaToProteins $ concat [tails $ dnaToRna dnaSeq, tails . dnaToRna $ reverseComplement dnaSeq]
  putStr (unlines protSeqs)
