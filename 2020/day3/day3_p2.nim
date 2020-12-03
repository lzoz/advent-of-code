proc readInput(filepath: string): seq[string] =
    var f: File
    discard open(f, filepath)

    var tmp: string
    while readLine(f, tmp):
        result.add(tmp)

proc countTrees(input: seq[string], r, d: int): int =
    var line = 0
    var idx = 0
    while true:
        line = line + d
        if line >= input.len: break
        idx = (idx+r) mod 31
        if input[line][idx] == '#':
            result = result + 1

var data = readInput("./d3_input.txt")
echo countTrees(data, 1, 1) * countTrees(data, 3, 1) * countTrees(data, 5, 1) * countTrees(data, 7, 1) * countTrees(data, 1, 2)