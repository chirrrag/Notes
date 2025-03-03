sub_string = lambda string : string in "Welcome to python funciton tutorial"

print(sub_string('java'))
print(sub_string('Welcome'))


num = [10,20,30,40,50,60,70,80]

greater = list(filter(lambda x : x>30, num))
print(greater)


list1 = [10,40,56,27,33,15,7,80]

divide = list(filter(lambda x : x % 4 == 0, list1))
print(divide)

### doble the number
## for double the number, use map function
list2 = [10,20,30,4301,50]
double = list(map(lambda x : x*2, list2))
print(double)

list3 = [10,20,30]
power = list(map(lambda x: x**3, list3))
print(power)

cube = list(map(lambda x : pow(x,3), list3))
print(cube)