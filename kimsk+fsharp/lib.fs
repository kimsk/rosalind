module lib

open System

type fasta = 
    { ID:string; DNA:string; }
    member this.GcValue =
        let count = this.DNA.Length
        let gc = 
            this.DNA
            |> List.ofSeq
            |> List.filter (fun c -> c = 'C' || c = 'G')        

        System.Math.Round(((float)gc.Length * (float)100)/(float)count,6)

let dataset2Fasta (dataset:string) = dataset.Replace("\n", "")
                                        .Split([|">"|], StringSplitOptions.RemoveEmptyEntries) 
                                        |> Seq.map (fun s -> 
                                        { 
                                            ID = s.Substring(0,13);
                                            DNA = s.[13..];
                                        })
    

let fastaData2DnaStrings fastaData =
    let rows = fastaData |> Seq.length
    let cols = (fastaData |> Seq.nth 0).DNA.Length
    Array2D.init rows cols (fun i j -> (fastaData |> Seq.nth i).DNA |> Seq.nth j)
    

let dnaCollection = [|'A';'C';'G';'T'|]