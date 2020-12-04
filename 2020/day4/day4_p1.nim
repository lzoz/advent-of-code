import strutils

type
    Fields = enum
        byr, iyr, eyr, hgt, hcl, ecl, pid, cid

proc readInput(filepath: string): seq[string] =
    var f: File
    discard open(f, filepath)

    var tmp: string
    while readLine(f, tmp):
        if tmp == "\n" : continue
        else:
            var p: string = ""
            while tmp.len > 1:
                p = p & " " & tmp
                discard readLine(f, tmp)
            result.add(p)

proc solve(passports: seq[string]): int =
    let pfields: set[Fields] = {byr, iyr, eyr, hgt, hcl, ecl, pid, cid}
    for p in passports:
        let currentFields = p.splitWhitespace
        var tmp: set[Fields] = {}
        for f in currentFields:
            let x = f.split(':')[0]
            tmp = tmp + {parseEnum[Fields](x)}
        if (pfields - tmp == {}) or (pfields - tmp == {cid}):
            result = result + 1

var data = readInput("./input.txt")
echo solve(data)