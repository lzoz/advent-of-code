import strutils, sequtils, sugar, math

let input = readFile("./input.txt").splitLines()

var ranges: seq[(int, int)]
var linenum: int

for i, line in input:
    if "or" in line:
        let str = line.split(":")[1].split(" or ")
        let r1: (int, int) = (str[0].strip.split("-")[0].parseInt, str[0].strip.split("-")[1].parseInt)
        let r2: (int, int) = (str[1].strip.split("-")[0].parseInt, str[1].strip.split("-")[1].parseInt)
        ranges.add(r1)
        ranges.add(r2)
    elif line == "nearby tickets:":
        linenum = i

var nearbys: seq[int]
for line in input[linenum+1..^1]:
    for x in line.split(","):
        nearbys.add(x.parseInt)

var invalids: seq[int]
for x in nearbys:
    if not ranges.any(r => x >= r[0] and x <= r[1]):
        invalids.add(x)

echo invalids.sum
