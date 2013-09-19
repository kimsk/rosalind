import System.IO
import System.Environment
import Text.Printf
import Data.List
import Roselib.FASTA
import qualified Data.Map
import Control.Monad

getCharCounts :: String -> Data.Map.Map Char Int
getCharCounts s = Data.Map.fromListWith (+) [(ch, 1) | ch <- s]

getKeyForMaxElem :: Data.Map.Map Char Int -> Char
getKeyForMaxElem countTable =
    fst (maximumBy compareValues (Data.Map.toList countTable))
        where
            compareValues e1 e2 = compare (snd e1) (snd e2)

getValuesForKey :: Char -> [Data.Map.Map Char Int] -> [Int]
getValuesForKey key profileMatrix =
    map (Data.Map.findWithDefault 0 key) profileMatrix

main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  let dnaSeqs = map dna (parseFASTA $ lines fileLines)
  let profileMatrix = map getCharCounts $ transpose dnaSeqs
  putStrLn (map getKeyForMaxElem profileMatrix)
  putStrLn ("A: " ++ (unwords $ (map show (getValuesForKey 'A' profileMatrix))))
  putStrLn ("C: " ++ (unwords $ (map show (getValuesForKey 'C' profileMatrix))))
  putStrLn ("G: " ++ (unwords $ (map show (getValuesForKey 'G' profileMatrix))))
  putStrLn ("T: " ++ (unwords $ (map show (getValuesForKey 'T' profileMatrix))))
