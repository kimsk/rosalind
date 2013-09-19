import System.IO
import System.Environment
import Text.Printf
import Data.List

dna_to_rna:: String -> String
dna_to_rna dna =
  map (\c -> if c == 'T' then 'U' else c) dna
  
main = do
  argv <- getArgs
  inputFile <- openFile (head argv) ReadMode
  line <- hGetLine inputFile
  printf "%s\n" (dna_to_rna line)
