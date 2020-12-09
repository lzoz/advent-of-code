import strutils
import sequtils
import sugar

let input = readFile("./input.txt").splitLines.map(x => x.parseInt)

const preambleLen = 25
var previous : array[preambleLen, int]
for i, x in input:
    if i >= preambleLen:
        if not previous.any(y => (x-y in previous) and (y*2 != x)):
            echo x
            break
    previous[i mod preambleLen] = x