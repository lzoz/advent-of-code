import strutils, sequtils, algorithm, sugar

var input = @[0] & sorted(readFile("./input.txt").splitLines.map(x => x.parseInt))
let last: int = input.max + 3
input.add(last)

var diff1j, diff3j : int

for i, x in input:
    if i < input.len and i > 0:
        if x - input[i-1] == 1: diff1j.inc
        if x - input[i-1] == 3: diff3j.inc

echo diff1j
echo diff3j
echo diff3j * diff1j