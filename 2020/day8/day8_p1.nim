import strutils
import sets

let instructions = readFile("./input.txt").splitLines

var accumulator = 0
var pc = 0
var executed = initHashSet[int]()

while true:
    if pc in executed:
        echo accumulator
        break

    let instr = instructions[pc]
    executed.incl(pc)

    let op = instr.splitWhitespace[0]
    let val = instr.splitWhitespace[1].parseInt

    if op == "acc":
        accumulator += val
        pc += 1
    elif op == "jmp":
        pc += val
    elif op == "nop":
        pc += 1
