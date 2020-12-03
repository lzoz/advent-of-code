proc readInput(filepath: string): seq[string] =
    var f: File
    discard open(f, filepath)

    var tmp: string
    while readLine(f, tmp):
        result.add(tmp)

proc solve(input: seq[string]): int =
    var line, idx: int
    let maxLine = input.len
    let maxIdx = input[0].len 
    while true:
        line = line + 1
        if line >= maxLine: break
        idx = (idx+3) mod maxIdx
        if input[line][idx] == '#':
            result = result + 1

var data = readInput("./d3_input.txt")
echo solve(data)