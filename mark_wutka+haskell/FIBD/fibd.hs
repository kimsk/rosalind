import System.IO
import System.Environment
import Text.Printf
import Data.List

computePopulation m n =
    computePopulation' n 0 ((replicate (m-1) 0) ++ [1])
    
computePopulation' n an bs =
    let bn = an
        an2 = an + (last bs) - (head bs)
    in
        if n == 2 then
            an2 + bn
        else
            computePopulation' (n-1) an2 ((tail bs) ++ [bn])
        
main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  print (let [n,m] = (map read (words fileLines)) in computePopulation m n)
