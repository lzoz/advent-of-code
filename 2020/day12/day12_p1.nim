import strutils, tables

type
    Direction = enum
        north, east, south, west

let input = readFile("./input.txt").splitLines

var facing: Direction = east
var pos = initTable[Direction, int]()
pos[north] = 0
pos[east] = 0
pos[south] = 0
pos[west] = 0

for line in input:
    if line[0] == 'F': 
        let x = line[1..^1].parseInt
        pos[facing] += x
        if facing == north: pos[south] -= x
        if facing == east: pos[west] -= x
        if facing == south: pos[north] -= x
        if facing == west: pos[east] -= x
    elif line[0] == 'L':
        var x = line[1..^1].parseInt div 90
        while x > 0:
            try: facing = facing.pred
            except: facing = Direction.high
            finally: x.dec
    elif line[0] == 'R':
        var x = line[1..^1].parseInt div 90
        while x > 0:
            try: facing = facing.succ
            except: facing = Direction.low
            finally: x.dec
    elif line[0] == 'N':
        pos[north] += line[1..^1].parseInt
        pos[south] -= line[1..^1].parseInt
    elif line[0] == 'E':
        pos[east] += line[1..^1].parseInt
        pos[west] -= line[1..^1].parseInt
    elif line[0] == 'S':
        pos[south] += line[1..^1].parseInt
        pos[north] -= line[1..^1].parseInt
    elif line[0] == 'W':
        pos[west] += line[1..^1].parseInt
        pos[east] -= line[1..^1].parseInt

echo pos