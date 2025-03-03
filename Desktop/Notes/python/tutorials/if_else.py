a = 1
b = 2

if a < b:
    print("a is less")

c = 5
d  = 5
if c < d:
    print("c is less than d")
else:
    print("c is greater than d")


e = 9
f = 8
if e < f:
    print("e is small")
elif e == f:
    print("e == f")
else:
    print("e is big")


g = 10
h = 20
if g < h:
    print("g is small")
else:
    if g < h:
        print("g is smale")
    if g == h:
        print("g == h")
    else:
        print("g is big")


var = 10
print(var**2)