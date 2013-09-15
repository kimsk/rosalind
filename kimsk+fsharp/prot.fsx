let getAminoAcid (rnaString:string) =
    let rnaToAminoAcid (rna) =
        match rna with
        | "UUU" | "UUC" -> "F"
        | "UUA" | "UUG" -> "L"
        | "UCU" | "UCC" | "UCA" | "UCG" -> "S"
        | "UAU" | "UAC" -> "Y"    
        | "UGU" | "UGC" -> "C"
        | "UGG" -> "W"
        | "CUU" | "CUC" | "CUA" | "CUG" -> "L"
        | "CCU" | "CCC" | "CCA" | "CCG" -> "P"
        | "CAU" | "CAC" -> "H"
        | "CAA" | "CAG" -> "Q"
        | "CGU" | "CGC" | "CGA" | "CGG" -> "R"
        | "AUU" | "AUC" | "AUA" -> "I"
        | "AUG" -> "M"
        | "ACU" | "ACC" | "ACA" | "ACG" -> "T"
        | "AAU" | "AAC" -> "N"
        | "AAA" | "AAG" -> "K"
        | "AGU" | "AGC" -> "S"
        | "AGA" | "AGG" -> "R"
        | "GUU" | "GUC" | "GUA" | "GUG" -> "V"
        | "GCU" | "GCC" | "GCA" | "GCG" -> "A"
        | "GAU" | "GAC" -> "D"
        | "GAA" | "GAG" -> "E"
        | "GGU" | "GGC" | "GGA" | "GGG" -> "G"    
        | _ -> failwith "invalid RNA"

    let isEndRna rna =
        match rna with
        | "UAA" | "UAG" | "UGA" -> true
        | _ -> false

    // "ABCDEF" to [|"ABC";"DEF"|]
    // TODO: there should be a better way to do this
    let rnaArray = 
        [|
            for i in 0..rnaString.Length do
                if i > 0 && i%3 = 0 then yield rnaString.[i-3].ToString() + rnaString.[i-2].ToString() + rnaString.[i-1].ToString()
        |] 

    // find the 1st end
    let endOfRna = rnaArray |> Seq.findIndex (fun y -> isEndRna y)

    let accAminoAcid (acc:string) rna =
        acc + rnaToAminoAcid rna    

    Array.fold accAminoAcid "" rnaArray.[0..(endOfRna - 1)]

let rnaString = "AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA" 

getAminoAcid rnaString