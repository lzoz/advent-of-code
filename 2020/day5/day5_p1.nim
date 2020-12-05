import sequtils
import sugar
import strutils

proc solve(inputFile: string) : int =
    result = max(
                    map(toSeq(inputFile.lines), x => 
                        fromBin[int](x[0..^4].multiReplace(("F", "0"), ("B", "1"))) * 8 + 
                        fromBin[int](x[^3..^1].multiReplace(("R", "1"), ("L", "0")))
                       )
                )

echo solve("./input.txt")