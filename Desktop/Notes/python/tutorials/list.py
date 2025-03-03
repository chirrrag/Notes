# list creation

list1 = [1,2,3,4]
print(list1)

# append item to list
list1.append(5)
print(list1)

# we can mix types in a single list
list1.append("hello")
print(list1)

# a list can have other list as well
list1.append([5,6])
print(list1)

# delete item from list
list1.pop()
print(list1)
# pop will remove last element from list

# retrieve element from list
print(list1[2])
# list1[1]

# Change context of list
# lets change first element of list
list1[0] = 'meow'
print(list1)

# swap element from list
l1 = ['banana','apple','mango']
print(l1)
l1[0],l1[2] = l1[2],l1[0]
print(l1)



