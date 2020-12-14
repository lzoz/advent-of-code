import strutils, sequtils, sugar, tables, math

let input = readFile("./input.txt").splitLines

proc applyMask(num: string, mask: string): string =
    result = num
    for i, b in mask:
        if b == '0' or b == '1':
            result[i] = b

var mem = initTable[string, int]()
var mask: string
for line in input:
    if line[0..3] == "mask":
        mask = line.split(" = ")[1]
    else:
        let address = line.split(" = ")[0]
        let x = line.split(" = ")[1].parseInt
        mem[address] = parseBinInt(applyMask(x.toBin(36), mask))

var totalSum = 0
for v in mem.values:
    totalSum += v

echo totalSum