-- From Twan van Laarhoven http://twanvl.nl/blog/haskell/Knuth-Morris-Pratt-in-Haskell
-- Modified matcher to return the offsets (starting at 1, not 0 ) of the substrings

module Roselib.KMP
(substringOffsets)
where

data KMP a = KMP
      { done :: Bool
      , next :: (a -> KMP a)
      }

substringOffsets :: Eq a => [a] -> [a] -> [Int]
substringOffsets as bs = match (makeTable as) 1 bs
   where  match table n []   = if (done table) then [n - length as] else []
          match table n (b:bs) = if (done table) then (n - length as) : match (next table b) (n+1) bs else match (next table b) (n+1) bs

makeTable :: Eq a => [a] -> KMP a
makeTable xs = table
   where table = makeTable' xs (const table)

makeTable' []     failure = KMP True failure
makeTable' (x:xs) failure = KMP False test
   where  test  c = if c == x then success else failure c
          success = makeTable' xs (next (failure x))
