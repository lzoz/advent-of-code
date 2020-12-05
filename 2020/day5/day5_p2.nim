import sequtils
import sugar
import strutils

proc solve2(inputFile: string) : int =
    let occupied = map(toSeq(inputFile.lines), x => 
                        fromBin[int](x[0..^4].multiReplace(("F", "0"), ("B", "1"))) * 8 + 
                        fromBin[int](x[^3..^1].multiReplace(("R", "1"), ("L", "0")))
                    )
    let maxSeatIdx = max(occupied)
    let allSeats = toSeq({0..maxSeatIdx})
    result = filter(allSeats, x => (x notin occupied) and x+1 in occupied and x-1 in occupied)[0]

echo solve2("./input.txt")