import strutils
import sets

let instructions = readFile("./input.txt").splitLines

proc run(instructions: seq[string]) : bool =
    var pc, accumulator : int
    var executed = initHashSet[int]()
    while true:
        if pc == instructions.len: 
            echo "accumulator = " , accumulator
            return true
        if pc in executed:
            echo "accumulator = " , accumulator
            return false

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

for i, instr in instructions:
    var newInstructions = instructions
    let op = instr.splitWhitespace[0]

    if op == "jmp":
        newInstructions.delete(i)
        newInstructions.insert(instr.replace("jmp", "nop"), i)
    elif op == "nop":
        newInstructions.delete(i)
        newInstructions.insert(instr.replace("nop", "jmp"), i)
    else:
        continue
    
    if run(newInstructions): break