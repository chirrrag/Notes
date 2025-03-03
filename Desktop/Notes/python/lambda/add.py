def add(a,b):
    return a+b
print(add(2,4))

sub = lambda a,b: a-b
print(sub(4,3))

multiply = lambda x : x*100
print(multiply(100))

print((lambda a,b : a*b)(15,30))


product = lambda x,y,z : x+y-z

print(product(10,20,30))