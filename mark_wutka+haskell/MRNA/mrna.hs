import System.IO
import System.Environment
import Text.Printf
import Data.List
import qualified Data.Map as Map
import qualified Data.Text as T

numTranslations = Map.fromList [ ('F', 2), ('L', 6), ('S', 6), ('Y', 2), ('C', 2), 
    ('W', 1), ('P', 4), ('H', 2), ('Q', 2), ('R', 6), ('I', 3), ('M', 1), ('T', 4), 
    ('N', 2), ('K', 2), ('V', 4), ('A', 4), ('D', 2), ('E', 2), ('G', 4)]

rnaStringCount rna =
    foldl' countChar 3 rna
        where
            countChar n ch = 
                (n * (Map.findWithDefault 0 ch numTranslations)) `rem` 1000000

main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  putStrLn (show . rnaStringCount $ (T.unpack . T.strip . T.pack $ fileLines))
