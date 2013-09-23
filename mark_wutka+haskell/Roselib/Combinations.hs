module Roselib.Combinations
(factorial, choose, exactly_r_in_n, at_least_r_in_n)
where

choose :: Integer -> Integer -> Integer
choose n r = 
    factorial n `quot` ((factorial r) * (factorial (n-r)))

factorial :: Integer -> Integer
factorial n =
    fact_iter n 1
        where
            fact_iter n acc = if n <= 1 then acc else fact_iter (n-1) (n*acc)


exactly_r_in_n :: Integer -> Integer -> Double -> Double
exactly_r_in_n r n p =
    (fromIntegral (choose n r)) * (p ** (fromIntegral r)) * ((1.0 - p) ** (fromIntegral (n-r)))

at_least_r_in_n :: Integer -> Integer -> Double -> Double
at_least_r_in_n r n p =
    sum (map (\r1 -> exactly_r_in_n r1 n p) [r..n])
