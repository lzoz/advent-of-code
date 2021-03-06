import strutils, tables, re

proc ruleToRegex(rule: string, rules: Table[int, string]): string =
    let rule = rule.splitWhitespace
    for r in rule:
        if r[0] == '"':
            return r[1..^2]
        elif r[0].isDigit:
            result = result & ruleToRegex(rules[r.parseInt], rules)
        elif r == "|":
            result = result & "|"
    result = "(" & result & ")"

let input = readFile("./input.txt").splitLines

var rules = initTable[int, string]()
var msgs: seq[string]

for line in input:
    if ':' in line:
        let ruleNum = line.split(":")[0].parseInt
        let rule = line.split(": ")[1]
        rules[ruleNum] = rule
    elif not line.isEmptyOrWhitespace:
        msgs.add(line)

let rule0 = "^" & ruleToRegex(rules[0], rules) & "$"

var count = 0
for m in msgs:
    if match(m, re(rule0)):
        count.inc

echo count