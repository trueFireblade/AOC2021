open System.Linq
let lines = List.ofSeq(System.IO.File.ReadLines("input.txt"))

type BingoNumber =
    struct
        val Val: int
        val Active: bool
        new(i: int, act: bool) = {Val = i; Active = act;}
    end

let toChunks n (s:seq<'t>) = seq {
    let pos = ref 0
    let buffer = Array.zeroCreate<'t> n
 
    for x in s do
        buffer.[!pos] <- x
        if !pos = n - 1 then
            yield buffer |> Array.copy
            pos := 0
        else
            incr pos
 
    if !pos > 0 then
        yield Array.sub buffer 0 !pos
}

let rec recCheckList rows =
    if List.isEmpty rows then
        false
    else
        let currentRow = rows.Head
        if ((List.filter (fun (x:BingoNumber) -> x.Active) currentRow).Length = 5) then
            true
        else
            recCheckList rows.Tail

let checkBoard board =
    let rows=List.chunkBySize 5 board
    let hor=recCheckList rows
    let columns = [List.map (fun (x:list<BingoNumber>) -> x[0]) rows; List.map (fun (x:list<BingoNumber>) -> x[1]) rows; List.map (fun (x:list<BingoNumber>) -> x[2]) rows; List.map (fun (x:list<BingoNumber>) -> x[3]) rows; List.map (fun (x:list<BingoNumber>) -> x[4]) rows]
    let ver=recCheckList columns
    hor || ver

let checkBoards boards =
    List.map (fun x -> checkBoard x) boards

let addToBoard board num =
    List.map (fun (x:BingoNumber) -> if (x.Val = num) then new BingoNumber(num, true) else x) board

let addToBoards boardList num = 
    List.map (fun x -> addToBoard x num) boardList

let prepList lst num =
    let sum = List.filter (fun (x:BingoNumber) -> not x.Active) lst |> List.map (fun (x:BingoNumber) -> x.Val) |> List.reduce (+)
    sum*num

let rec recStep1 (input: list<int>) bingoBoards = 
    let newBingoBoards = addToBoards bingoBoards input.Head
    let res = checkBoards newBingoBoards
    if (List.reduce (||) res)
    then prepList (List.item (List.tryFindIndex (fun x -> x = true) res).Value newBingoBoards) input.Head
    else recStep1 input.Tail newBingoBoards

let rec recStep2 (input: list<int>) bingoBoards =
    let newBingoBoards = addToBoards bingoBoards input.Head
    let filteredBoards = List.filter (fun x -> not (checkBoard x)) newBingoBoards
    if (List.length filteredBoards = 1)
    then recStep1 input.Tail filteredBoards
    else recStep2 input.Tail filteredBoards



let main =
    let first = (List.ofArray <| lines.Head.Split ",") |> List.map int
    let rest = (List.ofArray <| (String.concat " " lines.Tail).Split " ") |> List.filter (fun x -> not (x = ""))
    let bingoBoards = List.map int rest |> List.map (fun x -> new BingoNumber(x, false)) |> Seq.ofList |> toChunks 25 |> List.ofSeq |> List.map List.ofArray
    printf "Result of part one: %d\n" <| recStep1 first bingoBoards
    printf "Result of part two: %d\n" <| recStep2 first bingoBoards
