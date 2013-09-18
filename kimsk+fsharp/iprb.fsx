type Allel = Dominant | Recessive
let A, a = Dominant, Recessive

// Is an organism possess dominant allel
let possessDominant organism = 
    fst organism = A || snd organism = A

let AA, Aa, aa = (A, A), (A, a), (a, a)
let possibleOrganisms = [AA;Aa;aa]

let mate x y =
    [
        fst x ,fst y
        fst x ,snd y
        snd x ,fst y
        snd x ,snd y                
    ]

// probability of getting an organism possessing a dominant allele 
let probDominant x y =
    let d, r = mate x y |> List.partition (possessDominant)
    (/) (d |> Seq.length |> float) (d @ r |> Seq.length |> float)


// probability of finding an organism with specific allels in a list
let probFindAllel o allels =
    if allels = [] then failwith "List can't be empty"
    let m, r = allels |> List.partition ((=) o)    
    (/) (m |> Seq.length |> float) (m @ r |> Seq.length |> float)

// remove an organism with speicific allels from the list
let removeAllel o allels =
    let m, r = allels |> List.partition ((=) o)
    if m.Length = 0 then r else m.Tail @ r

// all possible mating probabilities
let possibleMates = [
                        for a in possibleOrganisms do
                            for b in possibleOrganisms do
                                yield a, b, probDominant a b
                    ] 

// Now solving the problem
let k, m, n = (17, 20, 30)

// creating all organisms
let allAllels = [ for i in 1..k -> AA ] @  [ for i in 1..m -> Aa ] @ [ for i in 1..n -> aa ]
let prob = [
            for mate in possibleMates do
                let x, y, probDominant = mate
                let probX = allAllels |> probFindAllel x
                let probY = allAllels |> removeAllel x |> probFindAllel y
                let prob = probX * probY * probDominant
                yield prob
            ] |> Seq.sum 

System.Math.Round(prob, 5)