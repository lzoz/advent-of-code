import strutils

proc readInput(filepath: string): seq[int] =
    var f: File
    discard open(f, filepath)

    var tmp: string
    while readLine(f, tmp):
        result.add(tmp.parseInt)

proc solve(input: seq[int]): int =
    for x in input:
        for y in input:
            if x == y: continue
            if x + y == 2020: return x*y

var data = readInput("./data.txt")
echo solve(data)