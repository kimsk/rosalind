let rec rabbits (n:int64) (k:int64) :int64=
    match n with
    | n when n <= 2L -> 1L    
    | n -> rabbits (n-1L) k + (k * rabbits (n-2L) k) 
        
rabbits 34L 5L