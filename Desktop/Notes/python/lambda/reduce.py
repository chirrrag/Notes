from functools import reduce


list1 = [2,5,10,6,4,12]
sum = reduce((lambda x, y:x+y), list1)
print(sum)