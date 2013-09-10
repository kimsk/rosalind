let dnaCount s = [for ch in "ACGT" -> string << Seq.length <| Seq.filter (fun x -> x = ch) s] |> String.concat " "
dnaCount "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC" |> printfn "%s"

// Test
dnaCount "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC" |> (=) "20 12 17 21"
