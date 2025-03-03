
a = [1,3,5,7,9,11]

b = []
for x in a:
    b.append(x*2)
print(b)

# alternate way to do similar is to use list comprehension
c = [x*2 for x in a]
print(c)

e = [x ** 2 for x in range(1,7)]
print(e)

# print list [36,35,16,9,4,1]

for x in range(6,0,-1):
    print(x)

f = []
for x in range(6,0,-1):
    f.append(x**2)
print(f)

# similary way is to use list comprehension
f2 = [x**2 for x in range(6,0,-1)]
print(f2)