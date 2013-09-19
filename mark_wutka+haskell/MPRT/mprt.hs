import System.IO
import System.Environment
import Text.Printf
import Data.List
import Network.HTTP
import Network.Browser
import Roselib.FASTA

-- Requires the HTTP package

fetchProtein id = do
    (_,rsp) <- Network.Browser.browse $ do
        setAllowRedirects True
        setErrHandler (const (return ()))
        setOutHandler (const (return ()))
        request $ getRequest ("http://www.uniprot.org/uniprot/"++id++".fasta")
    return (rspBody rsp)

matchesNGly s =
    let s4 = take 4 s in
        if (length s4) == 4 then
            ((s4 !! 0) == 'N') && ((s4 !! 1) /= 'P') && 
            (((s4 !! 2) == 'S') || ((s4 !! 2) == 'T')) &&
            ((s4 !! 3) /= 'P')
        else
            False

findMatchPositions' matchFunc [] n = []
findMatchPositions' matchFunc s n =
    if matchFunc s then
        n : (findMatchPositions' matchFunc (tail s) (n+1))
    else
        findMatchPositions' matchFunc (tail s) (n+1)

findMatchPositions matchFunc s =
    findMatchPositions' matchFunc s 1

printMatchPositions matchFunc protId proteinFASTA = do
    let ps = findMatchPositions matchFunc (dna proteinFASTA)
    if length ps > 0 then do
        putStrLn protId
        putStrLn (unwords . map show $ ps)
    else
        return ()
        
printMatches protId = do
    protein <- fetchProtein protId
    let fastas = parseFASTA . lines $ protein
    mapM_ (printMatchPositions matchesNGly protId) fastas
    
main = do
  argv <- getArgs
  fileLines <- readFile (head argv)
  mapM_ printMatches (lines fileLines)
