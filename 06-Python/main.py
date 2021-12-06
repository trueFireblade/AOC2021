file = open("input.txt","r")
input_ = list(map ((lambda n : int(n)), file.read().replace("\n","").split(",")))

def progressTime2_(hashList, daysLeft):
    oldList = dict(hashList) # Copy by value
    j = 8
    l = oldList[0]
    while j >= 0:
        hashList[j-1] = oldList[j]
        j -= 1
    hashList[8] = l
    hashList[6] += l
    if(daysLeft > 0):
        return progressTime2_(hashList, daysLeft-1)
    j = 8
    acc = 0
    while j >= 0:
        acc += hashList[j]
        j -= 1
    return acc

def progressTime2(list_, daysLeft):
    if(daysLeft == 0):
        return len(list_)
    i = 0
    filterList = {}
    while i < 9:
        filterList[i] = list_.count(i)
        i += 1
    return progressTime2_(filterList, daysLeft-1)

res1 = progressTime2(input_, 80)
print(f"The result of part one is: {res1}")
res2 = progressTime2(input_, 256)
print(f"The result of part two is: {res2}")
