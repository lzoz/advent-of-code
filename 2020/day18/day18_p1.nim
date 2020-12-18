import strutils, algorithm, sequtils, sugar

let input = readFile("./input.txt").splitLines

proc findClosingB(expression: string, opening: int): int =
    var count = 0
    for i, c in expression[opening..^1]:
        if c == '(': count.inc
        elif c == ')': count.dec
        if count == 0: return i+opening

proc evaluate(expression: string): int64 =
    let i = expression.find("(", 0)
    if i == -1:
        let expression = expression.splitWhitespace().map(e => e.strip(true, true, {'(', ')'})).toSeq
        result = expression[0].parseInt
        var idx = 1
        while idx < expression.len:
            let e = expression[idx]
            if e == "+":
                result += expression[idx+1].parseInt
                idx.inc(2)
            elif e == "*":
                result *= expression[idx+1].parseInt
                idx.inc(2)
            else:
                idx.inc()
    else:
        var exp = expression
        let j = findClosingB(expression, i)
        let subexp = exp[i..j]
        exp = exp.replace(subexp, $evaluate(subexp[1..^2]))
        result = evaluate(exp)

var result = 0'i64
for line in input:
    result += evaluate(line)

echo result