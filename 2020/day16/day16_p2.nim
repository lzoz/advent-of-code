import strutils, sequtils, sugar, math, tables, algorithm

let input = readFile("./input.txt").splitLines()

var ranges: seq[(string, int, int, int, int)]
var myticket: seq[int]
var linenum: int
for i, line in input:
    if "or" in line:
        let str = line.split(":")[1].split(" or ")
        let r1 = (line.split(":")[0], str[0].strip.split("-")[0].parseInt, str[0].strip.split("-")[1].parseInt,
                  str[1].strip.split("-")[0].parseInt, str[1].strip.split("-")[1].parseInt)
        ranges.add(r1)
    elif line == "nearby tickets:":
        linenum = i+1
    elif line == "your ticket:":
        myticket = input[i+1].split(",").toSeq.map(x => x.parseInt).toSeq

var valids: seq[seq[int]] = @[myticket]
for line in input[linenum..^1]:
    var isvalid = true
    let l = line.split(",").toSeq.map(z => z.parseInt).toSeq
    for x in l:
        if not ranges.any(r => (x >= r[1] and x <= r[2]) or (x >= r[3] and x <= r[4])):
            isvalid = false
            break
    if isvalid:
        valids.add(l)

let fieldcount = valids[0].len
var fields : seq[string]
newSeq(fields, fieldcount)
var currentRanges = ranges
while currentRanges.len > 0:
    for i in 0..fieldcount-1:
        let values = valids.map(v => v[i]).toSeq
        var count = 0
        var rangeFit: int
        for j, r in currentRanges:
            if values.all(v => (v >= r[1] and v <= r[2]) or (v >= r[3] and v <= r[4])):
                count.inc
                rangeFit = j
        if count == 1:
            fields[i] = currentRanges[rangeFit][0]
            currentRanges.delete(rangeFit)

var product: BiggestInt = 1
for i, f in fields:
    if "departure" in f:
        product = product * myticket[i]

echo product