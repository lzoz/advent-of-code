import strutils, sequtils, sugar, tables, math

let input = readFile("./input.txt").splitLines

proc applyMask(num: string, mask: string): seq[string] =
    var floatingCount = 0
    var num = num
    for i, b in mask:
        if b == '1':
            num[i] = b
        elif b == 'X':
            floatingCount.inc
    for i in 0 .. (2^floatingCount)-1:
        let ibin = i.toBin(floatingCount)
        var j = 0
        var n = num
        for k, b in mask:
            if b == 'X':
                n[k] = ibin[j]
                j.inc
        result.add(n)



var mem = initTable[string, int]()
var mask: string
for line in input:
    if line[0..3] == "mask":
        mask = line.split(" = ")[1]
    else:
        let address = line.split(" = ")[0][4..^2].parseInt.toBin(36)
        let addresses = applyMask(address, mask)
        let x = line.split(" = ")[1].parseInt
        for a in addresses:
            mem[a] = x

var totalSum = 0
for v in mem.values:
    totalSum += v

echo totalSum