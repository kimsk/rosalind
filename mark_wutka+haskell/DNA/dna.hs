import System.IO
import Text.Printf
import Data.Map

get_dna_counts :: String -> (Int, Int, Int, Int)
get_dna_counts dna =
  let counts = fromListWith (+) [(c, 1) | c <- dna] in
  (counts ! 'A', counts ! 'C', counts ! 'G', counts ! 'T')
           
main = do
  dna <- hGetLine stdin
  let (a_count, c_count, g_count, t_count) = get_dna_counts dna in
    printf "%d %d %d %d\n" a_count c_count g_count t_count
