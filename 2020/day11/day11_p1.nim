import strutils, sequtils, sugar

let inputFile = "./input.txt"
# let inputFile = "./sample.txt"
let input = readFile(inputFile).splitLines

proc change(posX, posY : int, layout: openArray[string]) : char =
    if layout[posY][posX] == 'L':
        var occupy = true
        if posX > 0 and layout[posY][posX-1] == '#': occupy = false
        if posX < layout[0].len-1 and layout[posY][posX+1] == '#': occupy = false
        if posY > 0 and layout[posY-1][posX] == '#': occupy = false
        if posY < layout.len-1 and layout[posY+1][posX] == '#': occupy = false
        if posX > 0 and posY < layout.len-1 and layout[posY+1][posX-1] == '#': occupy = false
        if posX < layout[0].len-1 and posY < layout.len-1 and layout[posY+1][posX+1] == '#': occupy = false
        if posX > 0 and posY > 0 and layout[posY-1][posX-1] == '#': occupy = false
        if posX < layout[0].len-1 and posY > 0 and layout[posY-1][posX+1] == '#': occupy = false
        if occupy: return '#'
        else: return 'L'
    elif layout[posY][posX] == '#':
        var occupiedCount = 0
        if posX > 0 and layout[posY][posX-1] == '#': occupiedCount += 1
        if posX < layout[0].len-1 and layout[posY][posX+1] == '#': occupiedCount += 1
        if posY > 0 and layout[posY-1][posX] == '#': occupiedCount += 1
        if posY < layout.len-1 and layout[posY+1][posX] == '#': occupiedCount += 1
        if posX > 0 and posY < layout.len-1 and layout[posY+1][posX-1] == '#': occupiedCount += 1
        if posX < layout[0].len-1 and posY < layout.len-1 and layout[posY+1][posX+1] == '#': occupiedCount += 1
        if posX > 0 and posY > 0 and layout[posY-1][posX-1] == '#': occupiedCount += 1
        if posX < layout[0].len-1 and posY > 0 and layout[posY-1][posX+1] == '#': occupiedCount += 1
        if occupiedCount >= 4: return 'L'
        else: return '#'
    else: return layout[posY][posX]

var layout = input
while true:
    var newLayout = layout
    for x in 0..input[0].len-1:
        for y in 0..input.len-1:
            newLayout[y][x] = change(x, y, layout)
    
    if newLayout == layout: break
    else: layout = newLayout

echo layout.join(" ").count('#')