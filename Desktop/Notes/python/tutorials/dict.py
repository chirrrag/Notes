# initialization
d1 = {"Chinu":24, "Megha":29}
d2 = dict()

print(d1)

# append value
d1["Luv"]=30
d1["Hate"]="no"
print(d1)

print(d1["Luv"])
# print(d1['ice'])

# change the value of certain key
d1["Chinu"]= 25
print(d1)

# keys are commonly string or numbers

# iterate over key value pairs
for key, value in d1.items():
    print("Key: ",key, " value: ", value)