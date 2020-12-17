import strutils, sequtils, sugar, sets

let input = readFile("./input.txt").splitLines

var neighbours: seq[(int, int, int, int)]
for x in [-1, 0, 1]:
    for y in [-1, 0, 1]:
        for z in [-1, 0, 1]:
            for w in [-1, 0, 1]:
                if (x, y, z, w) == (0,0,0,0): continue
                neighbours.add((x,y,z,w))

var active: HashSet[(int, int, int, int)]
init(active)
for y, line in input:
    for x, c in line:
        if c == '#': active.incl((x,y,0,0))

let cycles = 6

proc oneCycle(active: HashSet[(int, int, int, int)]): HashSet[(int, int, int, int)] =
    var newActive: HashSet[(int, int, int, int)] = active
    let neighbours = neighbours
    for a in active:
        var activeNeighbourCount = 0
        for n in neighbours:
            let neigh = (a[0]+n[0], a[1]+n[1], a[2]+n[2], a[3]+n[3])
            if neigh in active: activeNeighbourCount.inc
        if not (activeNeighbourCount == 2 or activeNeighbourCount == 3):
            newActive.excl(a)
    
    let maxX = active.map(c => c[0]).toSeq.max + 1
    let maxY = active.map(c => c[1]).toSeq.max + 1
    let maxZ = active.map(c => c[2]).toSeq.max + 1
    let maxW = active.map(c => c[3]).toSeq.max + 1
    let maxDimension = max([maxX, maxY, maxZ, maxW])
    for x in -maxDimension..maxDimension:
        for y in -maxDimension..maxDimension:
            for z in -maxDimension..maxDimension:
                for w in -maxDimension..maxDimension:
                    var activeNeighbourCount = 0
                    if (x,y,z,w) in active: continue
                    for n in neighbours:
                        let neigh = (x+n[0], y+n[1], z+n[2], w+n[3])
                        if neigh in active: activeNeighbourCount.inc
                    if activeNeighbourCount == 3: newActive.incl((x,y,z,w))
    
    return newActive

for i in 1..cycles:
    active = oneCycle(active)
    
echo active.len