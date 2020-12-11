import strutils, sequtils, sugar

let inputFile = "./input.txt"
# let inputFile = "./sample.txt"
let input = readFile(inputFile).splitLines

proc leftOccupied(posX, posY : int, layout: openArray[string]): bool =
    var x = posX - 1
    while x >= 0:
        if layout[posY][x] == '#': return true
        elif layout[posY][x] == 'L': return false
        else: x.dec
    return false

proc rightOccupied(posX, posY : int, layout: openArray[string]): bool =
    var x = posX + 1
    while x < layout[posY].len:
        if layout[posY][x] == '#': return true
        elif layout[posY][x] == 'L': return false
        else: x.inc
    return false

proc downOccupied(posX, posY : int, layout: openArray[string]): bool =
    var y = posY + 1
    while y < layout.len:
        if layout[y][posX] == '#': return true
        elif layout[y][posX] == 'L': return false
        else: y.inc
    return false

proc upOccupied(posX, posY : int, layout: openArray[string]): bool =
    var y = posY - 1
    while y >= 0:
        if layout[y][posX] == '#': return true
        elif layout[y][posX] == 'L': return false
        else: y.dec
    return false

proc adjLeftDownOccupied(posX, posY : int, layout: openArray[string]): bool =
    var x = posX - 1
    var y = posY + 1
    while x >= 0 and y < layout.len:
        if layout[y][x] == '#': return true
        elif layout[y][x] == 'L': return false
        else:
            x.dec
            y.inc
    return false

proc adjRightDownOccupied(posX, posY : int, layout: openArray[string]): bool =
    var x = posX + 1
    var y = posY + 1
    while x < layout[posY].len and y < layout.len:
        if layout[y][x] == '#': return true
        elif layout[y][x] == 'L': return false
        else:
            x.inc
            y.inc
    return false

proc adjLeftUpOccupied(posX, posY : int, layout: openArray[string]): bool =
    var x = posX - 1
    var y = posY - 1
    while x >= 0 and y >= 0:
        if layout[y][x] == '#': return true
        elif layout[y][x] == 'L': return false
        else:
            x.dec
            y.dec
    return false

proc adjRightUpOccupied(posX, posY : int, layout: openArray[string]): bool =
    var x = posX + 1
    var y = posY - 1
    while x < layout[posY].len and y >= 0:
        if layout[y][x] == '#': return true
        elif layout[y][x] == 'L': return false
        else:
            x.inc
            y.dec
    return false

proc change(posX, posY : int, layout: openArray[string]) : char =
    if layout[posY][posX] == 'L':
        var occupy = true
        if leftOccupied(posX, posY, layout): occupy = false
        if rightOccupied(posX, posY, layout): occupy = false
        if upOccupied(posX, posY, layout): occupy = false
        if downOccupied(posX, posY, layout): occupy = false
        if adjLeftDownOccupied(posX, posY, layout): occupy = false
        if adjRightDownOccupied(posX, posY, layout): occupy = false
        if adjLeftUpOccupied(posX, posY, layout): occupy = false
        if adjRightUpOccupied(posX, posY, layout): occupy = false
        if occupy: return '#'
        else: return 'L'
    elif layout[posY][posX] == '#':
        var occupiedCount = 0
        if leftOccupied(posX, posY, layout): occupiedCount += 1
        if rightOccupied(posX, posY, layout): occupiedCount.inc
        if upOccupied(posX, posY, layout): occupiedCount.inc
        if downOccupied(posX, posY, layout): occupiedCount.inc
        if adjLeftDownOccupied(posX, posY, layout): occupiedCount.inc
        if adjRightDownOccupied(posX, posY, layout): occupiedCount.inc
        if adjLeftUpOccupied(posX, posY, layout): occupiedCount.inc
        if adjRightUpOccupied(posX, posY, layout): occupiedCount.inc
        if occupiedCount >= 5: return 'L'
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