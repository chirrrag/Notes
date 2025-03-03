


def func():
    print("aah")
    print("aachu")
    # return "Chinu"
print("outside the function")



# calling the function
func()
print(func()) # it will return some value, ie "NONE" in our case

# a function can also be a mapping
# a function always returns something
def square(x):
    return x**2

ans = square(2)
print(ans)
print(square(3))

# We can also have multiple args to function

def multi(x, y):
    return x*y

e = multi(2,3)
print(e)

def func4(val):
    print(val)
    print("still in function")
    print("return value will be printed only when we print that to a variable")
    return val+val

print("#########################")
print("func4")
sol = func4(10)
# print will print only the return value
print(sol)


def return_val(arg):
    print("arg is ", arg)
    print("Weeeeeeeeeeeeeeeee")

print("---------------------------------------")
print("this function will return None")
solution = return_val("hello darlo")
print("returned val is ", solution)







# convert km to mile
# bmi calculator