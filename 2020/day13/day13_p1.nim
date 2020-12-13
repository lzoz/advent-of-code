import strutils, sequtils, sugar

let input = readFile("./input.txt").splitLines
let earliest = input[0].parseInt
let ids = input[1].split(",").filter(i => i[0].isDigit).map(x => x.parseInt)

var x = earliest
block loop:
    while true:
        for i in ids:
            if x mod i == 0:
                echo i * (x - earliest)
                break loop
        x.inc
