#load "lib.fs"

open lib

let dataset = @">Rosalind_0001
ATCCAGCT
>Rosalind_0002
GGGCAACT
>Rosalind_0003
ATGGATCT
>Rosalind_0004
AAGCAACC
>Rosalind_0005
TTGGAACT
>Rosalind_0006
ATGCCATT
>Rosalind_0007
ATGGCACT"

let dnaStrings = dataset 
                |> dataset2Fasta 
                |> fastaData2DnaStrings

// build Profile 2D array & consensus
let rows = dnaCollection.Length
let cols = Array2D.length2 dnaStrings

// A
// C
// G
// T
let profile2DArray = Array2D.create rows cols 0
let consensus = [|for i in 1..cols -> (0, 'X')|]

let dnaStringsRows = Array2D.length1 dnaStrings
let dnaStringsCols = Array2D.length2 dnaStrings

// TODO: Imperative way, try to do functional way
for i = 0 to dnaStringsRows - 1 do
    for j = 0 to dnaStringsCols - 1 do
        let row = dnaCollection |> Seq.findIndex ((=) dnaStrings.[i,j])
        profile2DArray.[row,j] <- profile2DArray.[row,j] + 1

for i = 0 to rows - 1 do
    for j = 0 to cols - 1 do        
        if profile2DArray.[i, j] > fst(consensus.[j]) then
            consensus.[j] <- (profile2DArray.[i, j], dnaCollection.[i])

// presentation
let p2dArrayRow = profile2DArray |> Array2D.length1

printfn "%s" (consensus |> Array.fold (fun (acc:string) x -> acc + snd(x).ToString()) "")
for i = 0 to p2dArrayRow - 1 do
    let char = dnaCollection.[i]
    printf "%c:" char
    for j = 0 to cols - 1 do
        printf " %d" profile2DArray.[i,j]
    printfn ""                   


