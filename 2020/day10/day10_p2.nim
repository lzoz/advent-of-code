import strutils, sequtils, sugar, tables, math, algorithm

var input = @[0] & sorted(readFile("./input.txt").splitLines.map(x => x.parseInt))
input.add(input.max + 3)

var memo = initTable[int, BiggestInt]()
proc dp(i: int): BiggestInt =
    if i == input.len-1: return 1
    if i in memo: return memo[i]
    result += (i+1..input.len-1).toSeq.filter(x => input[x]-input[i] <= 3).map(y => dp(y)).sum
    memo[i] = result

echo dp(0)