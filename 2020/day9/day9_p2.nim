import strutils
import sequtils
import sugar
import math

let invalidNum = 3199139634

let input: seq[int] = readFile("./input.txt").splitLines.map(x => x.parseInt)

for i, num in input:
    if num >= invalidNum: continue
    var xs = @[num]
    var j = i+1
    while j < input.len and xs.sum < invalidNum:
        xs.add(input[j])
        if xs.sum == invalidNum: break
        j += 1
    if xs.sum == invalidNum:
        echo xs.min + xs.max
        break