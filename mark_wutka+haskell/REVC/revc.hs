import System.IO
import System.Environment
import Text.Printf
import Data.List
import Data.Map

complement_map = fromList [ ('A','T'), ('C','G'), ('G','C'), ('T','A') ]

complement :: String -> String
complement dna = Data.List.map ((!) complement_map) dna

main = do
  argv <- getArgs
  inputFile <- openFile (head argv) ReadMode
  line <- hGetLine inputFile
  printf "%s\n" (reverse . complement $ line)
