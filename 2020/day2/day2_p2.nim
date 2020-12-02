import strutils

proc readInput(filepath: string): int =
    var f: File
    discard open(f, filepath)

    var tmp: string
    while readLine(f, tmp):
        var arr = tmp.splitWhitespace()
        let policyChar = arr[1][0]
        var policyMin = parseInt(split(arr[0], '-')[0])
        var policyMax = parseInt(split(arr[0], '-')[1])
        # echo policyChar, policyMin, policyMax
        if arr[2][policyMin-1] == policyChar xor arr[2][policyMax-1] == policyChar:
            result = result + 1

var data = readInput("./input.txt")
echo data