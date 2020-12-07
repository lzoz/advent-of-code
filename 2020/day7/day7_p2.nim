# not elegant but it works. will prob refactor later

import sets
import strutils
import colors
import hashes
import tables

proc extractColorsAndQuantity(str: string) : seq[string] =
    let s = str.splitWhitespace()
    for i, c in s:
        if c.isColor or c == "bronze":
            try: result.add(s[i-2] & " " & s[i-1] & " " & c)
            except: result.add(s[i-1] & " " & c)

proc bagsCount(bag: string, bagsinside: Table[string, HashSet[string]]) : int =
    for b in bagsinside[bag]:
        let x = b.splitWhitespace[0].parseInt
        let cb = b.splitWhitespace[1..^1].join(" ")
        result += x + (x * cb.bagsCount(bagsinside))

let input = readFile("./input.txt")
var bagsInside = initTable[string, HashSet[string]]()
let rules = input.splitLines
for r in rules:
    let colours = r.extractColorsAndQuantity
    let container = colours[0]
    if colours.len <= 1:
        bagsInside[container] = initHashSet[string]()
    else:
        bagsInside[container] = colours[1..^1].toHashSet

echo "shiny gold".bagsCount(bagsInside)