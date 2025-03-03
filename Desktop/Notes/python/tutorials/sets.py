# set is type of data, that stores a set of things
# a set of unique things

# initialize
a = set()
print(a)

a.add(1)
a.add(2)
a.add(2)

print(a)

# iterate over sets
for x in a:
    print(x)

# use case, remove from duplicate element in list
l1 = [1,1,2,34,4,34,2]
new_set = set()
for x in l1:
    new_set.add(x)
print(new_set)

# create new list from set
new_list = list()
for x in new_set:
    new_list.append(x)
print(new_list)


# 

b = set()
b.add('bananna')
b.add('mango')
b.add(1)
print(b)
# order of set is undefined