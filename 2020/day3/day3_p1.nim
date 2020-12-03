proc readInput(filepath: string): seq[string] =
    var f: File
    discard open(f, filepath)

    var tmp: string
    while readLine(f, tmp):
        result.add(tmp)

proc solve(input: seq[string]): int =
    var line = 0
    var idx = 0
    while true:
        line = line + 1
        if line >= input.len: break
        idx = (idx+3) mod 31 # (idx + 3) mod len(input[line])
        if input[line][idx] == '#':
            result = result + 1

var data = readInput("./d3_input.txt")
echo solve(data)