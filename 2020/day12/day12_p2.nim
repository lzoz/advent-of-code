import strutils, tables

type
    Direction = enum
        north, east, south, west

let input = readFile("./input.txt").splitLines

# var facing: Direction = east
var pos = initTable[Direction, int]()
pos[north] = 0
pos[east] = 0
pos[south] = 0
pos[west] = 0
var waypoint = initTable[Direction, int]()
waypoint[north] = 1
waypoint[east] = 10
waypoint[south] = -1
waypoint[west] = -10

for line in input:
    if line[0] == 'F': 
        let x = line[1..^1].parseInt
        pos[north] += waypoint[north] * x
        pos[south] += waypoint[south] * x
        pos[east] += waypoint[east] * x
        pos[west] += waypoint[west] * x
    elif line[0] == 'R':
        var x = line[1..^1].parseInt div 90
        while x > 0:
            var i = if waypoint[north] > 0: north else: south
            var j = if waypoint[east] > 0: east else: west

            let oldWaypoint = waypoint
            if i == north:
                waypoint[east] = oldWaypoint[north]
                waypoint[west] = -waypoint[east]
            else:
                waypoint[west] = oldWaypoint[south]
                waypoint[east] = -waypoint[west]
            
            if j == east:
                waypoint[south] = oldWaypoint[east]
                waypoint[north] = -waypoint[south]
            else:
                waypoint[north] = oldWaypoint[west] 
                waypoint[south] = -waypoint[north]
            
            x.dec()
            
    elif line[0] == 'L':
        var x = line[1..^1].parseInt div 90
        while x > 0:
            let oldWaypoint = waypoint
            var i = if waypoint[north] > 0: north else: south
            var j = if waypoint[east] > 0: east else: west

            if i == north:
                waypoint[west] = oldWaypoint[north]
                waypoint[east] = -waypoint[west]
            else:
                waypoint[east] = oldWaypoint[south]
                waypoint[west] = -waypoint[east]
            
            if j == east:
                waypoint[north] = oldWaypoint[east]
                waypoint[south] = -waypoint[north]
            else:
                waypoint[south] = oldWaypoint[west] 
                waypoint[north] = -waypoint[south]

            x.dec()
    elif line[0] == 'N':
        waypoint[north] += line[1..^1].parseInt
        waypoint[south] -= line[1..^1].parseInt
    elif line[0] == 'E':
        waypoint[east] += line[1..^1].parseInt
        waypoint[west] -= line[1..^1].parseInt
    elif line[0] == 'S':
        waypoint[south] += line[1..^1].parseInt
        waypoint[north] -= line[1..^1].parseInt
    elif line[0] == 'W':
        waypoint[west] += line[1..^1].parseInt
        waypoint[east] -= line[1..^1].parseInt

echo pos