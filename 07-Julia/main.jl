lines = map(x->parse(Int16,x),split(readline("input.txt"),","))
m = reduce(max,lines)

# Part 1
arr1 = []
i = 0
while i < m
    dis = reduce(+,map(x->abs(x-i),lines))
    push!(arr1,dis)

    global i+=1
end

min_val1 = reduce(min,arr1)

println("Result of part 1: $min_val1")

# Part 2

function findFuelRec(left_to_go, acc)
    new_acc = acc + left_to_go
    if left_to_go <= 1
	return new_acc
    else
	return findFuelRec(left_to_go-1, new_acc)
    end
end

arr2 = []
i = 0
while i < m
    dis = reduce(+,map(x->findFuelRec(abs(x-i),0),lines))
    push!(arr2,dis)

    global i+=1
end

min_val2 = reduce(min, arr2)

println("Result of part 2: $min_val2")
