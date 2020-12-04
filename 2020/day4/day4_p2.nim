# WARNING: Extremely dirty code ahead

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
        var byrValid, iyrValid, eyrValid, hgtValid, hclValid, eclValid, pidValid = false
        let currentFields = p.splitWhitespace
        var tmp: set[Fields] = {}
        for f in currentFields:
            let fieldType = parseEnum[Fields](f.split(':')[0])
            let val = f.split(':')[1]
            if fieldType == byr and val.len == 4:
                try:
                    let x = val.parseInt
                    if x >= 1920 and x <= 2002:
                        byrValid = true
                except ValueError:
                    byrValid = false
            elif  fieldType == iyr and val.len == 4:
                try:
                    let x = val.parseInt
                    if x >= 2010 and x <= 2020:
                        iyrValid = true
                except ValueError:
                    iyrValid = false
            elif fieldType == eyr and val.len == 4:
                try:
                    let x = val.parseInt
                    if x >= 2020 and x <= 2030:
                        eyrValid = true
                except ValueError:
                    eyrValid = false
            elif fieldType == hgt:
                if val[^2..^1] == "cm" or val[^2..^1] == "in":
                    try:
                        let x = parseInt(val[0..^3])
                        if val[^2..^1] == "cm" and x >= 150 and x <= 193:
                            hgtValid = true
                        elif val[^2..^1] == "in" and x >= 59 and x <= 76:
                            hgtValid = true
                        else:
                            hgtValid = false
                    except ValueError:
                        hgtValid = false
                else:
                    hgtValid = false
            elif fieldType == hcl:
                if val[0] != '#' or val.len != 7 or val.contains('-'):
                    hclValid = false
                else:
                    try:
                        discard fromHex[int](val)
                        hclValid = true
                    except ValueError:
                        hclValid = false
            elif fieldType == ecl:
                if val in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]:
                    eclValid = true
                else:
                    eclValid = false
            elif fieldType == pid:
                if val.len != 9:
                    pidValid = false
                else:
                    pidValid = true
                    for c in val:
                        if not c.isDigit:
                            pidValid = false
                            break

            tmp = tmp + {fieldType}
        let haveAllFields = (pfields - tmp == {}) or (pfields - tmp == {cid}) 
        if haveAllFields and byrValid and iyrValid and eyrValid and hgtValid and hclValid and eclValid and pidValid:
                result = result + 1

var data = readInput("./input.txt")
echo data.len
echo solve(data)