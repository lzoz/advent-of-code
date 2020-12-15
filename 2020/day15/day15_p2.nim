import tables

let input = [13'i64,16,0,12,15,1]
var indices = initTable[BiggestInt, BiggestInt]()
for i, x in input:
  indices[x] = i

var i: BiggestInt = input.high
var previous = input[i]
while i < 30000000-1:
  if previous notin indices:
    previous = 0
  else:
    let diff = i - indices[previous]
    if diff notin indices: indices[diff] = i+1
    indices[previous] = i
    previous = diff
  i.inc()

echo previous