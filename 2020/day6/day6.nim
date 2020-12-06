import strutils, sequtils, sugar, math

proc solve(inputFile: string) : int =
    result = sum(readFile(inputFile).split("\n\n").map(x => x.replace("\n").deduplicate().len))

proc solve2(inputFile: string) : int =
    result = sum(readFile(inputFile).split("\n\n").map(group => group.splitWhitespace[0].countIt(all(group.splitWhitespace, person => person.contains(it)))))

echo solve("./input.txt")
echo solve2("./input.txt")