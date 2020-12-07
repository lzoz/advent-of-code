# kinda ugly

import sets
import strutils
import colors
import hashes
import tables

proc extractColors(str: string) : seq[string] =
    let s = str.splitWhitespace()
    for i, c in s:
        if c.isColor or c == "bronze": result.add(s[i-1] & " " & c)

proc smallerBags(bag: string, bagsInside: Table[string, HashSet[string]]): HashSet[string] =
    for b in bagsInside[bag]:
        result.incl(b)
        result.incl(b.smallerBags(bagsInside))

let input = readFile("./input.txt")
var allBags = input.extractColors.toHashSet
var bagsInside = initTable[string, HashSet[string]]()
let rules = input.splitLines

for bag in allBags:
    bagsInside[bag] = initHashSet[string]()

for r in rules:
    let colours = r.extractColors
    let container = colours[0]
    bagsInside[container] = colours[1..^1].toHashSet

var count = 0
let gold = "shiny gold"
for bag in allBags:
    if gold in bagsInside[bag] or gold in bag.smallerBags(bagsInside): count += 1

echo count